//
//  SceneDelegate.swift
//  Playlists
//
//  Created by Nalin Gaddis on 7/14/20.
//  Copyright © 2020 Nalin Gaddis. All rights reserved.
//

import Dispatch
import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        /// If they have logged in before, fetch their code
        if let refreshToken = try? Keychain.fetch(key: "playlists.spotify.refresh_token") {
            do {
                try Authenticator.refresh(refreshToken)
                changeView(to: HomeView(), inScene: scene)
            } catch {
                print(error)
            }
        } else {
            changeView(to: LoginView(), inScene: scene)
        }
    }
    
    /// Change the view in scene `scene` to the given `view`
    /// - Parameters:
    ///   - view: The new view for the scene
    ///   - scene: The scene to change
    func changeView<V: View>(to view: V, inScene scene: UIScene){
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = HostingController(rootView: view)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    /// Called when the app is opened via URL
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        
        if let urlContext = URLContexts.first {
            
            guard let code =
                URLComponents(url: urlContext.url, resolvingAgainstBaseURL: true)?
                    .queryItems?
                        .first(where: { $0.name == "code" })?
                            .value
            else {
                print("Callback Code Missing")
                return
            }
            
            authenticate(with: code, scene: scene)
        }
    }
    
    /// Authenticate with a user's code
    func authenticate(with code: String, scene: UIScene) {
        do {
            try Authenticator.tokens(using: code)
            changeView(to: HomeView(), inScene: scene)
        } catch {
            print(error)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

