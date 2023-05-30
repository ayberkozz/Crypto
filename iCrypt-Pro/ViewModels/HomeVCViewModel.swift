//
//  HomeVCViewModel.swift
//  iCrypt-Pro
//
//  Created by Ayberk Öz on 30.05.2023.
//

import Foundation

class HomeVCViewModel {
    
    var onCoinsUpdated: (()->Void)?
    var onErrorMessage: ((CoinServiceError)->Void)?
    
    private(set) var coins: [CoinModel] = [] {
        didSet {
            self.onCoinsUpdated?()
        }
    }

    init() {
        self.fetchCoins()
    }
    
    public func fetchCoins() {
        
        let endpoint = Endpoint.fetchCoins()
        
        CoinService.fetchCoins(with: endpoint) { [weak self] result in
            switch result {
            case .success(let coins):
                self?.coins = coins
            case .failure(let error):
                self?.onErrorMessage? (error)
            }
        }
        
    }
    
}
