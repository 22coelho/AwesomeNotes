//
//  AuthResponse.swift
//  AwesomeNotes
//
//  Created by Tiago Coelho on 15/08/2023.
//

struct AuthResponse: Decodable {
    let access_token: String
    let refresh_token: String
}
