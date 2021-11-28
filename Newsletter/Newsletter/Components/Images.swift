//
//  Images.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 25/11/2021.
//

import SwiftUI

struct Images: View {
    
    let imageString: String
    let widths: CGFloat?
    let heights: CGFloat?
    let cornersRadius: CGFloat?
    
    var body: some View {
        AsyncImage(url: URL(string: imageString)) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            Color.red
        }
        .frame(width: widths, height: heights)
        .clipShape(RoundedRectangle(cornerRadius: 20.0))
    }
}

struct Images_Previews: PreviewProvider {
    static var previews: some View {
        Images(imageString: "Test", widths: 50, heights: 50, cornersRadius: 20)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
