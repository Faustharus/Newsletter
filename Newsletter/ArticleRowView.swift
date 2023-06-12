//
//  ArticleRowView.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 31/05/2023.
//

import SwiftUI

struct ArticleRowView: View {
    
    let article: Article
    
    @State private var isLoading: Bool = true
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            // MARK: - Article's Image
            AsyncImage(url: article.imageURL) { phase in
                switch phase {
                        
                    case .empty:
                        if isLoading {
                            HStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        } else {
                            ZStack {
                                RoundedRectangle(cornerRadius: 7)
                                    .fill(.gray.opacity(0.3).shadow(.drop(radius: 5)))
                                    .frame(idealWidth: UIScreen.main.bounds.width * 0.9, idealHeight: UIScreen.main.bounds.height * 0.25)
                                HStack {
                                    Spacer()
                                    VStack {
                                        Image(systemName: "photo")
                                            .imageScale(.large)
                                        Text("No Image Provided")
                                            .font(.headline)
                                    }
                                    .frame(idealWidth: UIScreen.main.bounds.width * 0.9, idealHeight: UIScreen.main.bounds.height * 0.25)
                                    .accessibilityElement(children: .ignore)
                                    .accessibilityLabel("No Image Provided")
                                    Spacer()
                                }
                            }
                        }
                        
                    case .success(let image):
                        image.resizable().scaledToFill().clipped().accessibilityAddTraits(.isImage)
                        
                    case .failure:
                        HStack {
                            Spacer()
                            Image(systemName: "photo")
                                .imageScale(.large)
                                .frame(width: 50)
                                .accessibilityAddTraits(.isImage)
                            Spacer()
                        }
                        
                    @unknown default:
                        fatalError()
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.25)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 7))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.isLoading = false
                }
            }
            
            // MARK: - Article's Title + Black Glass Row Line
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 7)
                        .fill(.black.opacity(0.85))
                    
                    VStack {
                        Text(article.title).accessibilityLabel(article.title)
                            .font(.system(size: 14, weight: .medium, design: .default))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.7), radius: 5, x: 2, y: 2)
                            .frame(width: 300)
                            .multilineTextAlignment(.leading)
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 50)
            }
        }
    }
}

struct ArticleRowView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRowView(article: .localJSONData[0])
    }
}
