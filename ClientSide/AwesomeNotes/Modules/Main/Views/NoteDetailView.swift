//
//  NoteDetailView.swift
//  AwesomeNotes
//
//  Created by Tiago Coelho on 16/08/2023.
//

import SwiftUI

struct NoteDetailView: View {
    var note: Note
    var body: some View {
        HStack {
            
        }
        .navigationTitle(note.title)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // Handle the action you want
                }) {
                    Image(systemName: "trash")
                        .font(Font.system(size: Constants.toolbarIconSize,
                                          weight: .semibold))
                }
            }
        }
    }
}

extension NoteDetailView {
    struct Constants {
        static let toolbarIconSize: CGFloat = 15
    }
}

struct NoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetailView(note: Note(title: "preview",
                                  description: "description preview",
                                  createdAt: "2023-08-16",
                                  username: "Username preview"))
    }
}
