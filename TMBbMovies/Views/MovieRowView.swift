//
//  MovieRowView.swift
//  TMBbMovies
//
//  Created by schweik on 2022/11/12.
//

import SwiftUI

/// The component view of MovieList view, render one row of a movie.
struct MovieRowView: View {
    // The image path prefix.
    private static let imagePathPrefix = "https://image.tmdb.org/t/p/w600_and_h900_bestv2"
    // The movie data of one row.
    var movieRow: Movie
    
    var body: some View {
        // The horizontal layout of one row.
        HStack {
            // Get thumnail by join.
            let thumnail = MovieRowView.imagePathPrefix + movieRow.posterPath
            // To render the thumnail of the movie at head. 55 size in the UI image file.
            WebImageView(withURL: thumnail, cropRectCentered: true).scaledToFit().frame(width: 55, height: 55)
            // The title and tagline of the movie algin lead.
            VStack(alignment: .leading) {
                // To render the title of the movie.
                Text(movieRow.title)
                // To render the tagline of the movie.
                Text(movieRow.tagline).font(.caption)
            }
        }.frame(height: 38)
    }
}
