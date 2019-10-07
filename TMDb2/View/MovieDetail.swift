//
//  MovieDetail.swift
//  TMDb2
//
//  Created by Lucas Leite on 27/06/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import SwiftUI

struct SimilarMoviesList: View {
    @EnvironmentObject var genresRequest: GenresRequest

    @ObservedObject var request: SimilarMoviesRequest

    let movie: Movie

    var body: some View {
        List(request.result) { movie in
            NavigationLink(destination: self.detail(for: movie)) {
                Text(movie.title)
            }
        }
        .listStyle(PlainListStyle())
        .frame(height: 300)
    }

    func detail(for movie: Movie) -> some View {
        MovieDetail(movie: movie)
            .environmentObject(genresRequest)
    }
}

struct MovieDetail: View {
    @EnvironmentObject var genres: GenresRequest

    @ObservedObject var imageRequest: ImageRequest
    @ObservedObject var similarMoviesRequest: SimilarMoviesRequest
    @ObservedObject var reviewsRequest: MovieReviewsRequest

    let movie: Movie

    var body: some View {
        Form {
            Section {
                imageRequest.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            }

            Section {
                Text(movie.title)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)

                Text(movie.overview)
                    .font(.body)

                Text(movie.genres(for: genres.result).formattedString)
                    .font(.subheadline)
                    .lineLimit(2)

                Text("Release date: \(movie.releaseDate)")
                    .font(.callout)
                    .padding(.bottom)
            }

            Section(header: Text("Similar Movies").font(.headline)) {
                SimilarMoviesList(request: similarMoviesRequest, movie: movie)
                    .environmentObject(genres)
            }

            Section(header: Text("Reviews").font(.headline)) {
                if reviewsRequest.result.isEmpty {
                    Text("No Reviews available for this movie")
                } else {
                    ReviewList(reviews: reviewsRequest.result)
                }
            }
        }
        .navigationBarTitle(Text(movie.title), displayMode: .inline)
    }

    init(movie: Movie) {
        self.movie = movie
        imageRequest = ImageRequest(path: movie.posterPath ?? "")
        similarMoviesRequest = SimilarMoviesRequest(movie: movie)
        reviewsRequest = MovieReviewsRequest(movie: movie)
        imageRequest.makeRequest()
        similarMoviesRequest.makeRequest()
        reviewsRequest.makeRequest()
    }
}
