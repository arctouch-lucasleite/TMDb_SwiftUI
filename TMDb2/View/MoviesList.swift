//
//  MoviesList.swift
//  TMDb2
//
//  Created by Lucas Leite on 27/06/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import SwiftUI
import Combine

struct MovieRow: View {
    @EnvironmentObject var genres: GenresRequest
    @ObservedObject var request: ImageRequest

    let movie: Movie

    var detail: some View {
        MovieDetail(movie: movie)
            .environmentObject(genres)
    }

    var body: some View {
        NavigationLink(destination: detail) {
            request.image
                .resizable()
                .frame(width: 140, height: 100)
                .cornerRadius(8)
                .padding(.trailing)

            VStack(alignment: .leading) {
                Text(movie.title)
                    .padding(.top)

                Text(movie.genres(for: genres.result).formattedString)
                    .font(.footnote)
                    .padding(.bottom)

                RatingStar(rating: movie.voteAverage)
            }
        }
    }

    init(movie: Movie) {
        self.movie = movie
        request = ImageRequest(path: movie.backdropPath ?? "")
        request.makeRequest()
    }
}

struct UpcomingMoviesList: View {
    @ObservedObject private var request = UpcomingMoviesRequest()

    var body: some View {
        List {
            ForEach(request.result) { MovieRow(movie: $0) }

            ActivityIndicator()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                // Next page request is triggered when the activity indicator appears
                .onAppear(perform: request.makeRequest)
        }
    }
}

struct UpcomingMoviesListNavigation: View {
    var body: some View {
        NavigationView {
            UpcomingMoviesList()
                .navigationBarTitle("Upcoming Movies")
        }
        .tabItem {
            Image(systemName: "video.fill")
            Text("Upcoming Movies")
        }
    }
}
