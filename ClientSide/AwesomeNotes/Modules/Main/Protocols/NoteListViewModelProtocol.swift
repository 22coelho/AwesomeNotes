//
//  NoteListViewModelProtocol.swift
//  AwesomeNotes
//
//  Created by Tiago Coelho on 16/08/2023.
//

import Foundation

protocol NoteListViewModelProtocol {
    func addNote(title: String,
                 description: String,
                 latitude: String?,
                 longitude: String?,
                 completion: @escaping (Result<Note, Error>) -> Void)
    
    func deleteNote(at indexSet: IndexSet)
    
    func deleteNote(noteId: Int)
    
    func loadNotes(completion: @escaping (Result<[Note], Error>) -> Void) -> [Note]?
}
