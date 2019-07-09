//
//  TVShow.swift
//  TMDb2
//
//  Created by Lucas Leite on 28/06/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import Foundation
import SwiftUI

struct TVShow: Decodable, Identifiable {
    let id: Int
    let name: String
    let overview: String
    let voteAverage: Double
    let posterPath: String?
    let backdropPath: String?
}
