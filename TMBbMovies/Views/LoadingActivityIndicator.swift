//
//  LoadingActivityIndicator.swift
//  TMBbMovies
//
//  Created by schweik on 2022/11/15.
//

import SwiftUI

/// The loading activity indicator to display.
struct LoadingActivityIndicator: UIViewRepresentable {
    let style: UIActivityIndicatorView.Style
    
    /// To generate the indicator view to use.
    /// - Parameter context: The UIViewRepresentableContext.
    /// - Returns: The UIActivityIndicatorView.
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    /// When the state is .loading, display the activity indicator, startAnimating.
    /// - Parameters:
    ///   - uiView: The UIActivityIndicatorView
    ///   - context: The UIViewRepresentableContext.
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        uiView.startAnimating()
    }
}
