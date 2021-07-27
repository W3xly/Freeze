//
//  FreezeApp.swift
//  Freeze
//
//  Created by Jan Podmolík on 20.04.2021.
//

import SwiftUI
import Firebase

@main
struct FreezeApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
//    init() {
//        FirebaseApp.configure()
//    }
// It's simpler, but Firebase still screaming bullfish

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    if defaults.array(forKey: CON_unlocked) == nil {
                        defaults.setValue([], forKey: CON_unlocked)
                    }
                    if defaults.array(forKey: CON_selected) == nil {
                        defaults.setValue([], forKey: CON_selected)
                    }
                }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}



