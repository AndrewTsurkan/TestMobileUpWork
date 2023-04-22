//
//  AuthService.swift
//  TestMU
//
//  Created by Андрей Цуркан on 22.04.2023.
//

import Foundation
import VK_ios_sdk

class AuthService:  NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appId = "51621340"
    private let vkSdk: VKSdk
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSdk.initialize")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)

    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)

    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)

    }
}
