//
//  TVAiringTodayRequest.swift
//  TMDb2
//
//  Created by Lucas Leite on 28/06/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import Foundation

final class TVAiringTodayRequest: APIRequest<TVShow> {
    override func makeRequest() {
        request = service.requestTvAiringToday()
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: \.result, on: self)
    }
}
