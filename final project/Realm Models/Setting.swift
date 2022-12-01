//
//  Setting.swift
//  final project
//
//  Created by Paul Brinkmann on 8/21/22.
//

import UIKit
import RealmSwift

func getRealm() -> Realm {
    let config = Realm.Configuration(
        schemaVersion: 2)
    // Use this configuration when opening the realm
    Realm.Configuration.defaultConfiguration = config
    let realm = try! Realm()
    return realm
}
enum BrowserError: Error {
    case runtimeError(String)
}

//keys
let homepageKey = "homepage"
let themeKey = "theme"
let accentColorKey = "color"
let searchKey = "search"
//default values
let defaults = [
    homepageKey: "https://www.apple.com",
    themeKey: darkKey,
    accentColorKey: blueKey,
    searchKey: qwantKey,
]
//constants
let searchConst = "search"

class Setting: Object {
    @Persisted(primaryKey: true) var key: String
    @Persisted var value: String
}

//Normal CRUD(L)
func getSettings() -> Results<Setting> {
    return realm.objects(Setting.self)
}
func getSetting(key: String) -> Setting {
    var setting: Setting? = realm.object(ofType: Setting.self, forPrimaryKey: key)
    
    if setting == nil {
       setting = createSetting(key: key, value: defaults[key] ?? "")
    }
    
    return setting!
}
func createSetting(key: String, value: String) -> Setting {
    let setting = Setting(value: ["key": key, "value": value])
    try! realm.write {
        realm.add(setting)
    }
    return setting
}
func updateSetting(key: String, value: String) {
    let setting = getSetting(key: key)
    try! realm.write {
        setting.value = value
    }
}
func destroySetting(setting: Setting) {
    try! realm.write {
        realm.delete(setting)
    }
}

//Init function
func initSettings() {
    initSearchEngines()
    for key in defaults.keys {
        _ = getSetting(key: key)
    }
}

//Homepage stuff
func getHomepage() -> String {
    let setting = getSetting(key: homepageKey)
    if setting.value == searchConst {
        return getSearchEngineLink()
    }
    return setting.value
}
func setHomepage(link: String) {
	updateSetting(key: homepageKey, value: link)
}
func homepageSearch() -> Bool {
	return getSetting(key: homepageKey).value == searchConst
}

//URL helpers
func isUrl(url: String) -> Bool {
	if url.starts(with: "https://") || url.starts(with: "http://") {
		return true
	}
	
	let r = url.startIndex..<url.endIndex
	let pattern = "^[\\w\\d\\S]*\\.[\\w\\d\\S]*\\S"
	let r2 = url.range(of: pattern, options: .regularExpression)
	return r == r2
}
func patchPartialUrl(url: String) -> String {
	var input = url
	if (isUrl(url: input)) {
		if !(input.starts(with: "https://") || input.starts(with: "http://")) {
			let numOccurrences = input.filter{ $0 == "." }.count
			if  numOccurrences < 2 {
				input = "https://www." + input
			} else {
				input = "https://" + input
			}
		}
		return input
	}
	return "Error"
}
