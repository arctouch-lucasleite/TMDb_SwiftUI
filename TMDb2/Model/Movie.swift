//
//  Movie.swift
//  TMDb2
//
//  Created by Lucas Leite on 27/06/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import Foundation
import SwiftUI

struct Movie: Decodable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let voteAverage: Double
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    let genreIds: [Int]

    func genres(for allGenres: [Genre]) -> [Genre] {
        var genres: [Genre] = []
        for genre in allGenres {
            if genreIds.contains(genre.id) {
                genres.append(genre)
            }
        }
        return genres
    }
}
