//
//  MovieDetail.swift
//  TMDb2
//
//  Created by Lucas Leite on 27/06/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import SwiftUI

struct SimilarMoviesList: View {
    @ObjectBinding var request: SimilarMoviesRequest

    let movie: Movie

    var body: some View {
        List(request.result) { movie in
            NavigationButton(destination: MovieDetail(movie: movie), isDetail: true) {
                Text(movie.title)
            }
        }
        .listStyle(.plain)
        .frame(height: 300)
        .onAppear(perform: request.makeRequest)
    }
}

struct MovieDetail: View {
    @EnvironmentObject var genres: GenresRequest

    @ObjectBinding var imageRequest: ImageRequest
    @ObjectBinding var similarMoviesRequest: SimilarMoviesRequest

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
                    .lineLimit(nil)

                Text(movie.overview)
                    .font(.body)
                    .lineLimit(nil)

                Text(movie.genres(for: genres.result).formattedString)
                    .font(.subheadline)
                    .lineLimit(2)

                Text("Release date: \(movie.releaseDate)")
                    .font(.callout)
                    .padding(.bottom)
            }

            Section(header: Text("Similar Movies").font(.headline)) {
                SimilarMoviesList(request: similarMoviesRequest, movie: movie)
            }
        }
        .onAppear(perform: imageRequest.makeRequest)
        .navigationBarTitle(Text(movie.title), displayMode: .inline)
    }

    init(movie: Movie) {
        self.movie = movie
        imageRequest = ImageRequest(path: movie.posterPath)
        similarMoviesRequest = SimilarMoviesRequest(movie: movie)
    }
}

#if DEBUG
struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetail(movie: Movie(id: 1, title: "", overview: "", posterPath: "", backdropPath: "", releaseDate: "", genreIds: []))
    }
}
#endif
