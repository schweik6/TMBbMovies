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
    
    // To render the movie list when fetch the datas.
    private var fetchView: AnyView {
        // To check the fetch state.
        switch movieFetcher.state {
        // When the state is .loading, to display the activity indicator.
        case .loading:
            return AnyView(
                LoadingActivityIndicator(style: .large)
            )
        // When the state is .success, to render directly.
        case .success:
            let movies = movieFetcher.movies!
            return AnyView(
                // Loop the movies list, must be inited.
                List(movies.indices, id: \.self) { i in
                    // '>' can useNavigationLink to imply.
                    NavigationLink(destination: MovieDetailView(movieDetail: movies[i])) {
                        // The component view of the movie row.
                        MovieRowView(movieRow: movies[i])
                    }
                    // Remove the top (first) separator line.
                    .listRowSeparator(i==0 ? .hidden : .automatic, edges: .top)
                    // Remove the default row top/bottom paddings.
                    .padding(.vertical, -9.2)
                }
                // To hide the standard system background of the List.
                .scrollContentBackground(.hidden)
                // The same white background.
                .background(.white)
                // Choose the style for the leading alignment.
                .listStyle(.plain)
            )
        }
        
    }
    
    var body: some View {
        // The navigation.
        NavigationStack {
            // The 'to fetch' view.
            fetchView
            // The navigation title.
            .navigationTitle(Text("Popular Movies"))
        }
    }
}

// The preview provider for this view.
struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
