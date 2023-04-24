//
//  AuthService.swift
//  TestMU
//
//  Created by Андрей Цуркан on 22.04.2023.
//

import Foundation
import VK_ios_sdk

protocol AuthSetviceDelegete: AnyObject {
    func authServiceShouldShow(viewController: UIViewController)
    func authServiceSingIn()
    func authServiceSingInDidFail()
}

class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    private let appId = "51621340"
    private let vkSdk: VKSdk
    
    weak var delagate: AuthSetviceDelegete?
    
    var token:String? {
        return VKSdk.accessToken().accessToken
    }
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSdk.initialize")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func wakeUpSession() {
        
        let scope = ["offline"]
        VKSdk.wakeUpSession(scope) { [delagate] state, error in
            switch state {
            case .initialized:
                print("initialized")
                VKSdk.authorize(scope)
            case .authorized:
                delagate?.authServiceSingIn()
                print("authorized")
            default:
                delagate?.authServiceSingInDidFail()
                fatalError(error!.localizedDescription)
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delagate?.authServiceSingIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        delagate?.authServiceSingInDidFail()
        
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delagate?.authServiceShouldShow(viewController: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
        
    }
}
