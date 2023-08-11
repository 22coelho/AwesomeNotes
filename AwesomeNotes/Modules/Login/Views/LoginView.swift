//
//  LoginView.swift
//  AwesomeNotes
//
//  Created by Tiago Coelho on 11/08/2023.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            Text("AwesomeNotes")
                .font(.system(size: Constants.Title.size).weight(.bold))
            
            VStack {
                TextField("Username",
                          text: $viewModel.username)
                .autocapitalization(.none)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: Constants.cornerRadius)
                        .stroke(Color.blue,
                                lineWidth: Constants.TextField.lineWidth)
                )
                SecureField("Password",
                            text: $viewModel.password)
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
                viewModel.login()
            }) {
                HStack {
                    Text("Login")
                        .font(.system(size: Constants.Button.size).weight(.bold))
                    Image(systemName: "arrow.right")
                        .foregroundColor(.white)
                        .font(.system(size: Constants.Button.size).weight(.bold))
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(Constants.cornerRadius)
            }.padding(.bottom, Constants.Button.bottomPadding)
            Button(action: {
                // Navigate to Register Component
            }) {
                Text("Don't have a account? Register")
            }
            if viewModel.isLoggedIn {
                Text("Logged in successfully!")
                    .foregroundColor(.green)
            } else {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
            }
        }
        .padding()
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
