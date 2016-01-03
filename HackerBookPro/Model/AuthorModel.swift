//
//  AuthorModel.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 30/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

import Foundation

class AuthorModel: _AuthorModel {
    //MARK: - inicializadores
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(author a: String, book b:BookModel, context c: NSManagedObjectContext) {
        //recibo un solo autor, lo inserto y lo asocio con el libro.
        super.init(entity: _AuthorModel.entity(c), insertIntoManagedObjectContext: c)
        self.name = a
        self.booksWriten = b
        
    }
    
    func authorsFromBook(authors a:[String], book b: BookModel, context c: NSManagedObjectContext){
        //recibo un array con autores, separados por , compruebo si existe o no y lo inserto y le creo la relacion con el libro
        
        
        
    }
    
}

    
    