//
//  MovieListView.swift
//  TMBbMovies
//
//  Created by schweik on 2022/11/12.
//

import SwiftUI

// The view of TMDb movies list, render the list datas.
struct MovieListView: View {
    // To load the data by MovieFetcher when the properties init/change.
    @ObservedObject var movieFetcher = MovieFetcher()
    
    var body: some View {
        // loop the movies list, must be inited.
        List(movieFetcher.movies!) { movie in
            NavigationLink(destination: Text("test")) {
                MovieRowView(movieRow: movie)
            }
        }.navigationTitle(Text("Popular Movies"))
    }
}

// The preview provider for this view.
struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
