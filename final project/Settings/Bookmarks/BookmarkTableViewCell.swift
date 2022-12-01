//
//  BookmarkTableViewCell.swift
//  final project
//
//  Created by Paul Brinkmann on 8/29/22.
//

import UIKit

class BookmarkTableViewCell: UITableViewCell {

	@IBOutlet weak var label: UILabel!
	@IBOutlet weak var delBTN: UIButton!
	
	var bookmark: Bookmark!
	var parentView: BookmarkViewController!

	@IBAction func delBookmark(_ sender: Any) {
		destroyBookmark(Bookmark: bookmark)
		parentView.table.reloadData()
	}
	
}
