//
//  BookModel.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 30/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

import Foundation

class BookModel : _BookModel {
    
    //definos las propiedades
    //var title : String!
    
    
    //MARK: - Inicializadores
    convenience init (title t: String, context c: NSManagedObjectContext) {
        let b = BookModel(managedObjectContext: c)
        //let b  = NSEntityDescription.insertNewObjectForEntityForName(BookModel.entityName(), inManagedObjectContext: c)
        b.title = t

    }
    
    
    
}

