//
//  BookModel.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 30/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

import Foundation

class BookModel : _BookModel {
    
    
    
    //MARK: - Inicializadores
    init(title t: String, context c: NSManagedObjectContext) {
        
        super.init(entity: _BookModel.entity(c), insertIntoManagedObjectContext: c)
        self.title = t

    }
    

}

