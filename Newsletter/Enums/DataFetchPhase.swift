//
//  DataFetchPhase.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 31/05/2023.
//

import Foundation

enum DataFetchPhase<T> {
    
    case empty
    case success(T)
    case failure(Error)
    
}
