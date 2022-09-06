//
//  AppDelegate.swift
//  MVPMatchChallenge
//
//  Created by Pavlo Boiko on 2022/9/5.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        navigateToRootVC()
        setNavBarUI()

        return true
    }
    
    /// Setting Navigation Bar UI
    private func setNavBarUI() {
        UINavigationBar.appearance().barTintColor = UIColor.black
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
    }
    
    /// Navigation handler for startup
    private func navigateToRootVC() {
        window = UIWindow()
        window?.makeKeyAndVisible()
        let moviesListScene = SceneFactory.shared().getScene(sceneType: .MovieList)
        window?.rootViewController = UINavigationController(rootViewController: moviesListScene)
    }
    


}

