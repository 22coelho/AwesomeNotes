//
//  AuthenticationViewModelProtocol.swift
//  AwesomeNotes
//
//  Created by Tiago Coelho on 15/08/2023.
//

protocol AuthenticationViewModelProtocol {
    func login(credentials: UserCredentials,
               completion: @escaping (Result<AuthResponse, Error>) -> Void)
    
    func register(credentials: UserCredentials,
                  completion: @escaping (Result<AuthResponse, Error>) -> Void)
    
    func logout()
}
