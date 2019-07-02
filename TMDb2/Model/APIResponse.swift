//
//  APIResponse.swift
//  TMDb2
//
//  Created by Lucas Leite on 27/06/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import Foundation

struct APIResponse<T: Decodable>: Decodable {
    let page: Int
    let results: [T]
    let totalPages: Int
}
