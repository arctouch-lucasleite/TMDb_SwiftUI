//
//  SimiliarMoviesRequest.swift
//  TMDb2
//
//  Created by Lucas Leite on 28/06/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import Foundation

final class SimilarMoviesRequest: APIRequest<Movie> {
    let movie: Movie

    init(movie: Movie) {
        self.movie = movie
    }

    override func makeRequest() {
        service.requestSimilarMovies(as: movie) { [weak self] response in
            self?.result = response.results
        }
    }
}
