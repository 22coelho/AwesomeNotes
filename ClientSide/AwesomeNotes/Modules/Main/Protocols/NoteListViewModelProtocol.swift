//
//  NoteListViewModelProtocol.swift
//  AwesomeNotes
//
//  Created by Tiago Coelho on 16/08/2023.
//

protocol NoteListViewModelProtocol {
    func addNote(title: String,
                 description: String,
                 completion: @escaping (Result<Note, Error>) -> Void)
    
    func deleteNote(at index: Int)
    
    func loadNotes(completion: @escaping (Result<[Note], Error>) -> Void) -> [Note]?
}
