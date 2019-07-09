//
//  APIService.swift
//  TMDb2
//
//  Created by Lucas Leite on 27/06/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import Combine
import Foundation

struct APIService {
    private let decoder = JSONDecoder()

    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    private func requestEndpoint<T: Decodable>(_ type: T.Type, _ endpoint: APIEndpoint) -> some Publisher {
        Just(endpoint.urlComponents)
            .compactMap { $0?.url }
            .flatMap {
                URLSession.shared
                    .dataTaskPublisher(for: $0)
                    .catch { _ in Publishers.Empty() }
            }
            .map { $0.data }
            .decode(type: type, decoder: decoder)
    }

    func requestUpcomingMovies(at page: Int = 1) -> some Publisher {
        requestEndpoint(APIResponse<Movie>.self, .upcomingMovies(page))
    }

    func requestSearchMovies(with query: String) -> some Publisher {
        requestEndpoint(APIResponse<Movie>.self, .searchMovies(query))
    }

    func requestSimilarMovies(as movie: Movie) -> some Publisher {
        requestEndpoint(APIResponse<Movie>.self, .similarMovies(movie))
    }

    func requestGenres() -> some Publisher {
        requestEndpoint(Genres.self, .genres)
    }

    func requestTvAiringToday() -> some Publisher {
        requestEndpoint(APIResponse<TVShow>.self, .tvAiringToday)
    }

    func requestSimilarTVShows(as tvShow: TVShow) -> some Publisher {
        requestEndpoint(APIResponse<TVShow>.self, .similarTVShows(tvShow))
    }

    func requestPoster(at path: String) -> some Publisher {
        Just("https://image.tmdb.org/t/p/w1280\(path)")
            .compactMap { URL(string: $0) }
            .flatMap {
                URLSession.shared
                    .dataTaskPublisher(for: $0)
                    .assertNoFailure()
            }
            .map { $0.data }
    }
}
