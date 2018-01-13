//
//  RequestDetail.swift
//  datapaga-ios
//
//  Created by Jonathan Solorzano on 1/3/18.
//  https://www.linkedin.com/in/felixsolorzano
//  Copyright © 2018 datapaga. All rights reserved.
//

import Foundation

/// Request details object
public class RequestDetail: Decodable {
    
    public let currentPage: Int
    public let nextPage: Int
    public let prevPage: Int
    public let totalPages: Int
    public let totalCount: Int
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.currentPage = try container.decodeIfPresent(Int.self, forKey: .currentPage) ?? 0
        self.nextPage = try container.decodeIfPresent(Int.self, forKey: .nextPage) ?? 0
        self.prevPage = try container.decodeIfPresent(Int.self, forKey: .prevPage) ?? 0
        self.totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages) ?? 0
        self.totalCount = try container.decodeIfPresent(Int.self, forKey: .totalCount) ?? 0
    }
    
    enum CodingKeys : String, CodingKey {
        case currentPage = "current_page"
        case nextPage = "next_page"
        case prevPage = "prev_page"
        case totalPages = "total_pages"
        case totalCount = "total_count"
    }
    
}

