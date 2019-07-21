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
    var willChange = PassthroughSubject<Void, Never>()

    var result: [T] = [] {
        didSet {
            willChange.send()
        }
    }

    /// Keeps a reference to the request and cancels it on deinit
    internal var request: Cancellable?

    let service = APIService()

    deinit {
        request?.cancel()
    }

    func makeRequest() {}
}
