//
//  DataPagaException.swift
//  datapaga-ios
//
//  Created by Jonathan Solorzano on 1/3/18.
//  https://www.linkedin.com/in/felixsolorzano
//  Copyright © 2018 datapaga. All rights reserved.
//

import Foundation

/// DataPaga exception object.
public class DataPagaException: Decodable {
    
    public let error: DataPagaError
    
    public struct DataPagaError: Decodable {
        public let message: String
        public let code: String
    }
    
    public init(message: String, code: String) {
        let error = DataPagaError(message: message, code: code)
        self.error = error
    }
    
}
