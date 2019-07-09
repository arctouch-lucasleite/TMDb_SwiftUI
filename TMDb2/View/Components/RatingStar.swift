//
//  RatingStar.swift
//  TMDb2
//
//  Created by Lucas Leite on 05/07/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import SwiftUI

struct RatingStar: View {
    let rating: Double

    var body: some View {
        HStack {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)

            if rating.isZero {
                Text("-")
            } else {
                Text("\(rating, specifier: "%g")")
            }
        }
    }
}
