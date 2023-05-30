//
//  CryptoViewModel.swift
//  iCrypt-Pro
//
//  Created by Ayberk Öz on 29.05.2023.
//

import Foundation
import UIKit

class CryptoVCViewModel {
    
    //MARK: - Variables
    let coin: CoinModel
    
    //MARK: - Initializer
    init(_ coin: CoinModel) {
        self.coin = coin
    }

    //MARK: - Computed Properties
    
    var rankLabel: String {
        return "Rank: \(self.coin.rank )"
    }
    
    var priceLabel: String {
        return "Price: \(self.coin.pricingData.CAD.price)"
    }
    
    var marketCapLabel: String {
        return "Market Cap: \(self.coin.pricingData.CAD.market_cap) CAD "
    }
    
    var maxSupplyLabel: String {
        
        if let maxSupply = self.coin.maxSupply {
            return "Max Supply: \(maxSupply)"
        } else {
            return "123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n"
        }
    }
    
}
