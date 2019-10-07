//
//  TVShowDetail.swift
//  TMDb2
//
//  Created by Lucas Leite on 28/06/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import SwiftUI

struct SimilarTVShowsList: View {
    @ObservedObject var request: SimilarTVShowsRequest

    let tvShow: TVShow

    var body: some View {
        List {
            ForEach(request.result) { tvShow in
                NavigationLink(destination: TVShowDetail(tvShow: tvShow)) {
                    Text(tvShow.name)
                }
            }
        }
        .listStyle(PlainListStyle())
        .frame(height: 300)
    }
}

struct TVShowDetail: View {
    @ObservedObject var imageRequest: ImageRequest
    @ObservedObject var similarTVShowsRequest: SimilarTVShowsRequest
    @ObservedObject var reviewsRequest: TVShowReviewsRequest

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
                    .multilineTextAlignment(.center)

                Text(tvShow.overview)
            }

            Section(header: Text("Similar TV Shows").font(.headline)) {
                SimilarTVShowsList(request: similarTVShowsRequest, tvShow: tvShow)
            }

            Section(header: Text("Reviews").font(.headline)) {
                if reviewsRequest.result.isEmpty {
                    Text("No Reviews available for this TV show")
                } else {
                    ReviewList(reviews: reviewsRequest.result)
                }
            }
        }
        .navigationBarTitle(Text(tvShow.name), displayMode: .inline)
    }

    init(tvShow: TVShow) {
        self.tvShow = tvShow
        imageRequest = ImageRequest(path: tvShow.posterPath ?? "")
        similarTVShowsRequest = SimilarTVShowsRequest(tvShow: tvShow)
        reviewsRequest = TVShowReviewsRequest(tvShow: tvShow)
        imageRequest.makeRequest()
        similarTVShowsRequest.makeRequest()
        reviewsRequest.makeRequest()
    }
}
