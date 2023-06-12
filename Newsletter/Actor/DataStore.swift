//
//  DataStore.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 06/06/2023.
//

import Foundation

protocol DataStore: Actor {
    // Generic Type
    associatedtype D
    
    func save(_ current: D)
    func load() -> D?
    
}

// Uses a generic type to interact with every model who does possess the Codable Protocol where the model can be compared
actor PlistDataStore<T: Codable>: DataStore where T: Equatable {
    
    typealias D = T
    
    private var saved: T?
    let filename: String
    
    init(filename: String) {
        self.filename = filename
    }
    
    private var dataURL: URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("\(filename).plist")
    }
    
    func save(_ current: D) {
        // If the article is already saved, exit the function
        if let saved = self.saved, saved == current {
            return
        }
        
        do {
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .binary
            let data = try encoder.encode(current)
            try data.write(to: dataURL, options: [.atomic])
            self.saved = current
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func load() -> D? {
        do {
            let data = try Data(contentsOf: dataURL)
            let decoder = PropertyListDecoder()
            let current = try decoder.decode(T.self, from: data)
            self.saved = current
            return current
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
