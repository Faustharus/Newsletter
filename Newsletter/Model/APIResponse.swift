//
//  APIResponse.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 28/05/2023.
//

import Foundation

struct APIResponse: Codable, Hashable {
    
    var status: String
    var totalResults: Int
    var articles: [Article]
    
}
