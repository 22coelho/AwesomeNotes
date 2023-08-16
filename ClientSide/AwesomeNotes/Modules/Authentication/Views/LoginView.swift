//
//  LoginView.swift
//  AwesomeNotes
//
//  Created by Tiago Coelho on 11/08/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var shouldNavigate = false
    private var viewModel = AuthenticationViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("AwesomeNotes")
                    .font(.system(size: Constants.Title.size).weight(.bold))
                
                VStack {
                    TextField("Username",
                              text: $username)
                    .autocapitalization(.none)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: Constants.cornerRadius)
                            .stroke(Color.blue,
                                    lineWidth: Constants.TextField.lineWidth)
                    )
                    SecureField("Password",
                                text: $password)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: Constants.cornerRadius)
                            .stroke(Color.blue,
                                    lineWidth: Constants.TextField.lineWidth)
                    )
                }
                .padding(.top, Constants.TextField.topPadding)
                .padding(.bottom, Constants.TextField.bottomPadding)
                .padding(.horizontal)
                
                Button(action: {
                    viewModel.login(credentials: UserCredentials(username: username,
                                                                 password: password)) { result in
                        switch result {
                        case .success(_):
                            shouldNavigate = true
                        case .failure(let error):
                            print("erro \(error.localizedDescription)")
                        }
                    }
                }) {
                    HStack {
                        Text("Login")
                            .font(.system(size: Constants.Button.size).weight(.bold))
                        Image(systemName: "arrow.right")
                            .foregroundColor(.white)
                            .font(.system(size: Constants.Button.size).weight(.bold))
                    }
                    .padding()
                    .foregroundColor(.white)
                }
                .background((username.isEmpty || password.isEmpty) ? Color.gray : Color.blue)
                .cornerRadius(Constants.cornerRadius)
                .padding(.bottom, Constants.Button.bottomPadding)
                .disabled((username.isEmpty || password.isEmpty))
                
                ZStack {
                    if shouldNavigate { // next will be instantiated when data got fetched
                        NavigationLink(
                            destination: NoteListView(viewModel: NoteListViewModel()),
                            isActive: $shouldNavigate,
                            label: {}
                        )
                    }
                }
                NavigationLink(destination: RegisterView()) {
                    Text("Don't have a account? Register")
                }
            }
            .padding()
            .navigationTitle("Login")
            .toolbar(.hidden)
        }
    }
}

extension LoginView {
    struct Constants {
        struct Title {
            static let size: CGFloat = 30
        }
        struct TextField {
            static let lineWidth: CGFloat = 2
            static let topPadding: CGFloat = 150
            static let bottomPadding: CGFloat = 20
        }
        struct Button {
            static let size: CGFloat = 20
            static let bottomPadding: CGFloat = 150
        }
        static let cornerRadius: CGFloat = 10
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
