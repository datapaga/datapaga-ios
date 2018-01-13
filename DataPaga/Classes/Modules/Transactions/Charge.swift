//
//  Charge.swift
//  DataPagaApp
//
//  Created by Jonathan Solorzano on 1/8/18.
//  https://www.linkedin.com/in/felixsolorzano
//  Copyright © 2018 Elaniin. All rights reserved.
//

import Foundation

public class Charge: Codable {
    
    public let firstName: String
    public let lastName: String
    public let websiteUrl: String
    public let phone: String
    public let country: String
    public let city: String
    public let email: String
    public let customerIP: String
    public let region: String
    public let zip: String
    public let street: String
    public let totalAmount: String
    public let productDescription: String
    public let cardHolderName: String
    public let cardNumber: String
    public let cardExpireMonth: String
    public let cardExpireYear: String
    public let cardType: String
    public let cardSecurityCode: String
    
    public init(
        firstName: String,
        lastName: String,
        websiteUrl: String,
        phone: String,
        country: String,
        city: String,
        email: String,
        customerIP: String,
        region: String,
        zip: String,
        street: String,
        totalAmount: String,
        productDescription: String,
        cardHolderName: String,
        cardNumber: String,
        cardExpireMonth: String,
        cardExpireYear: String,
        cardType: String,
        cardSecurityCode: String) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.websiteUrl = websiteUrl
        self.phone = phone
        self.country = country
        self.city = country
        self.email = email
        self.customerIP = customerIP
        self.region = region
        self.zip = zip
        self.street = street
        self.totalAmount = totalAmount
        self.productDescription = productDescription
        self.cardHolderName = cardHolderName
        self.cardNumber = cardNumber
        self.cardExpireMonth = cardExpireMonth
        self.cardExpireYear = cardExpireYear
        self.cardType = cardType
        self.cardSecurityCode = cardSecurityCode
        
    }

    enum CodingKeys : String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case websiteUrl = "web_site_url"
        case phone
        case country
        case city
        case email
        case customerIP = "customer_ip"
        case region
        case zip
        case street
        case totalAmount = "total_amount"
        case productDescription = "product_description"
        case cardHolderName = "card_holder_name"
        case cardNumber = "card_number"
        case cardExpireMonth = "card_expire_month"
        case cardExpireYear = "card_expire_year"
        case cardType = "card_type"
        case cardSecurityCode = "card_security_code"
    }
    
    func toJSON() -> [String: Any]{
        
        let json: [String: Any] = [
            "first_name": firstName,
            "last_name": lastName,
            "web_site_url": websiteUrl,
            "phone": phone,
            "country": country,
            "city": city,
            "email": email,
            "customer_ip": customerIP,
            "region": region,
            "zip": zip,
            "street": street,
            "total_amount": totalAmount,
            "product_description": productDescription,
            "card_holder_name": cardHolderName,
            "card_number": cardNumber,
            "card_expire_month": cardExpireMonth,
            "card_expire_year": cardExpireYear,
            "card_type": cardType,
            "card_security_code": cardSecurityCode
        ]
        return json
    }
    
}

public struct ChargeResponse: Codable {
    public let status: String
    public let code: String
    public let uuid: String
}


