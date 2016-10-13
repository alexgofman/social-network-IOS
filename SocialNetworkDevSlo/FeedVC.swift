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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var imageAdd: CircleView!
	
	var imagePicker: UIImagePickerController!
	var posts = [Post]()
	static var imageCache: NSCache<NSString, UIImage> = NSCache()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
		
		
		imagePicker = UIImagePickerController()
		imagePicker.delegate = self
		imagePicker.allowsEditing = true
		
		DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
			if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
				for snap in snapshot {
					print("snap - \(snap)")
					if let postDict = snap.value as? Dictionary<String, AnyObject> {
						let key = snap.key
						let post = Post(postKey: key, postData: postDict)
						self.posts.append(post)
					}
				}
			}
			self.tableView.reloadData()
		})
		
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
			imageAdd.image = image
		} else {
			print("ALEX: a valid image wasn't selected")
		}
		imagePicker.dismiss(animated: true, completion: nil)
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return posts.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let post = posts[indexPath.row]
		if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
			//var img: UIImage!
			if let img = FeedVC.imageCache.object(forKey: post.imageUrl as NSString) {
				cell.configureCell(post: post, img: img)
				return cell
			} else {
				cell.configureCell(post: post)
				return cell
			}
			
		} else {
			return PostCell()
		}
	}
	
	
	@IBAction func signOutTapped(_ sender: AnyObject) {
		let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
		print("ALEX: Keychain ID removed - \(keychainResult)")
		try! FIRAuth.auth()?.signOut()
		self.dismiss(animated: true, completion: nil)
	}
	
	
	@IBAction func addImageTapped(_ sender: AnyObject) {
		present(imagePicker, animated: true, completion: nil)
	}


}
