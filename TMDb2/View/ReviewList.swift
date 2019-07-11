//
//  ReviewList.swift
//  TMDb2
//
//  Created by Lucas Leite on 10/07/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import SwiftUI

struct ReviewRow: View {
    let review: Review

    var body: some View {
        VStack {
            Text(review.author)
                .font(.subheadline)

            Text(review.content)
                .lineLimit(nil)
                .padding()
        }
    }
}

struct ReviewList: View {
    let reviews: [Review]

    var body: some View {
        List(reviews) { review in
            ReviewRow(review: review)
        }
        .listStyle(.plain)
        .frame(height: 300)
    }
}
