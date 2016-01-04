//
//  AuthorModel.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 30/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

//import Foundation

public class AuthorModel: _AuthorModel {
    //MARK: - inicializadores
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(author a: String, book b:BookModel, context c: NSManagedObjectContext) {
        //recibo un solo autor, lo inserto y lo asocio con el libro.
        super.init(entity: _AuthorModel.entity(c), insertIntoManagedObjectContext: c)
        self.name = a
        
        //la relacion es to many, asi que saco lo que hay y añado este
        let aut = b.authors as! NSMutableSet
        aut.addObject(self)
        b.authors = aut

        
    }

    
}

    
    