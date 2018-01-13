//
//  ViewController.swift
//  DataPaga
//
//  Created by felixsolorzano on 01/13/2018.
//  Copyright (c) 2018 felixsolorzano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        
        let startDate = dateFormatter.date(from: "2018-01-01")
        let endDate = dateFormatter.date(from: "2018-01-31")
        
       DataPaga.transactions().getAllTransactions(startDate: startDate!, endDate: endDate!, page: 1) {
           response in
           
           print("\nGET ALL TRANSACTIONS: All params")
           
           switch response {
           case let .success(transactions, detail):
               print("\(detail.totalCount) == \(transactions.count)")
               
           case let .failure(exeption): print(exeption.error.message)
           }
       }
       
       DataPaga.transactions().getAllTransactions(page: 2) {
           response in
           
           print("\nGET ALL TRANSACTIONS: Just page param")
           
           switch response {
           case let .success(transactions, detail):
               print("\(transactions.count) of \(detail.totalCount)")
               
           case let .failure(exeption): print(exeption.error.message)
           }
       }
       
       DataPaga.transactions().getAllTransactions {
           response in
           
           print("\nGET ALL TRANSACTIONS: No params")
           
           switch response {
           case let .success(transactions, detail):
               print("\(detail.totalCount) == \(transactions.count)")
               
           case let .failure(exeption): print(exeption.error.message)
           }
       }
       
       DataPaga.transactions().getTransaction(uuid: "am_a182b5610312f71d") {
           response in
           
           print("\nGET SPECIFIC TRANSACTION")
           
           switch response {
           case let .success(transaction): print(transaction.id, transaction.totalAmount)
           case let .failure(exception): print(exception.error.message)
           }
           
       }
       
       let charge = Charge(firstName: "Marco Aurelio", lastName: "mendoza", websiteUrl: "www.datapaga.com", phone: "768474673", country: "SV", city: "San Salvador ", email: "data000000000000033@datapaga.com", customerIP: "127.0.0.1", region: "CA", zip: "0001", street: "123 MAIN STREETR", totalAmount: "1", productDescription: "varias nenas", cardHolderName: "John Smith", cardNumber: "5555555555554444", cardExpireMonth: "01", cardExpireYear: "23", cardType: "MC", cardSecurityCode: "003")
       
       DataPaga.transactions().createTransaction(charge: charge) {
           response in
           
           print("\nCREATE TRANSACTION")
           
           switch response {
           case let .success(charge): print(charge.status)
           case let .failure(exception): print(exception.error.message)
           }
       }
       
       DataPaga.cards().getCardDetails(uuid: "cd_f012d2a52e1eb118e89fasdasdubiub") {
           response in
           
           print("\nGET CARD DETAILS")
           
           switch response {
           case let .success(card): print(card.cardNumber)
           case let .failure(exception): print(exception.error.message)
           }
       }
       
       DataPaga.cards().getAllCards(page: 0){
           response in
           
           print("\nGET ALL CARDS")
           
           switch response {
           case let .success(cards, detail):
               
               print(detail.totalPages)
               print(cards.count)
               
           case let .failure(exception): print(exception.error.message)
           }
       }
       
       DataPaga.account().getBalance {
           response in
           
           print("\nGET BALANCE")
           
           switch response {
           case let .success(balance): print("\nBalance: \(balance.amount)")
           case let .failure(exception): print(exception.error.message)
           }
       }
        
        let refund = Refund(uuid: "am_38a20609903bafef", description: "Artefacto no funcional.", ip: "127.0.33.01")
        
        DataPaga.transactions().refundTransaction(details: refund) {
            response in
            
            switch response {
            case let .success(refunded): print("\nRefunded: \(refunded)")
            case let .failure(exception): print(exception.error.message)
            }
        }
    }

}
