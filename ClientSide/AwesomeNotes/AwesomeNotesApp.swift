//
//  AwesomeNotesApp.swift
//  AwesomeNotes
//
//  Created by Tiago Coelho on 11/08/2023.
//

import SwiftUI

@main
struct AwesomeNotesApp: App {
    let viewModel: AuthenticationViewModelProtocol = AuthenticationViewModel()
    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: viewModel)
        }
    }
}
