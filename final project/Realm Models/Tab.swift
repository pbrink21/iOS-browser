//
//  Tab.swift
//  final project
//
//  Created by Paul Brinkmann on 8/18/22.
//

import UIKit
import RealmSwift

class Tab: Object, Identifiable {
    @Persisted var link: String
    @Persisted(primaryKey: true) var id: Int
    @Persisted var current: Bool = false
}

let realm = getRealm()

func getTabs() -> Results<Tab> {
    return realm.objects(Tab.self)
}
func getTab(id: Int) -> Tab? {
    return realm.object(ofType: Tab.self, forPrimaryKey: id)
}
func createTab(link: String) -> Tab {
    let id = Int(NSDate().timeIntervalSince1970)
    let tab = Tab(value: ["link" : link, "id" : id])
    try! realm.write {
        realm.add(tab)
    }
    return tab
}
func updateTab(id: Int, link: String) {
    let tab = getTab(id: id)
    try! realm.write {
        tab!.link = link
    }
}
func destroyTab(tab: Tab) {
    try! realm.write {
        realm.delete(tab)
    }
}

func getCurrentTab() -> Tab? {
    let tabs = getTabs()
    let tab = tabs.where {
        $0.current == true
    }.first
    return tab
}

func openTab(tab: Tab) {
    let oldTab = getCurrentTab()
    if oldTab != nil {
        try! realm.write {
            oldTab!.current = false
        }
    }
        
    try! realm.write {
        tab.current = true
    }
}

func getDisplayLink (link: String) -> String {
    var text = link
    if link.starts(with: "https://") {
        text = text.replacingOccurrences(of: "https://", with: "")
    }
    if text.starts(with: "www.") {
        text = text.replacingOccurrences(of: "www.", with: "")
    }
    if text.last! == "/" {
        text = String(text.dropLast())
    }
    return text
}
