//
//  Bookmarks.swift
//  final project
//
//  Created by Paul Brinkmann on 8/26/22.
//

import Foundation
import RealmSwift

let defaultFolder = "favorites"
class Bookmark: Object {
    @Persisted var name: String
    @Persisted(primaryKey: true) var link: String
    @Persisted var folder: Folder?
}

func getBookmarks() -> Results<Bookmark> {
    return realm.objects(Bookmark.self)
}
func getBookmark(link: String) -> Bookmark? {
    return realm.object(ofType: Bookmark.self, forPrimaryKey: link)
}
func createBookmark(name: String, link: String, folder: Folder) throws -> Bookmark {
    var bookmark = getBookmark(link: link)
    if bookmark != nil {
        throw BrowserError.runtimeError("That bookmark already exsists")
    }
    
    bookmark = Bookmark(value: ["name": name, "link": link, "folder": folder])
    try! realm.write {
        realm.add(bookmark!)
    }
    return bookmark!
}
func updateBookmark(name: String, link: String, folder: Folder) throws {
    let bookmark = getBookmark(link: link)
    if bookmark == nil {
        throw BrowserError.runtimeError("No bookmark with that link exsists")
    }
    try! realm.write {
        bookmark!.name = name
    }
    addBookmarkToFolder(folder: folder, bookmark: bookmark!)
}
func destroyBookmark(Bookmark: Bookmark) {
    try! realm.write {
        realm.delete(Bookmark)
    }
}

func isBookmarked(link: String) -> Bool {
    let bookmarks = getBookmarks()
    let bookmark = bookmarks.where {
        $0.link == link
    }.first
    return bookmark != nil
}
