//
//  AddNoteView.swift
//  AwesomeNotes
//
//  Created by Tiago Coelho on 16/08/2023.
//

import SwiftUI

struct AddNoteView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var description = ""
    @State private var shouldNavigate = false
    var viewModel: NoteListViewModel
    
    var body: some View {
        HStack {
            Form {
                Section() {
                    TextField("Title",
                              text: $title)
                    
                    TextField("Description",
                              text: $description,
                              axis: .vertical)
                }
                
                Section {
                    Button("Save") {
                        viewModel.addNote(title: title,
                                          description: description) { result in
                            switch result {
                            case .success(let success):
                                dismiss.callAsFunction()
                            case .failure(let failure):
                                print(failure)
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Create Note")
        
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView(viewModel: NoteListViewModel())
    }
}
