import SwiftUI
import Combine

final class AuthManager: ObservableObject {

    static let shared = AuthManager()

    @Published var isLoggedIn: Bool
    @Published var username: String

    private init() {
        self.isLoggedIn = UserDefaults.standard.bool(
            forKey: "isLoggedIn"
        )

        self.username = UserDefaults.standard.string(
            forKey: "username"
        ) ?? ""
    }

    // MARK: - Sign Up

    func signUp(username: String, password: String) {

        let cleanUsername = username.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        UserDefaults.standard.set(
            cleanUsername,
            forKey: "username"
        )

        UserDefaults.standard.set(
            password,
            forKey: "password"
        )

        UserDefaults.standard.set(
            true,
            forKey: "isLoggedIn"
        )

        self.username = cleanUsername
        self.isLoggedIn = true
    }

    // MARK: - Login

    func login(username: String, password: String) -> Bool {

        let enteredUsername = username.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let savedUsername = UserDefaults.standard.string(
            forKey: "username"
        ) ?? ""

        let savedPassword = UserDefaults.standard.string(
            forKey: "password"
        ) ?? ""

        print("Entered username: \(enteredUsername)")
        print("Saved username: \(savedUsername)")
        print("Entered password: \(password)")
        print("Saved password: \(savedPassword)")

        if enteredUsername == savedUsername &&
            password == savedPassword {

            self.username = savedUsername
            self.isLoggedIn = true

            UserDefaults.standard.set(
                true,
                forKey: "isLoggedIn"
            )

            return true
        }

        return false
    }

    // MARK: - Logout

    func logout() {

        UserDefaults.standard.set(
            false,
            forKey: "isLoggedIn"
        )

        self.isLoggedIn = false
    }

    // MARK: - Clear Account
    // Only for testing

    func clearAccount() {

        UserDefaults.standard.removeObject(
            forKey: "username"
        )

        UserDefaults.standard.removeObject(
            forKey: "password"
        )

        UserDefaults.standard.set(
            false,
            forKey: "isLoggedIn"
        )

        self.username = ""
        self.isLoggedIn = false
    }
}
