//
//  Balance.swift
//  DataPagaApp
//
//  Created by Jonathan Solorzano on 1/10/18.
//  https://www.linkedin.com/in/felixsolorzano
//  Copyright © 2018 Elaniin. All rights reserved.
//

import Foundation

/// Balance object
public struct Balance: Codable {
    
    /// Balance amount with format `$__.__`
    public let amount: String

    enum CodingKeys : String, CodingKey {
        case amount = "balance"
    }
    
}
