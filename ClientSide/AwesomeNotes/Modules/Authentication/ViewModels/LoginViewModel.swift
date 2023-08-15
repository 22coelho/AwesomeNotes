//
//  LoginViewModel.swift
//  AwesomeNotes
//
//  Created by Tiago Coelho on 15/08/2023.
//

import Foundation
import Alamofire

class LoginViewModel: LoginViewModelProtocol {
    func login(credentials: UserCredentials,
               completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        let url = NSLocalizedString("serverPath", comment: "Path")
        
        AF.request("\(url)/login?username=\(credentials.username)&password=\(credentials.password)",
                   method: .post,
                   encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: AuthResponse.self) { response in
                switch response.result {
                case .success(let authResponse):
                    completion(.success(authResponse))
                case .failure(let error):
                    debugPrint(response)
                    completion(.failure(error))
                }
            }
    }
}
