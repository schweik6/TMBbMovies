//
//  Movie.swift
//  TMBbMovies
//
//  The basic model of TMDb Movies.
//  Created by schweik on 2022/11/12.
//

import SwiftUI

/// The model is JSON Decodable and Identifiable.
struct Movie: Decodable & Identifiable {
    var id: Int
    
    // Movie row datas, parsed from the JSON contents.
    let posterPath, title, tagline: String
    // Movie detail datas, parsed from the JSON contents(Optional).
    let certification, releaseDate, originalLanguage, overview: String?
    // Movie detail datas, the member model, parsed from the JSON contents.
    let directors, writers, cast: [Member]
}
