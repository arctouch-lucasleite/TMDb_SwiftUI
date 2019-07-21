//
//  ImageRequest.swift
//  TMDb2
//
//  Created by Lucas Leite on 27/06/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

final class ImageRequest: BindableObject {
    var willChange = CurrentValueSubject<Image, Never>(.init(systemName: "photo"))

    var image: Image { willChange.value }

    private var request: Cancellable?

    private let service = APIService()
    private let path: String

    init(path: String) {
        self.path = path
    }

    deinit {
        request?.cancel()
    }

    func makeRequest() {
        request = service.requestPoster(at: path)
            .compactMap { UIImage(data: $0) }
            .map { Image(uiImage: $0) }
            .replaceError(with: Image(systemName: "photo"))
            .receive(on: DispatchQueue.main)
            .assign(to: \.value, on: willChange)
    }
}
