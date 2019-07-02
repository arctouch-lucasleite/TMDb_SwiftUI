//
//  MoviesList.swift
//  TMDb2
//
//  Created by Lucas Leite on 27/06/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import SwiftUI

struct MovieRow: View {
    @EnvironmentObject var genres: GenresRequest

    @ObjectBinding var request: ImageRequest

    let movie: Movie

    var detail: MovieDetail {
        MovieDetail(movie: movie)
    }

    var body: some View {
        NavigationButton(destination: detail) {
            request.image
                .resizable()
                .frame(width: 140, height: 100)
                .padding(.trailing)

            VStack(alignment: .leading) {
                Text(movie.title)
                    .padding(.top)

                Text(movie.genres(for: genres.result).formattedString)
                    .font(.footnote)
                    .padding(.bottom)
                    .lineLimit(nil)
            }
            .onAppear(perform: request.makeRequest)
        }
    }

    init(movie: Movie) {
        self.movie = movie
        request = ImageRequest(path: movie.backdropPath)
    }
}

struct UpcomingMoviesList: View {
    @State private var searchText = ""

    @ObjectBinding var request = UpcomingMoviesRequest()

    private var movies: [Movie] {
        searchText.isEmpty ?
            request.result :
            request.result.filter { $0.title.lowercased().contains(searchText.lowercased()) }
    }

    var body: some View {
        VStack {
            TextField($searchText, placeholder: Text("Search Movie"))
                .padding()

            List(movies) { movie in
                MovieRow(movie: movie)
            }
            .onAppear(perform: request.makeRequest)
        }
    }
}

struct UpcomingMoviesListNavigation: View {
    private var tabLabel: some View {
        VStack {
            Image(systemName: "list.bullet")
            Text("Upcoming Movies")
        }
    }

    var body: some View {
        NavigationView {
            UpcomingMoviesList()
                .navigationBarTitle(Text("Upcoming Movies"))
        }
        .tabItemLabel(tabLabel)
    }
}

#if DEBUG
struct MoviesList_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingMoviesListNavigation()
    }
}
#endif
