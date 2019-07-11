//
//  ContentView.swift
//  TMDb2
//
//  Created by Lucas Leite on 27/06/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var genresRequest = GenresRequest()

    var body: some View {
        TabbedView {
            UpcomingMoviesListNavigation()
                .environmentObject(genresRequest)
                .tag(0)

            TVAiringTodayListNavigation()
                .tag(1)
        }
        .onAppear(perform: genresRequest.makeRequest)
    }
}
