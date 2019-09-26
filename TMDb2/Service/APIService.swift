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

    private func requestEndpoint(_ endpoint: APIEndpoint) -> AnyPublisher<Data, Never> {
        Just(endpoint.urlComponents)
            .compactMap { $0?.url }
            .flatMap {
                URLSession.shared
                    .dataTaskPublisher(for: $0)
                    // In case of error, returns an empty publisher that completes immediately
                    .catch { _ in Empty() }
            }
            .map { $0.data }
            .eraseToAnyPublisher()
    }

    func requestUpcomingMovies(at page: Int = 1) -> AnyPublisher<[Movie], Error> {
        requestEndpoint(.upcomingMovies(page))
            .decode(type: APIResponse<Movie>.self, decoder: decoder)
            .map { $0.results }
            .eraseToAnyPublisher()
    }

    func requestMovieReviews(for movie: Movie) -> AnyPublisher<[Review], Error> {
        requestEndpoint(.movieReviews(movie))
            .decode(type: APIResponse<Review>.self, decoder: decoder)
            .map { $0.results }
            .eraseToAnyPublisher()
    }

    func requestSimilarMovies(as movie: Movie) -> AnyPublisher<[Movie], Error> {
        requestEndpoint(.similarMovies(movie))
            .decode(type: APIResponse<Movie>.self, decoder: decoder)
            .map { $0.results }
            .eraseToAnyPublisher()
    }

    func requestGenres() -> AnyPublisher<[Genre], Error> {
        requestEndpoint(.genres)
            .decode(type: Genres.self, decoder: decoder)
            .map { $0.genres }
            .eraseToAnyPublisher()
    }

    func requestTvAiringToday() -> AnyPublisher<[TVShow], Error> {
        requestEndpoint(.tvAiringToday)
            .decode(type: APIResponse<TVShow>.self, decoder: decoder)
            .map { $0.results }
            .eraseToAnyPublisher()
    }

    func requestTVShowReviews(for tvShow: TVShow) -> AnyPublisher<[Review], Error> {
        requestEndpoint(.tvShowReviews(tvShow))
            .decode(type: APIResponse<Review>.self, decoder: decoder)
            .map { $0.results }
            .eraseToAnyPublisher()
    }

    func requestSimilarTVShows(as tvShow: TVShow) -> AnyPublisher<[TVShow], Error> {
        requestEndpoint(.similarTVShows(tvShow))
            .decode(type: APIResponse<TVShow>.self, decoder: decoder)
            .map { $0.results }
            .eraseToAnyPublisher()
    }

    func requestPoster(at path: String) -> AnyPublisher<Data, Never> {
        requestEndpoint(.image(path))
    }
}
