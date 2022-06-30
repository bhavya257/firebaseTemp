//
//  AppDelegate.swift
//  firebaseTemp
//
//  Created by Bhavya Jain on 26/06/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FacebookCore
import FacebookLogin

@main
class AppDelegate: UIResponder, UIApplicationDelegate{

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //Firebase
        FirebaseApp.configure()
        //Facebook
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        //Google
//       AppDelegate(GIDSignIn.sharedInstance.clientID="745676618837-0b6rispc3dves24dd9bn0k4umfp909md.apps.googleusercontent.com")
        return true
    }
    
    open func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool{
        var flag: Bool=false
        //Google
        flag = GIDSignIn.sharedInstance.handle(url)
        if flag{
            return true
        }
        else{
            //Facebook
            flag = ApplicationDelegate.shared.application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
            return true
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

