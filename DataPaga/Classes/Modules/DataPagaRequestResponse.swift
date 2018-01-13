//
//  DataPagaRequestResponse.swift
//  DataPagaApp
//
//  Created by Jonathan Solorzano on 1/8/18.
//  https://www.linkedin.com/in/felixsolorzano
//  Copyright © 2018 Elaniin. All rights reserved.
//

import Foundation

/// DataPaga request response object for single record return
public struct DataPagaRequestResponse<T: Decodable>: Decodable {
    public let response: T
}

/// DataPaga request response object for list of records return
public struct DataPagaPagedRequestResponse<T: Decodable>: Decodable {
    public let response: [T]
}
