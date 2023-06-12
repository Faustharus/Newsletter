//
//  EntriesSearchListView.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 06/06/2023.
//

import SwiftUI

struct EntriesSearchListView: View  {
    
    @ObservedObject var searchVM: NewsSearchViewModel
    
    let onSubmit: (String) -> Void
    
    init(searchVM: NewsSearchViewModel, onSubmit: @escaping (String) -> Void) {
        self.searchVM = searchVM
        self.onSubmit = onSubmit
    }
    
    var body: some View {
        List {
            if searchVM.searchIn == .names {
                Picker(selection: $searchVM.sortingParam) {
                    ForEach(Sorting.allCases, id: \.self) { item in
                        Text("\(item.sortingName)").tag(item)
                    }
                } label: {
                    Label("Sorting", systemImage: "books.vertical")
                }
                .pickerStyle(.navigationLink)
                .listRowSeparator(.hidden)
                
                withAnimation(.spring()) {
                    DisclosureGroup {
                        DatePicker("From Date", selection: $searchVM.articleFromPreviousDate, in: searchVM.dateRange, displayedComponents: [.date])
                            .datePickerStyle(.graphical)
                    } label: {
                        Label("From Date", systemImage: "calendar")
                    }
                }
                
                withAnimation(.spring()) {
                    DisclosureGroup {
                        DatePicker("To Date", selection: $searchVM.articleToNextDate, in: searchVM.dateRange, displayedComponents: [.date])
                            .datePickerStyle(.graphical)
                    } label: {
                        Label("To Date", systemImage: "calendar")
                    }
                }
                .listRowSeparator(.hidden)
            }
            
            HStack {
                Text("Recently Searched")
                    .font(.headline)
                Spacer()
                Button {
                    searchVM.removeAllEntries()
                } label: {
                    Text("Clear")
                }
                .foregroundColor(.accentColor)
                .disabled(searchVM.entries.isEmpty)
            }
            .listRowSeparator(.hidden)
            
            ForEach(searchVM.entries, id: \.self) { entry in
                Button {
                    onSubmit(entry)
                } label: {
                    Text("\(entry)")
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        searchVM.removeEntry(entry)
                    } label: {
                        Image(systemName: "trash")
                        Text("Delete")
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

struct EntriesSearchListView_Previews: PreviewProvider {
    static var previews: some View {
        EntriesSearchListView(searchVM: NewsSearchViewModel.shared) { _ in }
    }
}
