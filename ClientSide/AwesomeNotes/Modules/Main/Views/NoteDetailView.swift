//
//  NoteDetailView.swift
//  AwesomeNotes
//
//  Created by Tiago Coelho on 16/08/2023.
//

import SwiftUI
import MapKit

struct NoteDetailView: View {
    @Environment(\.dismiss) var dismiss
    var viewModel: NoteListViewModelProtocol
    var note: Note
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                ItemView(title: "Created at:",
                         content: parseCreationDate(note.createdAt))
                ItemView(title: "Created by:",
                         content: note.username)
                ItemView(title: "Description",
                         content: note.description)
                createMapViewVStack(latitude: note.latitude,
                                    longitude: note.longitude)
                Spacer()
            }
            .padding(.top)
            Spacer()
        }
        .navigationTitle(note.title)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.deleteNote(noteId: note.id)
                    dismiss.callAsFunction()
                }) {
                    Image(systemName: "trash")
                        .font(Font.system(size: Constants.toolbarIconSize,
                                          weight: .semibold))
                }
            }
        }
    }
    
    private func createMapViewVStack(latitude: String?,
                             longitude: String?) -> some View {
        VStack(alignment: .leading,
               spacing: Constants.spacing) {
            if let latitude = Double(latitude ?? ""), let longitude = Double(longitude ?? "") {
                Text("Location")
                    .font(.title2)
                    .foregroundColor(.blue)
                MapView(centerCoordinate: CLLocationCoordinate2D(latitude: latitude,
                                                                 longitude: longitude))
            } else {
                EmptyView()
            }
        }.padding()
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


extension NoteDetailView {
    struct Constants {
        static let toolbarIconSize: CGFloat = 15
        static let spacing: CGFloat = 5
    }
}

struct NoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetailView(viewModel: NoteListViewModel(),
                       note: Note(id: 0,
                                  title: "preview",
                                  description: "description preview",
                                  createdAt: "2023-08-16",
                                  username: "Username preview",
                                  latitude: "37.7749",
                                  longitude: "-122.4194"))
    }
}
