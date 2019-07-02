//
//  APIRequest.swift
//  TMDb2
//
//  Created by Lucas Leite on 28/06/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import SwiftUI
import Combine

class APIRequest<T: Decodable>: BindableObject {
    var didChange = PassthroughSubject<Void, Never>()

    var result: [T] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.didChange.send(())
            }
        }
    }

    let service = APIService()

    func makeRequest() {}
}
