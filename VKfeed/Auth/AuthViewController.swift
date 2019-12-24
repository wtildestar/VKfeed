//
//  AuthViewController.swift
//  VKfeed
//
//  Created by wtildestar on 23/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        authService = AuthService()
        authService = AppDelegate.shared().authService
    }
    
    @IBAction func SignInTouch() {
        authService.wakeUpSession()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
