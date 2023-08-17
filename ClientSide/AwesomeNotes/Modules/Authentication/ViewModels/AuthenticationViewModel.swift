//
//  AuthenticationViewModel.swift
//  AwesomeNotes
//
//  Created by Tiago Coelho on 15/08/2023.
//

import Foundation
import Alamofire

class AuthenticationViewModel: AuthenticationViewModelProtocol {
    
    func login(credentials: UserCredentials,
               completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        let url = NSLocalizedString("serverPath", comment: "Path")
        
        AF.request("\(url)/users/login?username=\(credentials.username)&password=\(credentials.password)",
                   method: .post,
                   encoding: JSONEncoding.default)
        .validate()
        .responseDecodable(of: AuthResponse.self) { response in
            switch response.result {
            case .success(let authResponse):
                self.storeUserInfo(credentials)
                self.storeToken(token: authResponse.access_token)
                print("🍖 Username: \(credentials.username)")
                completion(.success(authResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func register(credentials: UserCredentials,
                  completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        let url = NSLocalizedString("serverPath", comment: "Path")
        
        AF.request("\(url)/users/register?username=\(credentials.username)&password=\(credentials.password)",
                   method: .post,
                   encoding: JSONEncoding.default)
        .validate()
        .responseDecodable(of: AuthResponse.self) { response in
            switch response.result {
            case .success(let authResponse):
                self.storeUserInfo(credentials)
                self.storeToken(token: authResponse.access_token)
                completion(.success(authResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func logout() {
        let userDefaults = UserDefaults.standard
        
        userDefaults.removeObject(forKey: "authToken")
        userDefaults.removeObject(forKey: "userCredentials")
    }
    
    // Function used to store user credentials into UserDefaults
    private func storeUserInfo(_ credentials: UserCredentials) {
        let userDefaults = UserDefaults.standard
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(credentials) {
            userDefaults.set(encoded,
                             forKey: "userCredentials")
        }
    }
    
    // Function used to load user credentials stored in UserDefaults
    private func loadUserInfo() -> UserCredentials? {
        let userDefaults = UserDefaults.standard
        
        if let userCredentials = userDefaults.object(forKey: "userCredentials") as? Data {
            let decoder = JSONDecoder()
            if let loadedCredentials = try? decoder.decode(UserCredentials.self,
                                                           from: userCredentials) {
                
                return loadedCredentials
            }
        }
        return nil
    }
    
    // Function to store token into UserDefaults
    private func storeToken(token: String) {
        let userDefaults = UserDefaults.standard
        
        userDefaults.set(token,
                         forKey: "authToken")
    }
}
