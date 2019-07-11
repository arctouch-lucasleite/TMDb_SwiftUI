//
//  MovieReviewsRequest.swift
//  TMDb2
//
//  Created by Lucas Leite on 09/07/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import Foundation

final class MovieReviewsRequest: APIRequest<Review> {
    let movie: Movie

    init(movie: Movie) {
        self.movie = movie
    }

    override func makeRequest() {
        request = service.requestMovieReviews(for: movie)
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .assign(to: \.result, on: self)
    }
}
