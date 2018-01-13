//
//  Transaction.swift
//  datapaga-ios
//
//  Created by Jonathan Solorzano on 1/3/18.
//  https://www.linkedin.com/in/felixsolorzano
//  Copyright © 2018 datapaga. All rights reserved.
//

import Foundation

public class Transaction: Codable {
    
    public let id: Int
    public let confirmationNumber: String
    public let transactionID: String
    public let merchantID: String
    public let terminalID: String
    public let totalAmount: Int
    public let paymentStatus: String
    public let code: String
    public let description: String
    public let transactionTime: String
    public let storeID: Int
    /// Date of creation: UTC Formatted
    public let createdAt: String //UTC
    /// Date updated: UTC Formatted
    public let updatedAt: String //UTC
    public let clientEmail: String
    public let street: String
    public let country: String
    public let city: String
    public let zip: String
    public let region: String
    public let customerIP: String
    public let createdDate: String
    public let transactionDescription: String
    public let uuid: String
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        self.confirmationNumber = try container.decodeIfPresent(String.self, forKey: .confirmationNumber) ?? ""
        self.transactionID = try container.decodeIfPresent(String.self, forKey: .transactionID) ?? ""
        self.merchantID = try container.decodeIfPresent(String.self, forKey: .merchantID) ?? ""
        self.terminalID = try container.decodeIfPresent(String.self, forKey: .terminalID) ?? ""
        self.totalAmount = try container.decodeIfPresent(Int.self, forKey: .totalAmount) ?? -1
        self.paymentStatus = try container.decodeIfPresent(String.self, forKey: .paymentStatus) ?? ""
        self.code = try container.decodeIfPresent(String.self, forKey: .code) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.transactionTime = try container.decodeIfPresent(String.self, forKey: .transactionTime) ?? ""
        self.storeID = try container.decodeIfPresent(Int.self, forKey: .storeID) ?? -1
        self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
        self.updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt) ?? ""
        self.clientEmail = try container.decodeIfPresent(String.self, forKey: .clientEmail) ?? ""
        self.street = try container.decodeIfPresent(String.self, forKey: .street) ?? ""
        self.country = try container.decodeIfPresent(String.self, forKey: .country) ?? ""
        self.city = try container.decodeIfPresent(String.self, forKey: .city) ?? ""
        self.zip = try container.decodeIfPresent(String.self, forKey: .zip) ?? ""
        self.region = try container.decodeIfPresent(String.self, forKey: .region) ?? ""
        self.customerIP = try container.decodeIfPresent(String.self, forKey: .customerIP) ?? ""
        self.createdDate = try container.decodeIfPresent(String.self, forKey: .createdDate) ?? ""
        self.transactionDescription = try container.decodeIfPresent(String.self, forKey: .transactionDescription) ?? ""
        self.uuid = try container.decodeIfPresent(String.self, forKey: .uuid) ?? ""
    }
    
    enum CodingKeys : String, CodingKey {
        case id
        case confirmationNumber = "confirmation_number"
        case transactionID = "transaction_id"
        case merchantID = "merchant_id"
        case terminalID = "terminal_id"
        case totalAmount = "total_amount"
        case paymentStatus = "payment_status"
        case code
        case description
        case transactionTime = "transaction_time"
        case storeID = "store_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case clientEmail = "client_email"
        case street
        case country
        case city
        case zip
        case region
        case customerIP = "customer_id"
        case createdDate = "created_date"
        case transactionDescription = "transaction_description"
        case uuid
    }
    
}
