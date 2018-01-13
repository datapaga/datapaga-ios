//
//  Refund.swift
//  DataPagaApp
//
//  Created by Jonathan Solorzano on 1/10/18.
//  https://www.linkedin.com/in/felixsolorzano
//  Copyright © 2018 Elaniin. All rights reserved.
//

import Foundation

public class Refund {

    public let uuid: String
    public let refundDescription: String
    public let customerIP: String
    
    public required init(uuid: String, description: String, ip: String){
        self.uuid = uuid
        self.refundDescription = description
        self.customerIP = ip
    }
    
    func toJSON() -> [String: Any] {
        let json: [String: Any] = [
            "uuid": uuid,
            "refund_description": refundDescription,
            "ip_customer": customerIP
        ]
        return json
    }

}
