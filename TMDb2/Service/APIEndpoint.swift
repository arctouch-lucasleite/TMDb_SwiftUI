//
//  APIEndpoint.swift
//  TMDb2
//
//  Created by Lucas Leite on 28/06/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import Foundation

enum APIEndpoint {
    case genres
    case upcomingMovies
    case tvAiringToday
    case similarMovies(_ movie: Movie)

    var path: String {
        switch self {
        case .genres:
            return "genre/movie/list"
        case .upcomingMovies:
            return "movie/upcoming"
        case .tvAiringToday:
            return "tv/airing_today"
        case .similarMovies(let movie):
            return "movie/\(movie.id)/similar"
        }
    }

    var endpoint: String {
        "https://api.themoviedb.org/3/\(path)"
    }

    var urlComponents: URLComponents? {
        var components = URLComponents(string: endpoint)
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: "60840c7106624e460b153b6c72073d17")
        ]
        return components
    }
}
