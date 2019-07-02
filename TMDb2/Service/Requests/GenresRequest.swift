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
        service.requestGenres { [unowned self] list in
            self.result = list.genres
        }
    }
}
