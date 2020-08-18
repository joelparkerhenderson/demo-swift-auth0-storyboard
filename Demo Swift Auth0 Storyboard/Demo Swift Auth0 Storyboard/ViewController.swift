//
//  ViewController.swift
//  Demo Swift Auth0 Storyboard
//
//  Created by Joel on 2020-08-17.
//  Copyright © 2020 JoelParkerHenderson.com. All rights reserved.
//

import UIKit
import Auth0

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Auth0
            .webAuth()
            .scope("openid profile")
            .audience("https://joelparkerhenderson.auth0.com/userinfo")
            .start {
                switch $0 {
                case .failure(let error):
                    // Handle the error
                    print("Error: \(error)")
                case .success(let credentials):
                    // Do something with credentials e.g.: save them.
                    // Auth0 will automatically dismiss the login page
                    print("Credentials: \(credentials)")
                }
        }
    }
}

