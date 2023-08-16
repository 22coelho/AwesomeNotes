//
//  NoteListView.swift
//  AwesomeNotes
//
//  Created by Tiago Coelho on 16/08/2023.
//

import SwiftUI

struct NoteListView: View {
    @ObservedObject var viewModel: NoteListViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.notes) { note in
                    NavigationLink(destination: NoteDetailView(note: note)) {
                        HStack {
                            VStack(alignment: .leading,
                                   spacing: 8) {
                                Text(note.title)
                                    .font(.headline)
                                Text(parseCreationDate(note.createdAt))
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }.background(dragToCenterView(for: note))
                    }
                }
                .onDelete(perform: delete)
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
                    Button(action: {
                        // Handle the action you want
                    }) {
                        Image(systemName: "plus")
                            .font(Font.system(size: 15,
                                              weight: .semibold))
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
    
    func delete(at offsets: IndexSet) {
        print("OFFSETS: \(offsets.description)")
        //notes.remove(atOffsets: offsets)
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
            .opacity(0)
            .frame(width: 80)
            .offset(x: -40)
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


struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        NoteListView(viewModel: NoteListViewModel())
    }
}
