//
//  HistoryViewController.swift
//  final project
//
//  Created by Paul Brinkmann on 8/26/22.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	@IBOutlet weak var backBtn: UIButton!
	@IBOutlet weak var navbarView: UIView!
	@IBOutlet weak var navbarBackground: UIView!
	@IBOutlet weak var table: UITableView!
	@IBOutlet weak var wipeBtn: UIButton!
	
	let history = getHistory()
	
	override func viewDidLoad() {
		self.view.backgroundColor = getColor1()
		navbarBackground.backgroundColor = getColor2()
		navbarView.backgroundColor = getColor2()
		table.backgroundColor = getColor1()
	
		backBtn.tintColor = getAccentColor()
		
		super.viewDidLoad()
    }
    
	@IBAction func wipeHistory(_ sender: Any) {
		clearHistory()
		self.table.reloadData()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return history.count
	}
	//on click
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let historyItem = history[history.count - indexPath.row - 1] //history is drawn backwards
		let tab = createTab(link: historyItem.link)
		openTab(tab: tab)
		self.performSegue(withIdentifier: "openHistory", sender:self)
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryTableViewCell
		let historyItem = history[history.count - indexPath.row - 1]

		//coloring
		cell.backgroundColor = getColor1()
		cell.delBTN.backgroundColor = getColor1()
		cell.label.textColor = getTextColor()
		cell.delBTN.tintColor = UIColor.red
		
		//data
		cell.label.text = historyItem.name
		cell.historyItem = historyItem
		cell.parentView = self
		
		return cell
	}
}
