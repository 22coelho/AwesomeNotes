//
//  LoginViewModelProtocol.swift
//  AwesomeNotes
//
//  Created by Tiago Coelho on 15/08/2023.
//

protocol LoginViewModelProtocol {
    func login(credentials: UserCredentials,
               completion: @escaping (Result<AuthResponse, Error>) -> Void)
}
