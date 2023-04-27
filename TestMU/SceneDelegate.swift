//
//  SceneDelegate.swift
//  TestMU
//
//  Created by Андрей Цуркан on 22.04.2023.
//

import UIKit
import VK_ios_sdk

class SceneDelegate: UIResponder, UIWindowSceneDelegate, AuthSetviceDelegete {
    
    var window: UIWindow?
    var authService: AuthService!
    
    static func shared() -> SceneDelegate {
        let scene = UIApplication.shared.connectedScenes.first
        let sd:SceneDelegate = (((scene?.delegate as? SceneDelegate)!))
        return sd
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        authService = AuthService()
        authService.delagate = self
        window.rootViewController = UINavigationController(rootViewController:StartViewController())
        window.makeKeyAndVisible()
        self.window = window
    }
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url{
            VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        }
    }
    
    func authServiceShouldShow(viewController: UIViewController) {
        print(#function)
        window?.rootViewController?.present(viewController, animated: true)
    }
    
    func authServiceSingIn() {
        let galleryVC = GalleryViewController()
        let navVC = UINavigationController(rootViewController: galleryVC)
        window?.rootViewController = navVC
        print(#function)
    }
    
    func authServiceSingInDidFail() {
        let fail = UIAlertController(title: "Не удалось авторизироваться", message: nil, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        fail.addAction(okButton)
        window?.rootViewController?.present(fail, animated: true)
        print(#function)
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
    
}

