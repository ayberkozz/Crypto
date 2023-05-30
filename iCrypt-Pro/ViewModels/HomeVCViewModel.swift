//
//  HomeVCViewModel.swift
//  iCrypt-Pro
//
//  Created by Ayberk Öz on 30.05.2023.
//

import Foundation
import UIKit

class HomeVCViewModel {
    
    var onCoinsUpdated: (()->Void)?
    var onErrorMessage: ((CoinServiceError)->Void)?
    
    private(set) var AllCoins: [CoinModel] = [] {
        didSet {
            self.onCoinsUpdated?()
        }
    }
    
    private(set) var filteredCoins: [CoinModel] = []

    //MARK: - Life Cycle
    init() {
        self.fetchCoins()
    }
    
    public func fetchCoins() {
        
        let endpoint = Endpoint.fetchCoins()
        
        CoinService.fetchCoins(with: endpoint) { [weak self] result in
            switch result {
            case .success(let coins):
                self?.AllCoins = coins
            case .failure(let error):
                self?.onErrorMessage? (error)
            }
        }
    }
}

extension HomeVCViewModel {
    
    public func inSerchMode(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        
        return isActive && !searchText.isEmpty
    }
    
    
    public func updateSearchController(searchBarText: String?) {
        self.filteredCoins = AllCoins
        
        if let searchText = searchBarText?.lowercased() {
            guard !searchText.isEmpty else {self.onCoinsUpdated?(); return}
            
            self.filteredCoins = self.filteredCoins.filter({
                $0.name.lowercased().contains(searchText)
            })
        }
        self.onCoinsUpdated?()
    }
}

