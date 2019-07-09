//
//  TVAiringTodayList.swift
//  TMDb2
//
//  Created by Lucas Leite on 28/06/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import SwiftUI

struct TVShowRow: View {
    static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.decimalSeparator = ","
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    @ObjectBinding var request: ImageRequest

    let tvShow: TVShow

    var detail: TVShowDetail {
        TVShowDetail(tvShow: tvShow)
    }

    var body: some View {
        NavigationLink(destination: detail) {
            request.image
                .resizable()
                .frame(width: 140, height: 100)
                .cornerRadius(8)
                .padding(.trailing)

            VStack(alignment: .leading) {
                Text(tvShow.name)
                RatingStar(rating: tvShow.voteAverage)
            }
        }
    }

    init(tvShow: TVShow) {
        self.tvShow = tvShow
        request = ImageRequest(path: tvShow.backdropPath ?? "")
        request.makeRequest()
    }
}

struct TVAiringTodayList: View {
    @ObjectBinding var request = TVAiringTodayRequest()

    var body: some View {
        List(request.result) { tvShow in
            TVShowRow(tvShow: tvShow)
        }
        .onAppear(perform: request.makeRequest)
        .navigationBarTitle(Text("TV Airing Today"))
    }
}

struct TVAiringTodayListNavigation: View {
    var body: some View {
        NavigationView {
            TVAiringTodayList()
        }
        .tabItem {
            Image(systemName: "tv.fill")
            Text("TV Airing Today")
        }
    }
}

#if DEBUG
struct TVAiringTodayList_Previews: PreviewProvider {
    static var previews: some View {
        TVAiringTodayList()
    }
}
#endif
