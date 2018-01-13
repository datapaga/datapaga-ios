//
//  Core.swift
//  datapaga-ios
//
//  Created by Jonathan Solorzano on 1/3/18.
//  https://www.linkedin.com/in/felixsolorzano
//  Copyright © 2018 datapaga. All rights reserved.
//

import Foundation


/// DataPaga's library core class, handles everything.
class DataPagaCore {
    
    /// DataPaga instance.
    static let instance = DataPagaCore()
    
    /// The API Key for the DataPaga Library.
    let key: String?
    /// The API Secret for the DataPaga Library.
    let secret: String?
    
    /// Transactions module instance.
    let transactionsController: TransactionsController
    /// Cards module instance.
    let cardsController: CardsController
    /// Account module instance.
    let accountController: AccountController
    
    private init() {
        
        self.transactionsController = TransactionsController()
        self.cardsController = CardsController()
        self.accountController = AccountController()
        
        guard let infoURL = Bundle.main.url(forResource: "Info", withExtension: "plist"),
            let infoPlist = readPlist(infoURL),
            let infoPlistKey = infoPlist["com.datapaga.api.key"] as? String,
            let infoPlistSecret = infoPlist["com.datapaga.api.secret"] as? String
            else {
                
                let ex = DataPagaException(message: "API Key or Secret not found at Info.plist", code: "0")
                Logger.log(ex, event: .error)
                
                self.key = nil
                self.secret = nil
                
                return

        }

        self.key = infoPlistKey
        self.secret = infoPlistSecret
    }
    
}


/// Read Plist File.
///
/// - Parameter fileURL: file URL.
/// - Returns: return plist content.
func readPlist(_ fileURL: URL) -> [String: Any]? {
    
    guard fileURL.pathExtension == "plist", let data = try? Data(contentsOf: fileURL) else {
        return nil
    }
    guard let result = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] else {
        return nil
    }
    
    return result
}


