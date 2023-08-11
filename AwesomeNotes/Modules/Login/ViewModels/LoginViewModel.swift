import Foundation

class LoginViewModel: ObservableObject {
    // Input
    @Published var username: String = ""
    @Published var password: String = ""
    
    // Output
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    
    // Action
    func login() {
        // Simulate a login process for demonstration purposes
        if username == "user" && password == "password" {
            isLoggedIn = true
            errorMessage = ""
        } else {
            isLoggedIn = false
            errorMessage = "Invalid credentials. Please try again."
        }
    }
    
    // Additional methods or properties can be added here for more functionality
}
