//
//  GenresRequest.swift
//  TMDb2
//
//  Created by Lucas Leite on 28/06/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import Foundation

final class GenresRequest: APIRequest<Genre> {
    override func makeRequest() {
        request = service.requestGenres()
            .compactMap { $0 as? Genres }
            .map { $0.genres }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: \.result, on: self)
    }
}
