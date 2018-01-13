//
//  CardsController.swift
//  DataPagaApp
//
//  Created by Jonathan Solorzano on 1/9/18.
//  https://www.linkedin.com/in/felixsolorzano
//  Copyright © 2018 Elaniin. All rights reserved.
//

import Foundation

/// Typealias shortcut for `((DataPagaObjectListResponse<Card>)->())?`
public typealias CardsCompletion = ((DataPagaObjectListResponse<Card>)->())?

public class CardsController {
    
    // MARK: - Get Card Details
    
    
    /// Returns the card details from the provided UUID.
    /// - parameters:
    ///     - uuid: Card UUID
    ///     - completionHandler: The completion handler to execute wheter success of failure at response
    /// ## Example usage
    
    ///     DataPaga.cards().getCardDetails(uuid: "cd_2c3ceb62eedf3f50a8e8a825cc1cb7") {
    ///       response in
    ///
    ///           switch response {
    ///           case let .success(card): print(card.balance)
    ///           case let .failure(exception): print(exception)
    ///           }
    ///       }
    public func getCardDetails(uuid: String, completionHandler completion: ((DataPagaObjectResponse<Card>)->())?){
        
        guard !uuid.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty  else {
            let ex = DataPagaException(message: "Invalid UUID", code: "0")
            Logger.log(ex, event: .error)
            completion?(.failure(ex))
            return
        }
        
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
            "card": credentials
        ]
        
        Server.request("\(Endpoints.GET_CARD_DETAIL)/\(uuid)", method: .post, params: params) {
            response in
            
            switch response {
            case let .success(data):

                do {
                    
                    // Decode data to object
                    let jsonDecoder = JSONDecoder()
                    let request = try jsonDecoder.decode(DataPagaRequestResponse<Card>.self, from: data)
                    
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
    
    // MARK: - Get All Cards
    
    /// Returns the first five cards available in the account.
    /// - parameters:
    ///     - completionHandler: The completion handler to execute wheter success of failure at response
    /// ## Example usage
    ///     DataPaga.cards().getAllCards{
    ///         response in
    ///
    ///         switch response {
    ///         case let .success(cards, detail):
    ///             print(detail.totalPages)
    ///             print(cards.count)
    ///
    ///         case let .failure(exception): print(exception)
    ///         }
    ///     }
    public func getAllCards(completionHandler completion: CardsCompletion) {
        self.getCards(page: nil, completionHandler: completion)
    }
    
    /// Returns the list of cards available in the account for the specific page.
    /// - parameters:
    ///     - completionHandler: The completion handler to execute wheter success of failure at response
    /// ## Example usage
    ///     DataPaga.cards().getAllCards(page: 1){
    ///         response in
    ///
    ///         switch response {
    ///         case let .success(cards, detail):
    ///             print(detail.totalPages)
    ///             print(cards.count)
    ///
    ///         case let .failure(exception): print(exception)
    ///         }
    ///     }
    public func getAllCards(page: Int, completionHandler completion: CardsCompletion) {
        self.getCards(page: page, completionHandler: completion)
    }
    

    private func getCards(page: Int?, completionHandler completion: CardsCompletion) {
        
        let core = DataPagaCore.instance
        
        guard let key = core.key, let secret = core.secret else {
            let ex = DataPagaException(message: "No key or secret registered", code: "0")
            Logger.log(ex, event: .error)
            completion?(.failure(ex))
            return
        }
        
        var params: [String: Any] = [
            "api_key": key,
            "api_secret": secret
        ]
        
        // Unwrapping params
        if let page = page {
            params["page"] = page
        }
        
        let card: [String: Any] = [
            "card": params
        ]
        
        Server.request(Endpoints.LIST_ALL_CARDS, method: .post, params: card) {
            response in
            
            switch response {
            case let .success(data):
                
                do {
                    // Decode data to object
                    let jsonDecoder = JSONDecoder()
                    let pagedTransactions = try jsonDecoder.decode(DataPagaPagedRequestResponse<Card>.self, from: data)
                    let responseDetail = try jsonDecoder.decode(RequestDetail.self, from: data)
                    
                    completion?(.success(pagedTransactions.response, responseDetail))
                }
                catch {
                    let ex = DataPagaException(message: "Could not decode JSON", code: "0")
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
