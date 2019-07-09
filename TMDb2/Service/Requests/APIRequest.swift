//
//  APIRequest.swift
//  TMDb2
//
//  Created by Lucas Leite on 28/06/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import Combine
import SwiftUI

class APIRequest<T: Decodable>: BindableObject {
    var didChange = PassthroughSubject<Void, Never>()

    var request: Cancellable?

    @Published var result: [T] = [] {
        didSet {
            didChange.send()
        }
    }

    let service = APIService()

    deinit {
        request?.cancel()
    }

    func makeRequest() {}
}
