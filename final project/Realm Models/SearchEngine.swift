//
//  SearchEngine.swift
//  final project
//
//  Created by Paul Brinkmann on 8/24/22.
//

import Foundation
import RealmSwift

//search engine stuff
let googleKey = "google"
let bingKey = "bing"
let yahooKey = "yahoo"
let ddgKey = "duckduckgo"
let qwantKey = "qwant"
let ecosiaKey = "ecosia"
let urls = [
    googleKey: "https://www.google.com/search?q=",
    bingKey: "https://www.bing.com/search?q=",
    yahooKey: "https://search.yahoo.com/search?p=",
    ddgKey: "https://duckduckgo.com/?q=",
    qwantKey: "https://www.qwant.com/?q=",
    ecosiaKey: "https://www.ecosia.org/search?q=",
]

class SearchEngine: Object {
    @Persisted(primaryKey: true) var name: String
    @Persisted var link: String
}

//Normal CRUD(L)
func getSearchEngines() -> Results<SearchEngine> {
	return realm.objects(SearchEngine.self)
}
func getSearchEngine(name: String) -> SearchEngine? {
    let engine: SearchEngine? = realm.object(ofType: SearchEngine.self, forPrimaryKey: name)
    
    if engine == nil && urls[name] != nil {
        //we have not created all the search engines yet
        initSearchEngines()
    }

    return realm.object(ofType: SearchEngine.self, forPrimaryKey: name)
}
func createSearchEngine(name: String, link: String) -> SearchEngine {
    let engine = SearchEngine(value: ["name": name, "link": link])
    try! realm.write {
        realm.add(engine)
    }
    return engine
}
func updateSearchEngine(name: String, link: String) {
    let engine = getSearchEngine(name: name)
    try! realm.write {
        engine!.link = link
    }
}
func destroySearchEngine(searchEngine: SearchEngine) {
    try! realm.write {
        realm.delete(searchEngine)
    }
}

//Other helpers
func getCurrentSearch() -> SearchEngine? {
    let name = getSetting(key: searchKey).value
    return getSearchEngine(name: name)
}
func getSearchEngineLink() -> String {
    return getCurrentSearch()?.link ?? urls[defaults[searchKey]!]!
}

func changeSearchEngine(newEngine: SearchEngine) {
	updateSetting(key: searchKey, value: newEngine.name)
}

func initSearchEngines() {
    for search in urls.keys {
        //if we haven't made the search engine yet, make it
        if (realm.object(ofType: SearchEngine.self, forPrimaryKey: search) == nil) {
            _ = createSearchEngine(name: search, link: urls[search]!)
        }
    }
}
