//
//  TabViewController.swift
//  final project
//
//  Created by Paul Brinkmann on 8/19/22.
//

import UIKit

class TabViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	@IBOutlet weak var navbarView: UIView!
	@IBOutlet weak var navbarBackground: UIView!
	@IBOutlet weak var backBtn: UIButton!
	@IBOutlet weak var addBtn: UIButton!
	@IBOutlet weak var collectionView: UICollectionView!
	
	var tabs = getTabs()
    
    override func viewDidLoad() {
		self.view.backgroundColor = getColor1()
		navbarBackground.backgroundColor = getColor2()
		navbarView.backgroundColor = getColor2()
		collectionView.backgroundColor = getColor1()
	
		backBtn.tintColor = getAccentColor()
		addBtn.tintColor = getAccentColor()

        super.viewDidLoad()
    }
	
	@IBAction func makeTab(_ sender: Any) {
		let tab = createTab(link: getHomepage())
		openTab(tab: tab)
		self.performSegue(withIdentifier: "OpenTab", sender:self)
	}
    
    //Do something on click of tab
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openTab(tab: tabs[indexPath.row])
        self.performSegue(withIdentifier: "OpenTab", sender:self)
    }
    
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.tabs.count
	}
	
    //sizing and spacing for the tab
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let numCells = floor((collectionView.frame.width) / 205)
        return CGSize(width: (collectionView.frame.width / numCells) - 5,
					  height: min(200, collectionView.frame.size.height - 10))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    // generating and modifying the aestetics of a tab
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tabcell", for: indexPath as IndexPath) as! TabViewCell
        let tab = self.tabs[indexPath.row]
  
        //coloring
        cell.backgroundColor = getColor1()
		cell.layer.borderColor = getColor2().cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
		cell.label.textColor = getTextColor()
		cell.delBtn.backgroundColor = getColor1()
        
        //initialize the view
        cell.label.text = getDisplayLink(link: tab.link)
        cell.parentView = self
        cell.tab = tab
		
		//load the url
        cell.webview.isUserInteractionEnabled = false
        cell.webview.load(URLRequest(url: URL(string: tab.link)!))
        
        return cell
    }
}
