//
//  SimilarTVShowsRequest.swift
//  TMDb2
//
//  Created by Lucas Leite on 03/07/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import Foundation

final class SimilarTVShowsRequest: APIRequest<TVShow> {
    let tvShow: TVShow

    init(tvShow: TVShow) {
        self.tvShow = tvShow
    }

    override func makeRequest() {
        request = service.requestSimilarTVShows(as: tvShow)
            .compactMap { $0 as? APIResponse<TVShow> }
            .map { $0.results }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: \.result, on: self)
    }
}
