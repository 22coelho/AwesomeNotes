//
//  LoginModel.swift
//  AwesomeNotes
//
//  Created by Tiago Coelho on 15/08/2023.
//

class LoginModel {
    private var userCredentials: UserCredentials?
    private var authResponse: AuthResponse?
    
    
    init(userCredentials: UserCredentials? = nil, authResponse: AuthResponse? = nil) {
        self.userCredentials = userCredentials
        self.authResponse = authResponse
    }
}
