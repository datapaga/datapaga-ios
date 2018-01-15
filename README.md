# DataPaga

[![CI Status](http://img.shields.io/travis/datapaga/DataPaga.svg?style=flat)](https://travis-ci.org/datapaga/datapaga-ios)
[![Version](https://img.shields.io/cocoapods/v/DataPaga.svg?style=flat)](http://cocoapods.org/pods/DataPaga)
[![License](https://img.shields.io/cocoapods/l/DataPaga.svg?style=flat)](http://cocoapods.org/pods/DataPaga)
[![Platform](https://img.shields.io/cocoapods/p/DataPaga.svg?style=flat)](http://cocoapods.org/pods/DataPaga)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 11.0+
- Xcode 9.0+
- Swift 4.0+

## Installation

#### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate DataPaga into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '11.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'DataPaga'
end
```

Then, run the following command:

```bash
$ pod install
```

# Authentication
In order to connect with DataPaga API you must provide an `API Key` and `API Secret`. You must include them in your **Info.plist**

Open your **Info.plist** as source code and add these lines before the closing `</dict>`:

```plist
<key>com.datapaga.api.key</key>
<string>YOUR_KEY</string>
<key>com.datapaga.api.secret</key>
<string>YOUR_SECRET</string>
```


## Anatomy of a response
Our response model is a enumeration with associated values which can be handled using a `switch` statement, for lists of data the `success` case will always come with two values, a list of objects and a paging detail object. For single object response success case will come with a single associated value. The `failure` case will always come with a `DataPagaException` object.

###### List example
```swift
// Get the list of my account cards
DataPaga.cards().getAllCards{
    response in
    
    switch response {
    case let .success(cards, detail):
        print(detail.totalPages)
        print(cards.count)
        
    case let .failure(exception): print(exception.error.message)
    }
}
```

###### Single object example
```swift
DataPaga.cards().getCardDetails(uuid: "cd_2c3ceb62eedf3f50a8e8a825cc1cb7") {
    response in
    
    switch response {
    case let .success(card): print(card.balance)
    case let .failure(exception): print(exception)
    }
}
```
Rather than blocking execution to wait for a response from the server, a `callback` in the form of a closure is specified to handle the response once it’s received. The result is only available inside the scope of a response closure. Any execution contingent on the response or data received from the server must be done within a response closure.

> Networking is done _asynchronously_. Asynchronous programming may be a source of frustration to programmers unfamiliar with the concept, but there are [very good reasons](https://developer.apple.com/library/ios/qa/qa1693/_index.html) for doing it this way.

# DataPaga Modules
DataPaga Library comes with the following modules: Transactions, Cards, Account. Each provide API methods to interact with your data.


## Transactions

#### Get All Transactions
```swift
// Default
func getAllTransactions(completionHandler completion: TransactionsCompletion) -> Void

// Page based
func getAllTransactions(page: Int, completionHandler completion: TransactionsCompletion) -> Void

// Date interval and page number
func getAllTransactions(startDate: Date, endDate: Date, page: Int, completionHandler completion: TransactionsCompletion) -> Void
```

###### Response Handling Example

Handling a response involves two possible cases `success` and `failure`. On success we provide a `[Transaction]` object list and a `RequestDetail` object.

```swift
DataPaga.transactions().getAllTransactions(page: 2) {
    response in

    switch response {
    case let .success(transactions, detail):
    print(detail.totalCount)
    dump(transactions)

    case let .failure(exeption): print(exeption.error.message)
    }
}
```

#### Get Specific Transaction
```swift
func getTransaction(uuid: String, completionHandler completion: ((DataPagaObjectResponse<Transaction>) -> ())?) -> Void
```



###### Response Handling Example

```swift
DataPaga.transactions().getTransaction(uuid: "cd_2c3ceb62eedf3f50a8e8a825cc1cb7") {
    response in
    
    switch response {
    case let .success(transaction): print(transaction.id, transaction.totalAmount)
    case let .failure(exception): print(exception.error.message)
    }
}
```

#### Create Transaction
```swift
func createTransaction(charge: Charge, completionHandler completion: ((DataPagaObjectResponse<ChargeResponse>) -> ())?) -> Void
```

For creating a transaction we require a `Charge` object, this has to be created on your side. 

###### Response Handling Example
```swift
let charge = Charge(firstName: "Marco Aurelio", lastName: "mendoza", websiteUrl: "www.datapaga.com", phone: "768474673", country: "SV", city: "San Salvador ", email: "data000000000000033@datapaga.com", customerIP: "127.0.0.1", region: "CA", zip: "0001", street: "123 MAIN STREETR", totalAmount: "1", productDescription: "varias nenas", cardHolderName: "John Smith", cardNumber: "5555555555554444", cardExpireMonth: "01", cardExpireYear: "23", cardType: "MC", cardSecurityCode: "003")

DataPaga.transactions().createTransaction(charge: charge) {
    response in
    
    switch response {
    case let .success(charge): print(charge.status)
    case let .failure(exception): print(exception.error.message)
    }
}
```
#### Refund Transaction
```swift
func refundTransaction(details: Refund, completionHandler completion: ((DataPagaObjectResponse<Bool>)->())?) -> Void
```

For refunding a transaction we require a `Refund` object, this has to be created on your side. 

###### Response Handling Example
```swift
let refund = Refund(uuid: "am_38a20609903bafef", description: "Item is damaged.", ip: "127.0.33.01")

DataPaga.transactions().refundTransaction(details: refund) {
    response in
    
    switch response {
    case let .success(refunded): print("\nRefunded: \(refunded)")
    case let .failure(exception): print(exception.error.message)
    }
}
```

## Cards

#### Get All Cards
```swift 
// Default
func getAllCards(completionHandler completion: CardsCompletion) -> Void

// Page based
func getAllCards(page: Int, completionHandler completion: CardsCompletion) -> Void
```

###### Response Handling Example

On success we provide a `[Card]` object list and a `RequestDetail` object.
```swift
DataPaga.cards().getAllCards(page: 3){
    response in
    
    switch response {
    case let .success(cards, detail):
        print(detail.totalPages)
        print(cards.count)
        
    case let .failure(exception): print(exception.error.message)
    }
}
```

#### Get Card Details
```swift
func getCardDetails(uuid: String, completionHandler completion: ((DataPagaObjectResponse<Card>)->())?) -> Void
```

###### Response Handling Example
```swift
DataPaga.cards().getCardDetails(uuid: "cd_f012d2a52e1eb118e89fasdasdubiub") {
    response in
    
    switch response {
    case let .success(card): print(card.cardNumber)
    case let .failure(exception): print(exception.error.message)
    }
}
```
## Account

#### Get Account Balance
```swift
func getBalance(completionHandler completion: ((DataPagaObjectResponse<Balance>)->())?)
```

###### Response Handling Example
```swift
DataPaga.account().getBalance {
    response in
    
    switch response {
    case let .success(balance): print("\nBalance: \(balance.amount)")
    case let .failure(exception): print(exception.error.message)
    }
}
```


## Author

DataPaga, dev@datapaga.com

## License

DataPaga is available under the MIT license. See the LICENSE file for more info.
