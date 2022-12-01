//
//  Folder.swift
//  final project
//
//  Created by Paul Brinkmann on 8/26/22.
//

import Foundation
import RealmSwift

class Folder: Object {
    @Persisted(primaryKey: true) var name: String
    @Persisted var bookmarks: List<Bookmark>
}

func getFolders() -> Results<Folder> {
    return realm.objects(Folder.self)
}
func getFolder(name: String) -> Folder? {
    var folder: Folder? = realm.object(ofType: Folder.self, forPrimaryKey: name)
    if name == defaultFolder && folder == nil {
        folder = createFolder(name: defaultFolder)
    }

    return folder
}
func createFolder(name: String) -> Folder {
    let folder = Folder(value: ["name": name])
    try! realm.write {
        realm.add(folder)
    }
    return folder
}
func updateFolder(folder: Folder, newName: String) throws {
    let f = getFolder(name: newName)
    if f != nil {
        throw BrowserError.runtimeError("A folder with that name already exists")
    }
    
    try! realm.write {
        folder.name = newName
    }
}
func addBookmarkToFolder(folder: Folder, bookmark: Bookmark) {
    try! realm.write {
        bookmark.folder = folder
        folder.bookmarks.append(bookmark)
    }
}
func destroyFolder(Folder: Folder) {
    try! realm.write {
        realm.delete(Folder)
    }
}
