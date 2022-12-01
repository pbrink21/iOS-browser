//
//  HistoryTableViewCell.swift
//  final project
//
//  Created by Paul Brinkmann on 9/1/22.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
	@IBOutlet weak var label: UILabel!
	@IBOutlet weak var delBTN: UIButton!
	
	var historyItem: History!
	var parentView: HistoryViewController!
	
	@IBAction func delBookmark(_ sender: Any) {
		destroyHistoryItem(item: historyItem)
		parentView.table.reloadData()
	}
	
}
