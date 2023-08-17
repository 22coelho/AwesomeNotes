//
//  LocationError.swift
//  AwesomeNotes
//
//  Created by Tiago Coelho on 17/08/2023.
//

import Foundation

enum LocationError: Error, Identifiable {
    var id: String { localizedDescription }
    
    case permissionDenied
    
    var localizedDescription: String {
        switch self {
        case .permissionDenied:
            return "Location permission denied. Please enable location services in Settings."
        }
    }
}
