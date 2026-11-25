import SwiftUI
import FirebaseCore

@main
struct Lab14IntroFirebaseApp: App {

    // Configure Firebase when app starts
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
