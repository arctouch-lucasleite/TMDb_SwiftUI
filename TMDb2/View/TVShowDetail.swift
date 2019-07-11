//
//  TVShowDetail.swift
//  TMDb2
//
//  Created by Lucas Leite on 28/06/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import SwiftUI

struct SimilarTVShowsList: View {
    @ObjectBinding var request: SimilarTVShowsRequest

    let tvShow: TVShow

    var body: some View {
        List(request.result) { tvShow in
            NavigationLink(destination: TVShowDetail(tvShow: tvShow)) {
                Text(tvShow.name)
            }
        }
        .listStyle(.default)
        .frame(height: 300)
        .onAppear(perform: request.makeRequest)
    }
}

struct TVShowDetail: View {
    @ObjectBinding var imageRequest: ImageRequest
    @ObjectBinding var similarTVShowsRequest: SimilarTVShowsRequest
    @ObjectBinding var reviewsRequest: TVShowReviewsRequest

    let tvShow: TVShow

    var body: some View {
        Form {
            Section {
                imageRequest.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            }

            Section {
                Text(tvShow.name)
                    .font(.largeTitle)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)

                Text(tvShow.overview)
                    .lineLimit(nil)
            }

            Section(header: Text("Similar TV Shows").font(.headline)) {
                SimilarTVShowsList(request: similarTVShowsRequest, tvShow: tvShow)
            }

            Section(header: Text("Reviews").font(.headline)) {
                if reviewsRequest.result.isEmpty {
                    Text("No Reviews available for this movie")
                } else {
                    ReviewList(reviews: reviewsRequest.result)
                }
            }
            .onAppear(perform: reviewsRequest.makeRequest)
        }
        .onAppear(perform: imageRequest.makeRequest)
        .navigationBarTitle(Text(tvShow.name), displayMode: .inline)
    }

    init(tvShow: TVShow) {
        self.tvShow = tvShow
        imageRequest = ImageRequest(path: tvShow.posterPath ?? "")
        similarTVShowsRequest = SimilarTVShowsRequest(tvShow: tvShow)
        reviewsRequest = TVShowReviewsRequest(tvShow: tvShow)
    }
}
