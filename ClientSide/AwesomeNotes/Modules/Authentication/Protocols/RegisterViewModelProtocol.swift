//
//  RegisterViewModelProtocol.swift
//  AwesomeNotes
//
//  Created by Tiago Coelho on 15/08/2023.
//

protocol RegisterViewModelProtocol {
    func register(credentials: UserCredentials,
                  completion: @escaping (Result<AuthResponse, Error>) -> Void)
}
