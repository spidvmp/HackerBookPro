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
    
    
    
    
    //MARK: - Inicializadores
    //func init(title t: String, context c: NSManagedObjectContext) -> BookModel {
    init(title t: String, context c: NSManagedObjectContext) {
        //var x = super.init(managedObjectContext: c)
        
        super.init(entity: _BookModel.entity(c), insertIntoManagedObjectContext: c)
        self.title = t
        //let b : BookModel = _BookModel(managedObjectContext: c) as! BookModel
        //b.title = t
        //return b
    }
    
    
//    func crear(title t: String, context c: NSManagedObjectContext) -> _BookModel {
//        //let b : BookModel = _BookModel(managedObjectContext: c) as! BookModel
//        let b = BookModel(context: c)
//        
//
//        b.title = t
//    
//        return b
//    }
}

