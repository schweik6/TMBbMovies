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
            // To render the thumnail of the movie at head. 55 size crop for the UI image design.
            WebImageView(withURL: thumnail, cropRectCentered: true).frame(width: 55, height: 55)
                // Add trailing padding to the image.
                .padding(.trailing).shadow(radius: 1)
            // The title and tagline of the movie algin lead.
            VStack(alignment: .leading) {
                // To render the title of the movie, set the one line limit.
                Text(movieRow.title).font(.system(size: 16)).fontWeight(Font.Weight.medium).lineLimit(1)
                // Whether to render the tagline will influence the layout.
                if !movieRow.tagline.isEmpty {
                    // To render the tagline of the movie, set the one line limit.
                    Text(movieRow.tagline).font(.system(size: 14)).foregroundColor(Color.init(white: 0.65)).lineLimit(1)
                }
            }
        }
    }
}
