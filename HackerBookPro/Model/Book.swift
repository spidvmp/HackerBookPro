//
//  Book.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 2/1/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

/*
Me creo una clase book que pasando todos los parametros que sacamos de despiezar el  json genera el registro para core data. 
*/

import Foundation

class Book : NSObject {
    
    let title : String!
    let imageUrl : String?
    let pdfUrl : String?
    
    
    //MARK: - Inicializadores
    init(title: String!, imageUrl: String?, pdfUrl: String?) {
        self.title = title
        self.imageUrl = imageUrl
        self.pdfUrl = pdfUrl
    }
    
    
    //grabo el libro en coredata
    func saveToCoreData(context c : NSManagedObjectContext) {
        //el resultado me da lo mismo, no lo tengo que devolver
        _ = BookModel(title: title, imageUrl: imageUrl!, pdfUrl: pdfUrl!, context: c)
    }
    
}
