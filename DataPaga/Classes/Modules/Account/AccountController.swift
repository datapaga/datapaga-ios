//
//  AccountController.swift
//  DataPagaApp
//
//  Created by Jonathan Solorzano on 1/10/18.
//  https://www.linkedin.com/in/felixsolorzano
//  Copyright © 2018 Elaniin. All rights reserved.
//

import Foundation

/// The middle controller for the Account module between Server and the DataPaga instance.
public class AccountController {
    
    /// Retrieves the account balance inside the provided completion handler.
    /// - parameters:
    ///     - completionHandler: The completion handler to execute wheter success of failure at response
    /// ## Example usage
    ///     DataPaga.account().getBalance {
    ///         response in
    ///
    ///         switch response {
    ///         case let .success(balance): print(balance.amount)
    ///         case let .failure(exception): print(exception.error)
    ///         }
    ///     }
    public func getBalance(completionHandler completion: ((DataPagaObjectResponse<Balance>)->())?) {
        
        let core = DataPagaCore.instance
        
        guard let key = core.key, let secret = core.secret else {
            let ex = DataPagaException(message: "No key or secret registered", code: "0")
            Logger.log(ex, event: .error)
            completion?(.failure(ex))
            return
        }
        
        let credentials: [String: Any] = [
            "api_key": key,
            "api_secret": secret
        ]
        
        let params: [String: Any] = [
            "store": credentials
        ]
        
        Server.request(Endpoints.GET_ACCOUNT_BALANCE, method: .post, params: params) {
            response in
            
            switch response {
            case let .success(data):
                
                do {
                    
                    // Decode data to object
                    let jsonDecoder = JSONDecoder()
                    let request = try jsonDecoder.decode(DataPagaRequestResponse<Balance>.self, from: data)
                    
                    completion?(.success(request.response))
                }
                catch {
                    let ex = DataPagaException(message: "Could not decode response", code: "0")
                    Logger.log(ex, event: .error)
                    completion?(.failure(ex))
                }
                
            case let .failure(ex):
                Logger.log(ex, event: .error)
                completion?(.failure(ex))
            }
            
        }
        
    }
    
}
