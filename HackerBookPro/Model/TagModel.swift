//
//  TagModel.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 30/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

import Foundation

class TagModel : _TagModel {
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    //MARK: - Inicializadores
    init(tag t: String, book b:BookModel, context c: NSManagedObjectContext) {
        //recibo un solo autor, lo inserto y lo asocio con el libro.
        super.init(entity: _TagModel.entity(c), insertIntoManagedObjectContext: c)
        self.tag = t
        self.books = b
        
    }
    
}