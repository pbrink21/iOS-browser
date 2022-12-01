//
//  BookmarkViewController.swift
//  final project
//
//  Created by Paul Brinkmann on 8/26/22.
//

import UIKit

class BookmarkViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	@IBOutlet weak var table: UITableView!
	@IBOutlet weak var navbarView: UIView!
	@IBOutlet weak var navbarBackground: UIView!
	@IBOutlet weak var backBTN: UIButton!
	
	let bookmarks = getBookmarks()
	
	override func viewDidLoad() {
		self.view.backgroundColor = getColor1()
		navbarBackground.backgroundColor = getColor2()
		navbarView.backgroundColor = getColor2()
		table.backgroundColor = getColor1()
	
		backBTN.tintColor = getAccentColor()
		
		super.viewDidLoad()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return bookmarks.count
	}
	//on click off cell
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let bookmark = bookmarks[indexPath.row]
		let tab = createTab(link: bookmark.link)
		openTab(tab: tab)
		self.performSegue(withIdentifier: "openBookmark", sender:self)
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarkCell", for: indexPath) as! BookmarkTableViewCell
		let bookmark = bookmarks[indexPath.row]

		//coloring
		cell.backgroundColor = getColor1()
		cell.delBTN.backgroundColor = getColor1()
		cell.label.textColor = getTextColor()
		cell.delBTN.tintColor = UIColor.red
		
		//data
		cell.label.text = bookmark.name
		cell.bookmark = bookmark
		cell.parentView = self
		
		return cell
	}
}
