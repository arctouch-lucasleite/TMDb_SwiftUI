//
//  TVShowReviewsRequest.swift
//  TMDb2
//
//  Created by Lucas Leite on 10/07/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import Foundation

final class TVShowReviewsRequest: APIRequest<Review> {
    let tvShow: TVShow

    init(tvShow: TVShow) {
        self.tvShow = tvShow
    }

    override func makeRequest() {
        request = service.requestTVShowReviews(for: tvShow)
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: \.result, on: self)
    }
}
