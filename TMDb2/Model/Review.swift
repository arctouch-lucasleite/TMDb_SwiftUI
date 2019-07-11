//
//  Review.swift
//  TMDb2
//
//  Created by Lucas Leite on 09/07/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import Foundation
import SwiftUI

struct Review: Decodable, Identifiable {
    let id: String
    let author: String
    let content: String
    let url: String
}
