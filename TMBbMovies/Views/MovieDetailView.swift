//
//  MovieDetailView.swift
//  TMBbMovies
//
//  Created by schweik on 2022/11/14.
//

import SwiftUI

/// The view of TMDb movie detail, render the movie by the navigation.
struct MovieDetailView: View {
    // The image path prefix.
    private static let imagePathPrefix = "https://image.tmdb.org/t/p/w600_and_h900_bestv2"
    // The realse date string validation length.
    private static let yearValidation = 4
    // The movie data to render this page.
    var movieDetail: Movie
    
    var body: some View {
        // The navigation.
        NavigationStack {
            // The navigation bar border/shadow.
            HStack {
                Color.init(white: 0.9)
            }.frame(height: 1.5)
            
            // To scroll when over the VStack size.
            ScrollView {
                // The vertical layout of the detail data.
                VStack {
                    // The block 1.
                    // Get thumnail by join.
                    let thumnail = MovieDetailView.imagePathPrefix + movieDetail.posterPath
                    // To render the thumnail of the movie at head. 200 height for the UI image design and vertical padding.
                    WebImageView(withURL: thumnail, cropRectCentered: false).scaledToFit().frame(height: 200)
                        .padding(.vertical, 5).shadow(radius: 1)
                    // To render title in horizontal, with diff styles in spacing 5.
                    HStack(spacing: 5) {
                        // The bold movie title.
                        Text(movieDetail.title).font(.system(size: 14, weight: .bold)).shadow(radius: 0.5).lineLimit(1)
                        // The Year of the realse date.
                        if movieDetail.releaseDate != nil &&
                            movieDetail.releaseDate!.count >= MovieDetailView.yearValidation {
                            // To substring and join the year.
                            let releaseYear = "(" + movieDetail.releaseDate!.prefix(MovieDetailView.yearValidation) + ")"
                            Text(releaseYear).font(.system(size: 14)).shadow(radius: 0.5)
                        }
                    }
                    HStack {
                        // To render the 'subheadline'(certification,releaseDate,originalLanguage) of the movie, set the one line limit.
                        Text(getSubheadline()).font(.system(size: 14)).foregroundColor(Color.init(white: 0.65))
                            .padding(.bottom, 5).lineLimit(1)
                    }
                    
                    // The block 2.
                    HStack() {
                        // To render the fixed 'overview' bar.
                        Text("Overview").font(.system(size: 14, weight: .semibold))
                            .padding(.vertical, 5).padding(.horizontal, 21)
                        // Push the Htack to the leading.
                        Spacer()
                    }.background(Color.init(white: 0.9))
                    // To render the movie overview info.
                    HStack() {
                        Text(movieDetail.overview!).font(.system(size: 14, weight: .medium))
                            .padding(.top, 5).padding(.horizontal, 21)
                        // Push the Htack to the leading.
                        Spacer()
                    }
                    // To render the movie roles: directors, writers, cast
                    MovieRoleView(members: movieDetail.directors, roleName: "Director")
                    MovieRoleView(members: movieDetail.writers, roleName: "Writer")
                    MovieRoleView(members: movieDetail.cast, roleName: "Cast")
                    
                    // Push the Vtack to the top.
                    Spacer()
                }
            }
            // The navigation title, display in line.
            .navigationTitle(Text(movieDetail.title))
            .navigationBarTitleDisplayMode(.inline)
            // The navigation bar style.
            .toolbarBackground(.visible , for: .navigationBar)
            .toolbarBackground(.clear , for: .navigationBar)
        }
    }
    
    /// To join the subheadline string.
    /// - Returns: The subheadline string.
    private func getSubheadline() -> String {
        // The subheadline elements string array.
        var subheadlineElements: [String] = []
        // To append first element.
        if movieDetail.certification != nil &&
            !movieDetail.certification!.isEmpty {
            subheadlineElements.append(movieDetail.certification!)
        }
        // To append sec element.
        if movieDetail.releaseDate != nil &&
            !movieDetail.releaseDate!.isEmpty {
            subheadlineElements.append(movieDetail.releaseDate!)
        }
        // To append third element.
        if movieDetail.originalLanguage != nil &&
            !movieDetail.originalLanguage!.isEmpty {
            subheadlineElements.append(movieDetail.originalLanguage!)
        }
        return subheadlineElements.joined(separator: " | ")
    }
}
