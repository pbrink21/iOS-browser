//
//  ViewController.swift
//  final project
//
//  Created by Paul Brinkmann on 7/27/22.
//

//Future TODOs: (when I'm bored / have extra time)
// - Bookmark folders
// - Creating your own search engine
// - Icons on bookmarks, history, and search engine
// - Trim text when using default search engine
// - Cache webpage screens
// - Proper cookie handling
// - Preserving backroutes for tabs
// - Automatically get theme initially

import UIKit
import WebKit
import Combine

class ViewController: UIViewController, WKUIDelegate, UITextFieldDelegate, WKNavigationDelegate {
	@IBOutlet weak var upperView: UIView!
	@IBOutlet weak var search: UITextField!
	@IBOutlet weak var searchBtn: UIButton!
	@IBOutlet weak var reloadBTN: UIButton!
	
	@IBOutlet var webView: WKWebView!
    @IBOutlet weak var loadingView: UIView! { //gives the little box around the spinner curved corners
        didSet {
            loadingView.layer.cornerRadius = 6
			loadingView.layer.backgroundColor = getColor1().cgColor
        }
    }
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
	
	@IBOutlet weak var loadingBar: UIProgressView!
	@IBOutlet weak var bottomView: UIStackView!
	@IBOutlet weak var backBtn: UIButton!
	@IBOutlet weak var favoriteButton: UIButton!
	@IBOutlet weak var tabBtn: UIButton!
	@IBOutlet weak var settingBtn: UIButton!
	@IBOutlet weak var forwardBtn: UIButton!
    
    private var loadingObservation: NSKeyValueObservation?
    var currentTab: Tab? = getCurrentTab()

    override func viewDidLoad() {
		//coloring
		self.view.backgroundColor = getColor1()
		
		upperView.backgroundColor = getColor1()
		search.backgroundColor = getColor2()
		search.textColor = getTextColor()
		reloadBTN.tintColor = getAccentColor()
		
		webView.backgroundColor = getColor2()
		loadingIndicator.color = getAccentColor()
		loadingBar.tintColor = getAccentColor()
		
		bottomView.backgroundColor = getColor1()
		backBtn.tintColor = getAccentColor()
		favoriteButton.tintColor = getAccentColor()
		settingBtn.tintColor = getAccentColor()
		forwardBtn.tintColor = getAccentColor()
		
		//other stuff
		webView.navigationDelegate = self
		search.delegate = self
		initObservers()
        super.viewDidLoad()
		
        //if the tab is still nil, we don't have a tab, and therefore should create one
        if currentTab == nil {
            currentTab = createTab(link: getHomepage())
            openTab(tab: currentTab!)
        }
        webView.load(URLRequest(url: URL(string: currentTab!.link)!))
		
		//Tab button setup
		tabBtn.tintColor = getAccentColor()
		tabBtn.setTitle(String(getTabs().count), for: .normal)
    }

    @IBAction func backClick(_ sender: Any) {
        webView.goBack()
    }
    @IBAction func forwardClick(_ sender: Any) {
        webView.goForward()
    }
    @IBAction func refreshClick(_ sender: Any) {
        webView.reload()
    }
    @IBAction func favoriteClick(_ sender: Any) {
        let link = webView.url!.absoluteString
        if isBookmarked(link: link) {
            destroyBookmark(Bookmark: getBookmark(link: link)!)
        } else {
            try! _ = createBookmark(name: self.webView.title!,
                                link: self.webView.url!.absoluteString,
                                folder: getFolder(name: defaultFolder)!)
        }
		updateFavoritesButton()
    }
	private func updateFavoritesButton() {
		//update favorites button colors
		if isBookmarked(link: webView.url!.absoluteString) {
			favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
		} else {
			favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
		}
	}
	
	//Used to create the observers
	private func initObservers() {
		self.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: [.new, .old], context: nil)
		self.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.url), options: .new, context: nil)
		self.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
	}
	//runs the observers
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		if keyPath == #keyPath(WKWebView.url) {
			//Started loading a new URL
			searchBtn.isHidden = false
			search.text = getDisplayLink(link: webView.url!.absoluteString)
		}
		
		if keyPath == #keyPath(WKWebView.estimatedProgress) {
			//update the loading bar
			loadingBar.progress = Float(webView.estimatedProgress)
		}
		
		if keyPath == #keyPath(WKWebView.isLoading) {
			if webView.isLoading {
				//started loading
				search.textColor = getColor3()
				loadingIndicator.startAnimating()
				loadingView.isHidden = false
				loadingBar.isHidden = false
			} else {
				//finished loading
				loadingIndicator.stopAnimating()
				loadingView.isHidden = true
				_ = createHistoryItem(
					link: webView.url!.absoluteString,
					name: webView.title!)
				updateTab(id: currentTab!.id, link: webView.url!.absoluteString)
				updateFavoritesButton()
				loadingBar.isHidden = true
			}
		}
	}
	
	//Functions for managing the search bar
	@IBAction func seachBtnClicked(_ sender: Any) {
		//The invisible button over the search bar has been clicked
		search.selectAll(nil)
		searchBtn.isHidden = true
		search.textColor = getTextColor()
	}
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		//Return has been pressed, so we are going to load a new page
		processInput()
		return true
	}
    func processInput() {
		//Function for loading a url
        var urlString: String
        webView.becomeFirstResponder()
        
        if let input = search.text {
            //If we have a url, go to it
			if isUrl(url: input) {
				urlString = patchPartialUrl(url: input)
            } else {
                //We have a query so we should use a search engine
				urlString = getSearchEngineLink() + input.replacingOccurrences(of: " ", with: "+")
            }
        } else {
            //If left blank or something, go to homepage
            urlString = getHomepage()
        }
		
        let request = URLRequest(url: URL(string: urlString)!)
        webView.load(request)
    }
}
