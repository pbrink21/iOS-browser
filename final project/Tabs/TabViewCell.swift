//
//  TabViewCell.swift
//  final project
//
//  Created by Paul Brinkmann on 8/19/22.
//

import UIKit
import WebKit

class TabViewCell: UICollectionViewCell {
    @IBOutlet weak var webview: WKWebView!
    @IBOutlet weak var label: UILabel!
	@IBOutlet weak var delBtn: UIButton!
	
    var tab: Tab!
    var parentView: TabViewController!
    
    @IBAction func deleteTab(_ sender: Any) {
        destroyTab(tab: tab)
        parentView.collectionView.reloadData()
    }
}
