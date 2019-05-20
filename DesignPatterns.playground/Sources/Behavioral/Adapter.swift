import Foundation

public struct User {
    let name: String
}

public protocol Authenticator {
    func login(withUsername username: String, password: String, completion: (User?, Error?) -> ())
}

public class GoogleAuth {
    
    public struct GoogleUser {
        let name: String
    }
    
    public func login(withGoogle username: String, password: String, completion: (GoogleUser?, Error) -> () ) {
        // Authentication process
    }
    
}

public class AuthenticatorAdapter: Authenticator {
    
    let authenticator = GoogleAuth()
    
    public func login(withUsername username: String, password: String, completion: (User?, Error?) -> () ) {
        authenticator.login(withGoogle: username, password: password) { user, error in
            guard let googleUser = user else {
                completion(nil, nil)
                return
            }
            let adaptedUser = User(name: googleUser.name)
            completion(adaptedUser, nil)
        }
    }
}
