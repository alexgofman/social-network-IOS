//
//  PostCell.swift
//  SocialNetworkDevSlo
//
//  Created by Alex Hoffman on 10/11/16.
//  Copyright © 2016 Alex Hoffman. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

	@IBOutlet weak var profileImg: UIImageView!
	@IBOutlet weak var usernameLbl: UILabel!
	@IBOutlet weak var postImg: UIImageView!
	@IBOutlet weak var caption: UITextView!
	@IBOutlet weak var likesLbl: UILabel!
	
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}



}
