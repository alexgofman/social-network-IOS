//
//  FeedVC.swift
//  SocialNetworkDevSlo
//
//  Created by Alex Hoffman on 10/11/16.
//  Copyright © 2016 Alex Hoffman. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
		
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
	}
	
	
	@IBAction func signOutTapped(_ sender: AnyObject) {
		let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
		print("ALEX: Keychain ID removed - \(keychainResult)")
		try! FIRAuth.auth()?.signOut()
		self.dismiss(animated: true, completion: nil)
	}


}
