//
//  Member.swift
//  TMBbMovies
//
//  Created by schweik on 2022/11/14.
//

import SwiftUI

/// The model is JSON Decodable and Identifiable.
struct Member: Decodable & Identifiable {
    var id: Int
    
    // Member(like director, writer, cast) datas, parsed from the JSON contents.
    let name: String
}
