//
//  AccessUserDefaults.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 31/1/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//


//MARK: - Acceso a Userdefaults

let def = NSUserDefaults.standardUserDefaults()

func saveBookInUserDefaults(book: BookModel) {
    
    //obtengo el NSData del UIR
    if let data = archiveURIRepresentation(book) {
        //gtabo en userdefaults
        def.setObject(data, forKey: LAST_BOOK_READ)
    }
}

func archiveURIRepresentation(book: BookModel) -> NSData? {
    let uri = book.objectID.URIRepresentation()
    return NSKeyedArchiver.archivedDataWithRootObject(uri)
   
}

