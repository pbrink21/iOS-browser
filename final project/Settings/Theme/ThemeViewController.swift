//
//  ThemeViewController.swift
//  final project
//
//  Created by Paul Brinkmann on 8/26/22.
//

import UIKit

class ThemeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	@IBOutlet weak var navbarView: UIView!
	@IBOutlet weak var navbarBackground: UIView!
	@IBOutlet weak var backBtn: UIButton!
	@IBOutlet weak var themeTable: UITableView!
	@IBOutlet weak var colorCollection: UICollectionView!
	@IBOutlet weak var colorLabel: UILabel!
	@IBOutlet weak var themeLabel: UILabel!
	
	let themes = themeOptions
	let colors = colorOptions
	
    override func viewDidLoad() {
		self.view.backgroundColor = getColor1()
		navbarBackground.backgroundColor = getColor2()
		navbarView.backgroundColor = getColor2()
		themeTable.backgroundColor = getColor1()
		colorCollection.backgroundColor = getColor1()
		
		backBtn.tintColor = getAccentColor()
		themeLabel.textColor = getTextColor()
		colorLabel.textColor = getTextColor()
		
		colorCollection.allowsMultipleSelection = false
		themeTable.isScrollEnabled = false
		
		super.viewDidLoad()
    }
    
	//MARK: Theme table
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return themes.count
	}
	//cell on click
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		updateSetting(key: themeKey, value: themes[indexPath.row])
		themeTable.reloadData()
		colorCollection.reloadData()
		self.viewDidLoad()
	}
	//constructing cell
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "themeCell", for: indexPath) as! ThemeTableViewCell
		let theme = themes[indexPath.row]
		let currentTheme = getSetting(key: themeKey).value
		
		//colors
		cell.backgroundColor = getColor1()
		cell.label.textColor = getTextColor()
		cell.selectedBtn.tintColor = getAccentColor()
	
		//data
		cell.label.text = theme
		cell.selectedBtn.isUserInteractionEnabled = false
		
		//indicating which theme is currently selected
		if theme == currentTheme {
			cell.selectedBtn.setImage(UIImage(systemName: "circle.fill"), for: .normal)
		} else {
			cell.selectedBtn.setImage(UIImage(systemName: "circle"), for: .normal)
		}
		
		return cell
	}

	//MARK: Accent color collection
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.colors.count
	}
	//on click
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		updateSetting(key: accentColorKey, value: colors[indexPath.row])
		themeTable.reloadData()
		colorCollection.reloadData()
		self.viewDidLoad()
	}
	//constructing the cell
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath as IndexPath) as! AccentColorCollectionViewCell
		let color = self.colors[indexPath.row]
		
		//coloring
		cell.backgroundColor = getColor1()
		cell.colorIndicator.tintColor = keyToColor[color]
		cell.colorIndicator.layer.backgroundColor = keyToColor[color]!.cgColor
		
		//border if the color is the same as the background color
		cell.colorIndicator.layer.borderWidth = 0
		if getColor1() == keyToColor[color] {
			cell.colorIndicator.layer.borderWidth = 1
			cell.colorIndicator.layer.borderColor = getTextColor().cgColor
		}
		
		//adding a checkmark
		if getAccentColor() == keyToColor[color] {
			cell.colorIndicator.setImage(UIImage(systemName: "checkmark"), for: .normal)
			cell.colorIndicator.tintColor = getTextColor() == keyToColor[color] ? getColor1() : getTextColor()
		}
		
		//other stuff
		cell.colorIndicator.layer.cornerRadius = 25
		cell.colorIndicator.isUserInteractionEnabled = false
	
		return cell
	}
}
