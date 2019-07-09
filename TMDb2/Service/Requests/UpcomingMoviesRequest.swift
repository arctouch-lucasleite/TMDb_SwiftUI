//
//  UpcomingMoviesRequest.swift
//  TMDb2
//
//  Created by Lucas Leite on 27/06/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import Foundation

final class UpcomingMoviesRequest: APIRequest<Movie> {
    private(set) var nextPage = 1

    override func makeRequest() {
        request = service.requestUpcomingMovies(at: nextPage)
            .compactMap { $0 as? APIResponse<Movie> }
            .map { $0.results }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] response in
                self?.result.append(contentsOf: response)
                self?.nextPage += 1
            }
    }
}
