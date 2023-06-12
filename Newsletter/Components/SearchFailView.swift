//
//  SearchFailView.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 07/06/2023.
//

import SwiftUI

struct SearchFailView: View {
    
    let sfSymbols: String
    let mainMassage: String
    let renderingMode: SymbolRenderingMode
    let renderingColorFirst: Color?
    let renderingColorSecond: Color?
    
    
    var body: some View {
        VStack {
            Image(systemName: sfSymbols)
                .resizable()
                .scaledToFit()
                .frame(width: 50)
                .symbolRenderingMode(renderingMode)
                .foregroundStyle(renderingColorFirst ?? .clear, renderingColorSecond ?? .clear)
            Text(mainMassage)
                .font(.system(size: 18, weight: .bold, design: .serif))
        }
        .padding(.horizontal, 10)
    }
}

struct SearchFailView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFailView(sfSymbols: "magnifyingglass", mainMassage: "No articles has been recently posted about Elon Musk", renderingMode: .palette, renderingColorFirst: .blue, renderingColorSecond: .white)
    }
}
