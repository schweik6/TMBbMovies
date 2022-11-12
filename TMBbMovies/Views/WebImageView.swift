//
//  WebImageView.swift
//  TMBbMovies
//
//  Created by schweik on 2022/11/12.
//

import SwiftUI
import Combine

// The image view component, load web image.
struct WebImageView: View {
    // To load the data by imageFetcher when updates the data property.
    @ObservedObject var imageFetcher: ImageFetcher
    
    // To init with url.
    init(withURL urlString: String) {
        self.imageFetcher = ImageFetcher(url: urlString)
    }
    
    var body: some View {
        VStack{
            // Is data exists, new Image instance.
            Image(uiImage: imageFetcher.data != nil ? UIImage(data: imageFetcher.data!)! : UIImage())
                // To resize the image, for the use of frame().
                .resizable()
        }
    }
}

// The web image fetcher by requesting url.
class ImageFetcher: ObservableObject {
    // The data of receiving an image request.
    // The @Published property wrapper tells SwiftUI that updates the data variable should trigger view reloads.
    @Published var data: Data?
    
    init(url: String) {
        // string to url
        guard let imageUrl = URL(string: url) else { return }
        // The request of image url.
        let task = URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            guard let data = data else { return }
            // To write data async.
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}
