//
//  Card.swift
//  DataPagaApp
//
//  Created by Jonathan Solorzano on 1/9/18.
//  https://www.linkedin.com/in/felixsolorzano
//  Copyright © 2018 Elaniin. All rights reserved.
//

import Foundation

public class Card: Codable {
    
    /// Card UUID
    public let uuid: String
    /// Card status
    public let status: String
    /// Card expiration date
    public let expirationDate: String
    /// Card emboss name
    public let embossName: String
    /// Card number
    public let cardNumber: String
    /// Card order status
    public let orderStatus: String
    /// Card ID
    public let cardID: String
    /// Main account card
    public let cardDefault: Bool
    /// Card balance
    public let balance: String
    /// Card description
    public let description: String
    /// Has a custom transfer schedule
    public let customTransferSchedule: Bool
    /// Days to expire
    public let days: String
    /// Property to know if card is suspended
    public let suspended: Bool
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.uuid = try container.decodeIfPresent(String.self, forKey: .uuid) ?? ""
        self.status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        self.expirationDate = try container.decodeIfPresent(String.self, forKey: .expirationDate) ?? ""
        self.embossName = try container.decodeIfPresent(String.self, forKey: .embossName) ?? ""
        self.cardNumber = try container.decodeIfPresent(String.self, forKey: .cardNumber) ?? ""
        self.orderStatus = try container.decodeIfPresent(String.self, forKey: .orderStatus) ?? ""
        self.cardID = try container.decodeIfPresent(String.self, forKey: .cardID) ?? ""
        self.cardDefault = try container.decodeIfPresent(Bool.self, forKey: .cardDefault) ?? false
        self.balance = try container.decodeIfPresent(String.self, forKey: .balance) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.customTransferSchedule = try container.decodeIfPresent(Bool.self, forKey: .customTransferSchedule) ?? false
        self.days = try container.decodeIfPresent(String.self, forKey: .days) ?? ""
        self.suspended = try container.decodeIfPresent(Bool.self, forKey: .suspended) ?? false
    }
    
    enum CodingKeys : String, CodingKey {
        case uuid
        case status
        case expirationDate = "expiration_date"
        case embossName = "emboss_name"
        case cardNumber = "card_number"
        case orderStatus = "order_status"
        case cardID = "card_id"
        case cardDefault = "card_default"
        case balance
        case description
        case customTransferSchedule = "type_of_transfer"//"custom_transfer_schedule"
        case days
        case suspended
    }
    
}
