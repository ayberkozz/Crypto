//
//  CoinService.swift
//  iCrypt-Pro
//
//  Created by Ayberk Öz on 30.05.2023.
//

import Foundation

enum CoinServiceError: Error{
    case serverError(CoinError)
    case unknown(String = "An unknown error occured")
    case decodingError(String = "Error parsing server response")
}

class CoinService {
    
    static func fetchCoins(with endpoint: Endpoint, completion: @escaping (Result<[CoinModel], CoinServiceError>) -> Void) {
     
        guard let request = endpoint.request else {return}
        
        URLSession.shared.dataTask(with: request) { data, response, err in
            
            if let error = err {
                completion(.failure(.unknown(error.localizedDescription)))
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                 
                do {
                    let coinError = try JSONDecoder().decode(CoinError.self, from: data ?? Data())
                    completion(.failure(.serverError(coinError)))
                    
                } catch let err {
                    completion(.failure(.unknown()))
                    print(err.localizedDescription)
                }
                
            }
            
            if let data = data {
                
                do {
                    let decoder = JSONDecoder()
                    let coinData = try decoder.decode(CoinArray.self, from: data)
                    completion(.success(coinData.data))
                } catch let errr {
                    completion(.failure(.decodingError(errr.localizedDescription)))
                    print(errr.localizedDescription)
                }
                
            } else {
                completion(.failure(.unknown()))
            }
        }.resume()
    }
    
}
