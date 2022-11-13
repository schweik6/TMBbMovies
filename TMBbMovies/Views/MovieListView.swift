//
//  MovieListView.swift
//  TMBbMovies
//
//  Created by schweik on 2022/11/12.
//

import SwiftUI


/// The view of TMDb movies list, render the list datas.
struct MovieListView: View {
    // To load the data by MovieFetcher when the properties init/change.
    @ObservedObject var movieFetcher = MovieFetcher()
    
    var body: some View {
        NavigationStack {
            // Loop the movies list, must be inited.
            let movies = movieFetcher.movies!
            List(movies.indices, id: \.self) { i in
                // '>' can useNavigationLink to imply.
                NavigationLink(destination: Text("Developing...")) {
                    // The component view of the movie row.
                    MovieRowView(movieRow: movies[i])
                }
                // Remove the top (first) separator line.
                .listRowSeparator(i==0 ? .hidden : .automatic, edges: .top)
                // Remove the default row top/bottom paddings.
                .padding(.vertical, -9.2)
            }.navigationTitle(Text("Popular Movies"))
            // To hide the standard system background of the List.
            .scrollContentBackground(.hidden)
            // The same white background.
            .background(.white)
            // Choose the style for the leading alignment.
            .listStyle(.plain)
        }
    }
}

// The preview provider for this view.
struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
