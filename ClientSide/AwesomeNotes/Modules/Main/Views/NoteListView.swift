//
//  NoteListView.swift
//  AwesomeNotes
//
//  Created by Tiago Coelho on 16/08/2023.
//

import SwiftUI

struct NoteListView: View {
    @ObservedObject var viewModel: NoteListViewModel = NoteListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.notes) { note in
                    NavigationLink(destination: NoteDetailView(note: note)) {
                        HStack {
                            VStack(alignment: .leading,
                                   spacing: Constants.noteElementSpacing) {
                                Text(note.title)
                                    .font(.headline)
                                Text(parseCreationDate(note.createdAt))
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }.background(dragToCenterView(for: note))
                    }
                }
                .onDelete { offsets in
                    viewModel.notes.remove(atOffsets: offsets)
                }
            }
            .onAppear {
                viewModel.loadNotes { result in
                    switch result {
                    case .success(let success):
                        print(success)
                    case .failure(let failure):
                        print(failure)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Notes")
                        .font(.largeTitle)
                        .bold()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddNoteView(viewModel: viewModel)) {
                        Image(systemName: "plus")
                            .font(Font.system(size: Constants.toolbarIconSize,
                                              weight: .semibold))
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
    
    private func dragToCenterView(for note: Note) -> some View {
        let dragGesture = DragGesture()
            .onEnded { value in
                if value.translation.width < -100 {
                    if let index = viewModel.notes.firstIndex(where: { $0.id == note.id }) {
                        viewModel.deleteNote(at: index)
                    }
                }
            }
        
        return Rectangle()
            .opacity(Constants.DragAnimation.opacity)
            .frame(width: Constants.DragAnimation.width)
            .offset(x: Constants.DragAnimation.offset)
            .gesture(dragGesture)
    }
    
    private func parseCreationDate(_ creationDate: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime,
                                       .withFractionalSeconds]
        
        if let date = dateFormatter.date(from: creationDate) {
            let formattedDate = DateFormatter.localizedString(from: date,
                                                              dateStyle: .short,
                                                              timeStyle: .short)
            return formattedDate
        } else {
            return "Invalid Date"
        }
    }
}

extension NoteListView {
    struct Constants {
        struct DragAnimation {
            static let width: CGFloat = 80
            static let offset: CGFloat = -40
            static let opacity: CGFloat = 0
        }
        static let toolbarIconSize: CGFloat = 15
        static let noteElementSpacing: CGFloat = 8
    }
}


struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        NoteListView()
    }
}
