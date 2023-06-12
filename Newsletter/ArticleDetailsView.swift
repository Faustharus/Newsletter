//
//  ArticleDetailsView.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 30/05/2023.
//

import SwiftUI

struct ArticleDetailsView: View {
    
    @EnvironmentObject var bookmarkVM: NewsBookmarkViewModel
    
    let article: Article
    
    @State private var seeArticle: Bool = false
    @State private var isLoading: Bool = true
    @State private var selectedArticle: Article?
    
    var body: some View {
        GeometryReader { geo in
            LazyVStack(alignment: .leading, spacing: 16) {
                
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
                                .frame(idealWidth: geo.size.width, idealHeight: UIScreen.main.bounds.height * 0.25)
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
                                        .frame(idealWidth: geo.size.width, idealHeight: UIScreen.main.bounds.height * 0.25)
                                        .accessibilityElement(children: .ignore)
                                        .accessibilityLabel("No Image Provided")
                                        Spacer()
                                    }
                                }
                            }
                            
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .clipped()
                                .accessibilityAddTraits(.isImage)
                            
                        case .failure:
                            HStack {
                                Spacer()
                                Image(systemName: "photo")
                                    .imageScale(.large)
                                    .accessibilityAddTraits(.isImage)
                                Spacer()
                            }
                            
                        @unknown default:
                            fatalError()
                            
                    }
                }
                .frame(idealWidth: geo.size.width, maxHeight: 200)
                .background(Color.gray.opacity(0.3))
                .clipped()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.isLoading = false
                    }
                }
                
                // MARK: - Descriptive Texts
                Text(article.title).accessibilityLabel(article.title)
                    .font(.system(size: 22, weight: .bold, design: .serif))
                    .lineLimit(3)
                
                Text(article.descriptionText).accessibilityLabel(article.descriptionText)
                    .font(.system(size: 16, weight: .light, design: .default))
                
                Text(article.contentText).accessibilityLabel(article.contentText)
                    .font(.system(size: 14, weight: .medium, design: .default))
                    .lineLimit(2)
                
                
                // MARK: - Action Buttons
                HStack {
                    
                    Spacer()
                    
                    ButtonActionView(sfSymbols: "newspaper", actionName: "Read", mainColor: .black) {
                        self.seeArticle = true
                    }
                    .accessibilityLabel("Read the whole article")
                    .accessibilityAddTraits(.isButton)
                    
                    withAnimation(.spring()) {
                        ButtonActionView(sfSymbols: bookmarkVM.isBookmarked(for: article) ? "bookmark.fill" : "bookmark", actionName: bookmarkVM.isBookmarked(for: article) ? "Saved" : "Save", mainColor: bookmarkVM.isBookmarked(for: article) ? .blue : .black) {
                            toggleBookmark(for: article)
                        }
                        .accessibilityLabel("Save the article")
                        .accessibilityAddTraits(.isButton)
                    }

                    ShareLink(item: article.articleURL) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 7)
                                .fill(.black.shadow(.drop(color: .black, radius: 3, x: 2, y: 2)))
                            VStack {
                                Image(systemName: "square.and.arrow.up")
                                Text("Share")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                        }
                        .frame(idealWidth: 100, idealHeight: 65)
                    }
                    .accessibilityLabel("Share the article to someone")
                    .accessibilityAddTraits(.isButton)

                    
                    Spacer()
                    
                }
                .padding(.vertical, 5)
                
                // MARK: - Author's Name
                HStack {
                    Spacer()
                    if article.author == nil {
                        Text("\(article.authorName)").accessibilityLabel("\(article.authorName)")
                            .font(.subheadline)
                    } else {
                        Text("Written by: \(article.authorName)").accessibilityLabel("Written by \(article.authorName)")
                            .font(.headline)
                    }
                    Spacer()
                }
                
                // MARK: - Read Button Alert + Safari Sheet View
                
            }
            .padding(.horizontal, 10)
            .navigationTitle("\(article.source.name) - \(article.releaseDate)")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: $selectedArticle) {
                SafariView(url: $0.articleURL)
            }
            .alert(isPresented: $seeArticle) {
                Alert(title: Text("You're about to open this article ?"), message: Text("\(article.articleURL)"), primaryButton: .default(Text("Continue"), action: {
                    selectedArticle = article
                }), secondaryButton: .destructive(Text("Cancel"), action: {
                    self.seeArticle = false
                }))
            }
        }
    }
}

struct ArticleDetailsView_Previews: PreviewProvider {
    
    @StateObject static var bookmarkVM = NewsBookmarkViewModel.shared
    
    static var previews: some View {
        NavigationStack {
            ArticleDetailsView(article: .dummyNews[0])
        }
        .environmentObject(bookmarkVM)
    }
}

// MARK: - Functions
extension ArticleDetailsView {
    
    private func toggleBookmark(for article: Article) {
        if bookmarkVM.isBookmarked(for: article) {
            bookmarkVM.removeBookmark(for: article)
        } else {
            bookmarkVM.addBookmark(for: article)
        }
    }
    
}
