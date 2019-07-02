//
//  TVAiringTodayList.swift
//  TMDb2
//
//  Created by Lucas Leite on 28/06/19.
//  Copyright © 2019 Lucas Leite. All rights reserved.
//

import SwiftUI

struct TVShowRow: View {
    @ObjectBinding var request: ImageRequest

    let tvShow: TVShow

    var detail: TVShowDetail {
        TVShowDetail(tvShow: tvShow)
    }

    var body: some View {
        NavigationButton(destination: detail) {
            request.image
                .resizable()
                .frame(width: 140, height: 100)
            
            Text(tvShow.name)
                .padding()
        }
        .onAppear(perform: request.makeRequest)
    }

    init(tvShow: TVShow) {
        self.tvShow = tvShow
        request = ImageRequest(path: tvShow.backdropPath ?? "")
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
    var tvAiringTodayTabLabel: some View {
        VStack {
            Image(systemName: "list.bullet")
            Text("TV Airing Today")
        }
    }

    var body: some View {
        NavigationView {
            TVAiringTodayList()
        }
        .tabItemLabel(tvAiringTodayTabLabel)
    }
}

#if DEBUG
struct TVAiringTodayList_Previews: PreviewProvider {
    static var previews: some View {
        TVAiringTodayList()
    }
}
#endif
