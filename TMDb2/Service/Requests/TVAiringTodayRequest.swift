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
        service.requestTvAiringToday { [weak self] response in
            self?.result = response.results
        }
    }
}
