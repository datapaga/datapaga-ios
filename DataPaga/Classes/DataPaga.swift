//
//  DataPaga.swift
//  datapaga-ios
//
//  Created by Jonathan Solorzano on 1/3/18.
//  https://www.linkedin.com/in/felixsolorzano
//  Copyright © 2018 datapaga. All rights reserved.
//

import Foundation


/// Enum to markup a DataPaga server response in single object
public enum DataPagaObjectResponse<T> {
    case success(T)
    case failure(DataPagaException)
}


/// Enum to markup a DataPaga server response in a list with a request detail
public enum DataPagaObjectListResponse<T> {
    case success([T], RequestDetail)
    case failure(DataPagaException)
}


/// A class provided by DataPaga for using the library.
public class DataPaga {
    

    ///  Transactions module with it's functions in DataPaga.
    ///
    ///  - returns: Transactions module instance.
    public class func transactions() -> TransactionsController {
        return DataPagaCore.instance.transactionsController
    }
    
    /// Cards module with it's functions in DataPaga.
    ///
    /// - returns: Cards module instance.
    public class func cards() -> CardsController {
        return DataPagaCore.instance.cardsController
    }
    
    /// Account module with it's functions in DataPaga.
    ///
    /// - returns:
    /// Account module instance.
    public class func account() -> AccountController {
        return DataPagaCore.instance.accountController
    }
    
}


