//
//  TVShowDetail.swift
//  TMDb2
//
//  Created by Lucas Leite on 28/06/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import SwiftUI

struct TVShowDetail : View {
    @ObjectBinding var request: ImageRequest

    let tvShow: TVShow

    var body: some View {
        Form {
            Section {
                request.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            }

            Section {
                Text(tvShow.name)
                    .font(.largeTitle)
                Text(tvShow.overview)
                    .lineLimit(nil)
            }
        }
        .onAppear(perform: request.makeRequest)
        .navigationBarTitle(Text(tvShow.name), displayMode: .inline)
    }

    init(tvShow: TVShow) {
        self.tvShow = tvShow
        request = ImageRequest(path: tvShow.posterPath ?? "")
    }
}

#if DEBUG
struct TVShowDetail_Previews : PreviewProvider {
    static var previews: some View {
        TVShowDetail(tvShow: TVShow(id: 0, name: "", overview: "", posterPath: "", backdropPath: ""))
    }
}
#endif
