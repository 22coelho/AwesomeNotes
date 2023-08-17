//
//  AddNoteView.swift
//  AwesomeNotes
//
//  Created by Tiago Coelho on 16/08/2023.
//

import SwiftUI
import CoreLocation

struct AddNoteView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var description = ""
    @State private var shouldNavigate = false
    @State private var showErrorDialog = false
    
    @StateObject private var locationManager = LocationManager()
    
    var viewModel: NoteListViewModel
    
    var isButtonDisabled: Bool {
        return title.isEmpty || description.isEmpty
    }
    
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
                        addNote()
                    }.disabled(isButtonDisabled)
                }
            }
        }
        .alert(isPresented: $showErrorDialog) {
            Alert(title: Text("Error"),
                  message: Text("There was a error creating your note."),
                  dismissButton: .default(Text("Try again")))
        }
        .navigationBarTitle("Create Note")
        
    }
    
    func addNote() {
        if let error = locationManager.locationError {
            print("Location error: \(error.localizedDescription)")
        }
        
        let location = locationManager.currentLocation
        
        viewModel.addNote(title: title,
                          description: description,
                          latitude: location?.latitude.description,
                          longitude: location?.longitude.description) { result in
            switch result {
            case .success(_):
                dismiss.callAsFunction()
            case .failure(let failure):
                showErrorDialog = true
                print(failure)
            }
        }
        dismiss.callAsFunction()
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var locationError: LocationError?
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
            currentLocation = location
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied, .restricted:
            locationError = .permissionDenied
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            locationError = nil
        default:
            locationError = nil
        }
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView(viewModel: NoteListViewModel())
    }
}
