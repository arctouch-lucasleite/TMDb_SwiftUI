//
//  UpcomingMoviesRequest.swift
//  TMDb2
//
//  Created by Lucas Leite on 27/06/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import Foundation

final class UpcomingMoviesRequest: APIRequest<Movie> {
    override func makeRequest() {
        service.requestUpcomingMovies { [weak self] response in
            self?.result = response.results
        }
    }
}
