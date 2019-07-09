//
//  SearchMoviesRequest.swift
//  TMDb2
//
//  Created by Lucas Leite on 09/07/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import Foundation

final class SearchMoviesRequest: APIRequest<Movie> {
    var query: String

    init(query: String) {
        self.query = query
    }

    override func makeRequest() {
        request = service.requestSearchMovies(with: query)
            .compactMap { $0 as? APIResponse<Movie> }
            .map { $0.results }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: \.result, on: self)
    }
}
