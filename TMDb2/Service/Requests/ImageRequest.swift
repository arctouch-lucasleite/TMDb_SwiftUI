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
    var didChange = PassthroughSubject<Void, Never>()

    let service = APIService()
    let path: String

    var image = Image(systemName: "photo") {
        didSet {
            DispatchQueue.main.async {
                self.didChange.send(())
            }
        }
    }

    init(path: String) {
        self.path = path
    }

    func makeRequest() {
        service.requestPoster(at: path) { data in
            guard let uiImage = UIImage(data: data) else { return }
            self.image = Image(uiImage: uiImage)
        }
    }
}
