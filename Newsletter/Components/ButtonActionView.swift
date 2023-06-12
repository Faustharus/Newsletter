//
//  ButtonActionView.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 05/06/2023.
//

import SwiftUI

struct ButtonActionView: View {
    
    typealias ActionHandler = () -> Void
    
    let sfSymbols: String
    let actionName: String
    let mainColor: Color
    let handler: ActionHandler
    
    init(sfSymbols: String, actionName: String, mainColor: Color, handler: @escaping ButtonActionView.ActionHandler) {
        self.sfSymbols = sfSymbols
        self.actionName = actionName
        self.mainColor = mainColor
        self.handler = handler
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 7)
                .fill(mainColor.shadow(.drop(color: mainColor, radius: 3, x: 2, y: 2)))
            VStack {
                Button(action: handler) {
                    VStack {
                        Image(systemName: sfSymbols)
                        Text(actionName)
                    }
                }
                .font(.headline)
                .foregroundColor(.white)
            }
        }
        .frame(idealWidth: 100, idealHeight: 65)
    }
}

struct ButtonActionView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonActionView(sfSymbols: "bookmark", actionName: "Save", mainColor: .black) { }
    }
}
