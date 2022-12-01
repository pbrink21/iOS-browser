//
//  SettingViewController.swift
//  final project
//
//  Created by Paul Brinkmann on 8/18/22.
//

import UIKit

enum SettingMenu {
    case bookmarks
    case history
    case homepage
    case search
    case theme
}

class SettingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	@IBOutlet weak var navbarView: UIView!
	@IBOutlet weak var navbarBackground: UIView!
	@IBOutlet weak var backBTN: UIButton!
	@IBOutlet weak var table: UITableView!
	@IBOutlet weak var resetBtn: UIButton!
	
	var settings = [ SettingMenu.bookmarks, .history, .homepage, .search, .theme ]
	
    override func viewDidLoad() {
		self.view.backgroundColor = getColor1()
		navbarBackground.backgroundColor = getColor2()
		navbarView.backgroundColor = getColor2()
		table.backgroundColor = getColor1()
	
		backBTN.tintColor = getAccentColor()
       
		initSettings()
		
		super.viewDidLoad()
    }
	
	@IBAction func resetSettings(_ sender: Any) {
		for engine in getSearchEngines() {
			destroySearchEngine(searchEngine: engine)
		}
		for setting in getSettings() {
			destroySetting(setting: setting)
		}
		for tab in getTabs() {
			destroyTab(tab: tab)
		}
		clearHistory()
		self.viewDidLoad()
		self.table.reloadData()
		resetBtn.tintColor = UIColor.green
		resetBtn.setImage(UIImage(systemName: "checkmark"), for: .normal)
		resetBtn.setTitle("done", for: .normal)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return settings.count
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50 //height of cells
	}
	//on click of setting
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let setting = settings[indexPath.row]

		switch setting {
			case .bookmarks:
				self.performSegue(withIdentifier: "bookmarkSegue", sender:self)
				break
			case .history:
				self.performSegue(withIdentifier: "historySegue", sender:self)
				break
			case .homepage:
				self.performSegue(withIdentifier: "homepageSegue", sender:self)
				break
			case .search:
				self.performSegue(withIdentifier: "searchSegue", sender:self)
				break
			case .theme:
				self.performSegue(withIdentifier: "themeSegue", sender:self)
				break
		}
		
	}
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! SettingTableViewCell
        let setting = settings[indexPath.row]

		//coloring
		cell.backgroundColor = getColor1()
		cell.label.textColor = getTextColor()
		cell.icon.tintColor = getTextColor()
		cell.chevronImage.tintColor = getAccentColor()
		cell.chevronImage.alpha = 0.5
		
		//load data accordingly
        switch setting {
			case .bookmarks:
				cell.label.text = "bookmarks"
				cell.icon.image = UIImage(systemName: "bookmark")
				break
			case .history:
				cell.label.text = "history"
				cell.icon.image = UIImage(systemName: "book")
				break
			case .homepage:
				cell.label.text = "homepage"
				cell.icon.image = UIImage(systemName: "house")
				break
			case .search:
				cell.label.text = "search engine"
				cell.icon.image = UIImage(systemName: "magnifyingglass")
				break
			case .theme:
				cell.label.text = "theme"
				cell.icon.image = UIImage(systemName: "paintpalette")
				break
        }
		cell.chevronImage.image = UIImage(systemName: "chevron.right")
        
        return cell
    }
}
