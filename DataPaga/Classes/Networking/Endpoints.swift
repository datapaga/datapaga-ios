//
//  Constants.swift
//  datapaga-ios
//
//  Created by Jonathan Solorzano on 1/4/18.
//  https://www.linkedin.com/in/felixsolorzano
//  Copyright © 2018 datapaga. All rights reserved.
//

import Foundation

let BASE_URL_DEV2 = "https://datapaga-staging.herokuapp.com/v1/"
let BASE_URL_DEV1 = "https://datapaga.herokuapp.com/v1/"
let BASE_URL_PROD = "https://api.datapaga.com/v1/"
let BASE_URL = BASE_URL_DEV2

/// Endpoints constants to fetch data from DataPaga.
struct Endpoints {
    
    /// Get all cards endpoint.
    static let GET_ALL_TRANSACTIONS = "\(BASE_URL)account_movements/transaction_history"
    /// Get specific card endpoint.
    static let GET_SPECIFIC_TRANSACTION = "\(BASE_URL)account_movements/transaction_history"
    /// Create transaction endpoint.
    static let CREATE_TRANSACTION = "\(BASE_URL)account_movements/charge"
    /// List all cards endpoint.
    static let LIST_ALL_CARDS = "\(BASE_URL)cards/list"
    /// Get card detail endpoint.
    static let GET_CARD_DETAIL = "\(BASE_URL)cards/detail"
    /// Get account balance enpoint.
    static let GET_ACCOUNT_BALANCE = "\(BASE_URL)stores/balance"
    /// Make a refund
    static let REFUND_TRANSACTION = "\(BASE_URL)account_movements/refund"
}
