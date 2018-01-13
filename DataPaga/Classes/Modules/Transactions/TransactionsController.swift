//
//  TransactionsController.swift
//  datapaga-ios
//
//  Created by Jonathan Solorzano on 1/3/18.
//  https://www.linkedin.com/in/felixsolorzano
//  Copyright © 2018 datapaga. All rights reserved.
//

import Foundation

public typealias TransactionsCompletion = ((DataPagaObjectListResponse<Transaction>) -> ())?

public class TransactionsController {
    
    public func refundTransaction(details: Refund, completionHandler completion: ((DataPagaObjectResponse<Bool>)->())?) {
        
        let core = DataPagaCore.instance
        
        guard let key = core.key, let secret = core.secret else {
            let exception = DataPagaException(message: "DataPagaException: No key or secret registered", code: "0")
            completion?(.failure(exception))
            return
        }
        
        var params: [String: Any] = [
            "api_key": key,
            "api_secret": secret,
            
        ]
        
        params.merge(details.toJSON()) { (current, _) in current }
        
        let refund: [String: Any] = [
            "refund": params
        ]
        
        Server.request(Endpoints.REFUND_TRANSACTION, method: .post, params: refund) {
            response in
            
            switch response {
            case let .success(data):
                
                do {
                    // Decode data to object
                    let jsonDecoder = JSONDecoder()
                    let request = try jsonDecoder.decode(DataPagaRequestResponse<ChargeResponse>.self, from: data)
                    
                    completion?(.success(request.response.status == "APPROVED"))
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
    
    // MARK: - Create Transaction
    
    /// Creates a charge to the provided customer inside the charge.
    /// - parameters:
    ///     - charge: Charge object to be applied to the account
    ///     - completionHandler: The completion handler to execute wheter success of failure at response.
    /// ## Example usage
    ///     DataPaga.transactions().createTransaction(charge: charge) {
    ///         response in
    ///
    ///         switch response {
    ///         case let .success(charge): print(charge.status)
    ///         case let .failure(exception): print(exception)
    ///         }
    ///     }
    public func createTransaction(charge: Charge, completionHandler completion: ((DataPagaObjectResponse<ChargeResponse>) -> ())?) {
        
        let core = DataPagaCore.instance
        
        guard let key = core.key, let secret = core.secret else {
            let exception = DataPagaException(message: "DataPagaException: No key or secret registered", code: "0")
            completion?(.failure(exception))
            return
        }
        
        var params: [String: Any] = [
            "api_key": key,
            "api_secret": secret
        ]
        
        params.merge(charge.toJSON()) { (current, _) in current }
        
        let accountMovement: [String: Any] = [
            "account_movement": params
        ]
        
        Server.request(Endpoints.CREATE_TRANSACTION, method: .post, params: accountMovement) {
            response in
            
            switch response {
            case let .success(data):
                
                do {
                    // Decode data to object
                    let jsonDecoder = JSONDecoder()
                    let request = try jsonDecoder.decode(DataPagaRequestResponse<ChargeResponse>.self, from: data)
                    
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
    
    // MARK: - Specific Transaction
    
    /// Returns the requested transaction by the provided UUID.
    /// - parameters:
    ///     - uuid: UUID string
    ///     - completionHandler: The completion handler to execute wheter success of failure at response.
    /// ## Example usage
    ///     DataPaga.transactions().getTransaction(uuid: "cd_2c3ceb62eedf3f50a8e8a825cc1cb7") {
    ///         response in
    ///
    ///         switch response {
    ///         case let .success(transaction): print(transaction.id, transaction.totalAmount)
    ///         case let .failure(exception): print(exception)
    ///         }
    ///     }
    public func getTransaction(uuid: String, completionHandler completion: ((DataPagaObjectResponse<Transaction>) -> ())?) {
        
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
        
        let params: [String: Any] = [
            "api_key": key,
            "api_secret": secret
        ]
        
        let accountMovement: [String: Any] = [
            "account_movement": params
        ]
        
        Server.request("\(Endpoints.GET_SPECIFIC_TRANSACTION)/\(uuid)", method: .post, params: accountMovement){
            response in
            
            switch response {
            case let .success(data):
                
                do {
                    // Decode data to object
                    let jsonDecoder = JSONDecoder()
                    let request = try jsonDecoder.decode(DataPagaRequestResponse<Transaction>.self, from: data)
                    
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
    
    // MARK: - Get All Transactions
    
    /// Returns a list of all the transactions made by the account.
    /// - parameters:
    ///     - completionHandler: The completion handler to execute wheter success of failure at response.
    /// ## Example usage
    ///     DataPaga.transactions().getAllTransactions {
    ///         response in
    ///
    ///         switch response {
    ///         case let .success(transactions, detail):
    ///         print(detail.totalCount)
    ///         print(transactions.count)
    ///
    ///         case let .failure(exeption): print(exeption)
    ///         }
    ///     }
    public func getAllTransactions(completionHandler completion: TransactionsCompletion) {
        getAllTransactions(from: nil, to: nil, page: nil, completionHandler: completion)
    }
    
    /// Returns a list of all the transactions made by the account.
    /// - parameters:
    ///     - page: Page to request
    ///     - completionHandler: The completion handler to execute wheter success of failure at response.
    /// ## Example usage
    ///     DataPaga.transactions().getAllTransactions(page: 2) {
    ///         response in
    ///
    ///         switch response {
    ///         case let .success(transactions, detail):
    ///         print(detail.totalCount)
    ///         print(transactions.count)
    ///
    ///         case let .failure(exeption): print(exeption)
    ///         }
    ///     }
    public func getAllTransactions(page: Int, completionHandler completion: TransactionsCompletion) {
        getAllTransactions(from: nil, to: nil, page: page, completionHandler: completion)
    }
    
    /// Returns a list of all the transactions made by the account.
    /// - parameters:
    ///     - startDate: Start date to request
    ///     - endDate: End date to request
    ///     - page: Page to request
    ///     - completionHandler: The completion handler to execute wheter success of failure at response.
    /// ## Example usage
    ///     let dateFormatter = DateFormatter()
    ///     dateFormatter.dateFormat = "yyyy-mm-dd"
    ///
    ///     let startDate = dateFormatter.date(from: "2018-01-01")
    ///     let endDate = dateFormatter.date(from: "2018-01-31")
    ///
    ///     DataPaga.transactions().getAllTransactions(startDate: startDate!, endDate: endDate!, page: 1) {
    ///         response in
    ///
    ///         switch response {
    ///         case let .success(transactions, detail):
    ///         print(detail.totalCount)
    ///         print(transactions.count)
    ///
    ///         case let .failure(exeption): print(exeption)
    ///         }
    ///     }
    public func getAllTransactions(startDate: Date, endDate: Date, page: Int, completionHandler completion: TransactionsCompletion) {
        getAllTransactions(from: startDate, to: endDate, page: page, completionHandler: completion)
    }
    
    private func getAllTransactions(from startDate: Date?, to endDate: Date?, page: Int?, completionHandler completion: TransactionsCompletion) {
        
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        
        if let startDate = startDate {
            let startDate = dateFormatter.string(from: startDate)
            params["start_date"] = startDate
        }
        
        if let endDate = endDate {
            let endDate = dateFormatter.string(from: endDate)
            params["end_date"] = endDate
        }
        
        if let page = page {
            params["page"] = page
        }
        
        let accountMovement: [String: Any] = [
            "account_movement": params
        ]

        Server.request(Endpoints.GET_ALL_TRANSACTIONS, method: .post, params: accountMovement){
            response in
            
            switch response {
            case let .success(data):
                
                do {
                    // Decode data to object
                    let jsonDecoder = JSONDecoder()
                    let pagedTransactions = try jsonDecoder.decode(DataPagaPagedRequestResponse<Transaction>.self, from: data)
                    let responseDetail = try jsonDecoder.decode(RequestDetail.self, from: data)
                    
                    completion?(.success(pagedTransactions.response, responseDetail))
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

