//
//  SearchViewController.swift
//  final project
//
//  Created by Paul Brinkmann on 8/26/22.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	@IBOutlet weak var navbarView: UIView!
	@IBOutlet weak var navbarBackground: UIView!
	@IBOutlet weak var backBtn: UIButton!
	@IBOutlet weak var table: UITableView!
	
	let searchEngines = getSearchEngines()
	
	override func viewDidLoad() {
		self.view.backgroundColor = getColor1()
		navbarBackground.backgroundColor = getColor2()
		navbarView.backgroundColor = getColor2()
		table.backgroundColor = getColor1()
		
		backBtn.tintColor = getAccentColor()
		
		initSearchEngines()
		
		super.viewDidLoad()
    }
    
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return searchEngines.count
	}
	//cell on click
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let engine = searchEngines[indexPath.row]
		changeSearchEngine(newEngine: engine)
		table.reloadData()
	}
	//constructing cell
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchTableViewCell
		let engine = searchEngines[indexPath.row]
		
		//colors
		cell.label.textColor = getTextColor()
		cell.circleBtn.tintColor = getAccentColor()
		cell.backgroundColor = getColor1()
		
		//data and stuff
		cell.label.text = engine.name
		cell.circleBtn.isUserInteractionEnabled = false
		
		//marking which one is selected
		if getCurrentSearch() == engine {
			cell.circleBtn.setImage(UIImage(systemName: "circle.fill"), for: .normal)
		} else {
			cell.circleBtn.setImage(UIImage(systemName: "circle"), for: .normal)
		}
		
		return cell
	}
}
