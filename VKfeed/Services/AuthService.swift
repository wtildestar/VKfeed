//
//  AuthService.swift
//  VKfeed
//
//  Created by wtildestar on 23/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import Foundation
import VKSdkFramework

protocol AuthServiceDelegate {
    func authServiceShouldShow(_ viewController: UIViewController)
    func authServiceSignIn()
    func authServiceDidSignInFail()
}

final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    // MARK: - Properties
    private let appId = "7258057"
    private let vkSdk: VKSdk
    
    var delegate: AuthServiceDelegate?
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSdk.initialize")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func wakeUpSession() {
        let scope = ["offline"]
        
        VKSdk.wakeUpSession(scope) { (state, error) in
            if state == VKAuthorizationState.authorized {
                print("VKAuthorizationState.authorized")
                self.delegate?.authServiceSignIn()
            } else if state == VKAuthorizationState.initialized {
                VKSdk.authorize(scope)
                print("VKAuthorizationState.initialized")
            } else {
                print("auth problems, state \(state) error \(String(describing: error))")
                self.delegate?.authServiceDidSignInFail()
            }
        }
    }
    
    // MARK: - VKSdkDelegate
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function) // #function подставляем имя функции
        delegate?.authServiceSignIn()
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
    
    // MARK: - VKSdkUIDelegate
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServiceShouldShow(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}


