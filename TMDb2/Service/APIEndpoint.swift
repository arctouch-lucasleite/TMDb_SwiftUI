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
    case image(_ path: String)
    case upcomingMovies(_ page: Int)
    case movieReviews(_ movie: Movie)
    case tvAiringToday
    case tvShowReviews(_ tvShow: TVShow)
    case similarMovies(_ movie: Movie)
    case similarTVShows(_ tvShow: TVShow)

    var path: String {
        switch self {
        case .genres:
            return "genre/movie/list"
        case .image(let path):
            return path
        case .upcomingMovies:
            return "movie/upcoming"
        case .movieReviews(let movie):
            return "movie/\(movie.id)/reviews"
        case .tvAiringToday:
            return "tv/airing_today"
        case .tvShowReviews(let tvShow):
            return "tv/\(tvShow.id)/reviews"
        case .similarMovies(let movie):
            return "movie/\(movie.id)/similar"
        case .similarTVShows(let tvShow):
            return "tv/\(tvShow.id)/similar"
        }
    }

    var endpoint: String {
        "\(host)\(path)"
    }

    var urlComponents: URLComponents? {
        var components = URLComponents(string: endpoint)
        components?.queryItems = []

        switch self {
        case .image:
            break
        case .upcomingMovies(let page):
            components?.queryItems?.append(URLQueryItem(name: "page", value: "\(page)"))
            fallthrough
        default:
            components?.queryItems?.append(URLQueryItem(name: "api_key", value: "60840c7106624e460b153b6c72073d17"))
        }

        return components
    }

    private var host: String {
        switch self {
        case .image:
            return "https://image.tmdb.org/t/p/w1280"
        default:
            return "https://api.themoviedb.org/3/"
        }
    }
}
