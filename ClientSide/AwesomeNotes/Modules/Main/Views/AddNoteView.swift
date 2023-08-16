//
//  AddNoteView.swift
//  AwesomeNotes
//
//  Created by Tiago Coelho on 16/08/2023.
//

import SwiftUI

struct AddNoteView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var shouldNavigate = false
    var viewModel: NoteListViewModel
    
    var body: some View {
        NavigationView {
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
                        viewModel.addNote(title: title, description: description))
                        shouldNavigate = true
                    }
                    ZStack {
                        if shouldNavigate { // next will be instantiated when data got fetched
                            NavigationLink(
                                destination: NoteListView(),
                                isActive: $shouldNavigate,
                                label: {}
                            )
                        }
                    }
                }
            }
            .navigationBarTitle("Create Note")
        }
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView(viewModel: NoteListViewModel())
    }
}
