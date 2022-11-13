//
//  MovieFetcher.swift
//  TMBbMovies
//
//  The TMDb Movies Fetcher, able to get the data of the TMDb Movies.
//  Created by schweik on 2022/11/12.
//

import Foundation

/// To mock the fetcher api for extendance, but use local variable to store the movies data in this easy level.
/// The ObservableObject conformance allows instances of this class to be used inside views, so that when important changes happen the view will reload.
class MovieFetcher: ObservableObject {
    // The file name of JSON
    private static let fileName = "TMDbMovies"
    
    // The movie list results fetched by init.
    // The @Published property wrapper tells SwiftUI that inits/changes to movies should trigger view reloads.
    @Published var movies: [Movie]?
    
    /// To mock init property by request.
    init() {
        // Load movies property By local JSON file.
        loadByLocal()
    }
    
    /// Load movies property By local JSON file.
    private func loadByLocal() {
        // Try to read local file data.
        if let fileData = readLocalFile(forName: MovieFetcher.fileName) {
            do {
                let decoder = JSONDecoder()
                // Convert from snake case,eg. poster_path to posterPath.
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                // Try to decode JSON to [Movie].
                let decodedData = try decoder.decode([Movie].self, from: fileData)
                
                self.movies = decodedData
            } catch {
                print(error)
            }
        }
    }
    
    
    /// Read the local file and return the data of the file.
    /// - Parameter name: The file name.
    /// - Returns: The file data.
    private func readLocalFile(forName name: String) -> Data? {
        do {
            // Find the file.
            if let fileUrl = Bundle.main.url(forResource: name, withExtension: "json"),
               // Load the file into a string, get the data.
               let fileData = try String(contentsOf: fileUrl).data(using: .utf8) {
                return fileData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}
