//
//  MovieFetcher.swift
//  TMBbMovies
//
//  The TMDb Movies Fetcher, able to get the data of the TMDb Movies.
//  Created by schweik on 2022/11/12.
//

import Foundation


/// The api load state enum.
enum LoadState {
    case loading
    case success
}

/// To fetch the movie data by requesting api.
/// The ObservableObject conformance allows instances of this class to be used inside views, so that when important changes happen the view will reload.
class MovieFetcher: ObservableObject {
    // The requesting api.
    private static let apiUrlString = "https://cdn.filestackcontent.com/OFI199CwQtC87z7Mp2ep"
    // The movie list results fetched by init.
    // The @Published property wrapper tells SwiftUI that inits/changes to movies should trigger view reloads.
    @Published var movies: [Movie]?
    // The api load state
    @Published var state: LoadState
    
    /// To init property by request.
    init() {
        // To initialized loading state.
        self.state = .loading
        // To request api and load async.
        DispatchQueue.main.async {
            // Load movies property by requesting api.
            self.loadByApi()
            // Finish to load and change the state.
            self.state = .success
        }
    }
    
    /// Load movies property by requesting api.
    private func loadByApi() {
        // The default value.
        self.movies = []
        // Try to get request api url.
        if let apiUrl = URL(string: MovieFetcher.apiUrlString) {
            // Try to request url.
            URLSession.shared.dataTask(with: apiUrl) { (data, res, error) in
                // The api error and print in backend.
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                // Try to read the data.
                guard let data = data else {
                    print("Data fetched failed!")
                    return
                }
                
                // Try to parse JSON.
                do {
                    let decoder = JSONDecoder()
                    // Convert from snake case,eg. poster_path to posterPath.
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    // Try to decode JSON to [Movie].
                    let decodedData = try decoder.decode([Movie].self, from: data)
                    
                    // For: Publishing changes from background threads is not allowed. Async.
                    DispatchQueue.main.async {
                        self.movies = decodedData
                    }
                } catch {
                    print(error)
                }
            }.resume()
        }
    }
}
