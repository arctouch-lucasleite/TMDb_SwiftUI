//
//  Genre.swift
//  TMDb2
//
//  Created by Lucas Leite on 28/06/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import Foundation
import SwiftUI

struct Genres: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable, Identifiable {
    let id: Int
    let name: String
}

extension Array where Element == Genre {
    var formattedString: String {
        map { $0.name }.joined(separator: ", ")
    }
}
