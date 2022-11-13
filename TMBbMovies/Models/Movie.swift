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
    
    // Movie row datas, parsed from the JSON coontents.
    let posterPath, title, tagline: String
}
