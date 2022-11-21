//
//  WebImageView.swift
//  TMBbMovies
//
//  Created by schweik on 2022/11/12.
//

import SwiftUI
import Combine

/// The image view component, load web image.
struct WebImageView: View {
    // To load the data by imageFetcher when updates the data property.
    @ObservedObject var imageFetcher: ImageFetcher
    // Is to crop the rect centered to square.
    var cropRectCentered: Bool
    
    /// To init with url.
    /// - Parameters:
    ///   - urlString: urlString a image url.
    ///   - cropRectCentered: cropRectCentered Is to crop the rect centered to square.
    init(withURL urlString: String, cropRectCentered: Bool) {
        self.imageFetcher = ImageFetcher(url: urlString)
        self.cropRectCentered = cropRectCentered
    }
    
    var body: some View {
        VStack{
            // Is data exists, new Image instance.
            Image(uiImage: imageFetcher.data != nil ?
                  // If the data exists, it will be cropped, like cropping to a square.
                  crop(sourceImage: UIImage(data: imageFetcher.data!)!) : UIImage())
                // To resize the image default, for the use of frame().
                .resizable()
        }
    }
    
    /// To crop image, like cropping to a square, when the property 'cropRectCentered' is true.
    /// - Parameter sourceImage: The source image.
    /// - Returns: The cropped imge.
    private func crop(sourceImage: UIImage) -> UIImage {
        // Is to crop and do this.
        if cropRectCentered {
            // The shortest side
            let sideLength = min(
                sourceImage.size.width,
                sourceImage.size.height
            )
            
            // Determines the x,y coordinate of a centered
            // sideLength by sideLength square
            let sourceSize = sourceImage.size
            let xOffset = (sourceSize.width - sideLength) / 2.0
            let yOffset = (sourceSize.height - sideLength) / 2.0
            
            // The cropRect is the rect of the image to keep,
            // in this case centered
            let cropRect = CGRect(
                x: xOffset,
                y: yOffset,
                width: sideLength,
                height: sideLength
            ).integral
            
            // Center crop the image
            let sourceCGImage = sourceImage.cgImage!
            let croppedCGImage = sourceCGImage.cropping(
                to: cropRect
            )!
            
            // Use the cropped cgImage to initialize a cropped
            // UIImage with the same image scale and orientation
            let croppedImage = UIImage(
                cgImage: croppedCGImage,
                scale: sourceImage.imageRendererFormat.scale,
                orientation: sourceImage.imageOrientation
            )
            return croppedImage
        }
        return sourceImage
    }
}


/// The web image fetcher by requesting url.
class ImageFetcher: ObservableObject {
    // The data of receiving an image request.
    // The @Published property wrapper tells SwiftUI that updates the data variable should trigger view reloads.
    @Published var data: Data?
    
    /// To init fetcher by the url.
    /// - Parameter url: The url string.
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
