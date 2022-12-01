//
//  HomepageViewController.swift
//  final project
//
//  Created by Paul Brinkmann on 8/26/22.
//

import UIKit

class HomepageViewController: UIViewController {
	@IBOutlet weak var navbarView: UIView!
	@IBOutlet weak var navbarBackground: UIView!
	@IBOutlet weak var backBtn: UIButton!
	
	@IBOutlet weak var header: UILabel!
	@IBOutlet weak var inputBox: UITextField!
	@IBOutlet weak var updateBtn: UIButton!
	@IBOutlet weak var searchBtn: UIButton!
	@IBOutlet weak var helperText: UILabel!
	@IBOutlet weak var statusMessage: UILabel!
	
	override func viewDidLoad() {
		self.view.backgroundColor = getColor1()
		navbarBackground.backgroundColor = getColor2()
		navbarView.backgroundColor = getColor2()
		
		backBtn.tintColor = getAccentColor()
		header.textColor = getTextColor()
		helperText.textColor = getTextColor()
		inputBox.textColor = getTextColor()
		inputBox.backgroundColor = getColor2()
		statusMessage.textColor = getColor1()
		
		searchBtn.layer.borderColor = getAccentColor().cgColor
		searchBtn.layer.borderWidth = 1
		searchBtn.layer.cornerRadius = 5
		
		updateBtn.layer.borderColor = getAccentColor().cgColor
		updateBtn.layer.borderWidth = 1
		updateBtn.layer.cornerRadius = 5

		inputBox.text = getHomepage()
		updateButtons()
		
		super.viewDidLoad()
    }

	@IBAction func updateHomepage(_ sender: Any) {
		if inputBox.text != nil && isUrl(url: inputBox.text!) {
			setHomepage(link: patchPartialUrl(url: inputBox.text!))
			inputBox.text = getHomepage()
			
			statusMessage.text = "successfully updated homepage"
			statusMessage.textColor = UIColor.green
		} else {
			statusMessage.text = "that was not a proper url, please try again"
			statusMessage.textColor = UIColor.red
		}
		updateButtons()
	}
	@IBAction func searchBtnClicked(_ sender: Any) {
		setHomepage(link: searchConst)
		inputBox.text = getHomepage()
		updateButtons()
	}
	
	//Updates the color and text of buttons based on what the homepage currently is
	func updateButtons() {
		if homepageSearch() {
			searchBtn.tintColor = getTextColor()
			searchBtn.backgroundColor = getAccentColor()
			searchBtn.setTitle("using search engine", for: .normal)
			
			updateBtn.tintColor = getAccentColor()
			updateBtn.backgroundColor = getColor1()
			updateBtn.setTitle("use custom URL", for: .normal)
		} else {
			searchBtn.tintColor = getAccentColor()
			searchBtn.backgroundColor = getColor1()
			searchBtn.setTitle("use search engine", for: .normal)
			
			updateBtn.tintColor = getTextColor()
			updateBtn.backgroundColor = getAccentColor()
			updateBtn.setTitle("update custom URL", for: .normal)
		}
	}
}
