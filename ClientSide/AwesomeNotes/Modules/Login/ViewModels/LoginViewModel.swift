import Foundation

class LoginViewModel: ObservableObject {
    // Input
    @Published var username: String = ""
    @Published var password: String = ""
    
    // Output
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    
    var model = LoginModel()
    
    // Action
    func login(credentials: UserCredentials, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        let url = NSLocalizedString("serverPath", comment: "Path")
        
        let parameters: [String: Any] = [
            "username": credentials.username,
            "password": credentials.password
        ]
        
        
    }
}
