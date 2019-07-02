//
//  APIService.swift
//  TMDb2
//
//  Created by Lucas Leite on 27/06/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import Foundation

struct APIService {
    private let decoder = JSONDecoder()

    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    private func requestEndpoint<T: Decodable>(_ endpoint: APIEndpoint, completion: @escaping (T) -> Void) {
        let components = endpoint.urlComponents
        guard let url = components?.url else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let response = try self.decoder.decode(T.self, from: data)
                completion(response)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }

    func requestUpcomingMovies(_ completion: @escaping (APIResponse<Movie>) -> Void) {
        requestEndpoint(.upcomingMovies, completion: completion)
    }

    func requestSimilarMovies(as movie: Movie, _ completion: @escaping (APIResponse<Movie>) -> Void) {
        requestEndpoint(.similarMovies(movie), completion: completion)
    }

    func requestGenres(_ completion: @escaping (Genres) -> Void) {
        requestEndpoint(.genres, completion: completion)
    }

    func requestTvAiringToday(_ completion: @escaping (APIResponse<TVShow>) -> Void) {
        requestEndpoint(.tvAiringToday, completion: completion)
    }

    func requestPoster(at path: String, _ completion: @escaping (Data) -> Void) {
        let path = "https://image.tmdb.org/t/p/w1280\(path)"

        guard let url = URL(string: path) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            completion(data)
        }.resume()
    }
}
