//
//  SignInVC.swift
//  SocialNetworkDevSlo
//
//  Created by Alex Hoffman on 10/8/16.
//  Copyright © 2016 Alex Hoffman. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController {

	@IBOutlet weak var emailField: FancyField!
	@IBOutlet weak var passwordField: FancyField!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func facebookBtnTapped(_ sender: AnyObject) {
		let facebookLogin = FBSDKLoginManager()
		facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
			if error != nil {
				print("ALEX: Unable to authenticate with Facebook - \(error)")
			} else if result?.isCancelled == true {
				print("ALEX: User cancelled auth")
			} else {
				print("ALEX: Successfully authenticated with Facebook")
				let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
				self.firebaseAuth(credential)
			}
		}
	}
	
	func firebaseAuth(_ credential: FIRAuthCredential) {
		FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
			if error != nil {
				print("ALEX: Unable to auth with Firebase - \(error)")
			} else {
				print("ALEX: Successfully authenticated with Firebase")
			}
		})
	}
	
	@IBAction func signInTapped(_ sender: AnyObject) {
		if let email = emailField.text, let pwd = passwordField.text {
			FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
				if error != nil {
					print("ALEX: error in sign in with email - \(error)")
					FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
						if error != nil {
							print("ALEX: Unable to auth with Firebase using email")
						} else {
							print("Successfully created user auth with Firebase")
						}
					})
				} else {
					print("ALEX: User email authenticated with Firebase")
				}
			})
		}
	}
	
	
	

}

