//
//  NoteListView.swift
//  AwesomeNotes
//
//  Created by Tiago Coelho on 16/08/2023.
//

import SwiftUI

struct NoteListView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: NoteListViewModel = NoteListViewModel()
    var authViewModel: AuthenticationViewModelProtocol
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                List {
                    ForEach(viewModel.notes) { note in
                        NavigationLink(destination: NoteDetailView(viewModel: viewModel,
                                                                   note: note)) {
                            HStack {
                                VStack(alignment: .leading,
                                       spacing: Constants.noteElementSpacing) {
                                    Text(note.title)
                                        .font(.headline)
                                    Text(parseCreationDate(note.createdAt))
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .onDelete { offsets in
                        viewModel.deleteNote(at: offsets)
                        
                    }
                }
                .onAppear {
                    viewModel.loadNotes { result in
                        print(result)
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
                Button(action: {
                    authViewModel.logout()
                    dismiss.callAsFunction()
                }) {
                    Text("Logout")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(Constants.Button.cornerRadius)
                }
                .padding(.bottom, Constants.Button.bottomPadding)
            }
        }
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.bottom)
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
        struct Button {
            static let cornerRadius: CGFloat = 10
            static let bottomPadding: CGFloat = 10
        }
        static let toolbarIconSize: CGFloat = 15
        static let noteElementSpacing: CGFloat = 8
        
    }
}


struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        NoteListView(authViewModel: AuthenticationViewModel())
    }
}
