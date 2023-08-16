//
//  NoteListViewModel.swift
//  AwesomeNotes
//
//  Created by Tiago Coelho on 16/08/2023.
//

import Foundation
import Alamofire

class NoteListViewModel: ObservableObject, NoteListViewModelProtocol {
    @Published var notes: [Note] = []
    
    func addNote(title: String,
                 description: String,
                 completion: @escaping (Result<Note, Error>) -> Void) {
        let url = NSLocalizedString("serverPath", comment: "Path")
        guard let token = getTokenFromUserDefaults(), let username = getUserFromUserDefaults() else {
            return
        }
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        
        let body: [String: String] = [
            "title": title,
            "description": description
        ]
        
        AF.request("\(url)/notes/add?username=\(username)",
                   method: .post,
                   parameters: body,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .validate()
        .responseDecodable(of: Note.self) { response in
            switch response.result {
            case .success(let note):
                self.notes.append(note)
                completion(.success(note))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteNote(at index: Int) {
        if index >= 0 && index < notes.count {
            notes.remove(at: index)
        }
        // need to send to server
    }
    
    func loadNotes(completion: @escaping (Result<[Note], Error>) -> Void) -> [Note]?{
        let url = NSLocalizedString("serverPath", comment: "Path")
        guard let token = getTokenFromUserDefaults() else {
            return nil
        }
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        
        AF.request("\(url)/notes/all",
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .validate()
        .responseDecodable(of: [Note].self) { response in
            switch response.result {
            case .success(let notes):
                self.notes = notes
                print("🍖 Notes appended successfully.")
                completion(.success(notes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        return self.notes
    }
    
    private func getTokenFromUserDefaults() -> String? {
        return UserDefaults.standard.string(forKey: "authToken")
    }
    
    private func getUserFromUserDefaults() -> String? {
        let userDefaults = UserDefaults.standard
        
        if let userCredentials = userDefaults.object(forKey: "userCredentials") as? Data {
            let decoder = JSONDecoder()
            if let loadedCredentials = try? decoder.decode(UserCredentials.self,
                                                           from: userCredentials) {
                
                return loadedCredentials.username
            }
        }
        return nil
    }
}
