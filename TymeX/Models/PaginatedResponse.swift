//
//  PaginatedResponse.swift
//  TymeX
//
//  Created by Vinh Tran on 23/9/24.
//

import Foundation

struct PaginatedResponse<T: Decodable>: Decodable {
    let items: [T]
    let nextSince: Int?
    
    enum CodingKeys: String, CodingKey {
        case items
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        items = try container.decode([T].self)
        
        if let lastUser = items.last as? User {
            nextSince = lastUser.id
        } else {
            nextSince = nil
        }
    }
    
    init(items: [T], nextSince: Int?) {
        self.items = items
        self.nextSince = nextSince
    }
}
