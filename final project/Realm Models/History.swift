//
//  History.swift
//  final project
//
//  Created by Paul Brinkmann on 9/1/22.
//

import Foundation
import RealmSwift

class History: Object {
	@Persisted var name: String
	@Persisted var link: String
	@Persisted(primaryKey: true) var id: Int
}

func getHistory() -> Results<History> {
	return realm.objects(History.self)
}
func getHistoryItem(id: Int) -> History? {
	return realm.object(ofType: History.self, forPrimaryKey: id)
}
func createHistoryItem(link: String, name: String) -> History {
	let id = Int(NSDate().timeIntervalSince1970)
	let history = History(value: ["name": name, "link" : link, "id" : id])
	try! realm.write {
		realm.add(history)
	}
	return history
}
func destroyHistoryItem(item: History) {
	try! realm.write {
		realm.delete(item)
	}
}
func clearHistory() {
	for item in getHistory() {
		destroyHistoryItem(item: item)
	}
}
