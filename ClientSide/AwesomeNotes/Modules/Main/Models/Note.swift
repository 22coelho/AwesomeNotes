//
//  Note.swift
//  AwesomeNotes
//
//  Created by Tiago Coelho on 16/08/2023.
//

import Foundation

struct Note: Identifiable, Codable {
    let id = UUID()
    let title: String
    let description: String
    let createdAt: String
    let username: String
}
