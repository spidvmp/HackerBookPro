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
    let authors: [String]?
    let tags: [String]?
    let imageUrl : String?
    let pdfUrl : String?
    
    
    //MARK: - Inicializadores
    init(title: String!, authors: [String]?, tags: [String]?, imageUrl: String?, pdfUrl: String?) {
        self.title = title
        self.authors = authors
        self.tags = tags
        self.imageUrl = imageUrl
        self.pdfUrl = pdfUrl
    }
    
    
    //grabo el libro en coredata, los tags, autores, etc
    func saveToCoreData(context c : NSManagedObjectContext) {
        //el resultado me da lo mismo, no lo tengo que devolver
        let b = BookModel(title: title, imageUrl: imageUrl!, pdfUrl: pdfUrl!, context: c)
        
        //ahora guardo los autores y los relaciono con el libro
        //me recorro el array y por cada autor lo guardo en coredata
        if let a = self.authors {
            _ = a.map({AuthorModel(author: $0, book: b, context: c)})
        }
        
        //ahora me recorro los tags
        if let t = self.tags {
            _ = t.map({TagModel(tag: $0, book: b, context:c)})
        }
        
    }
    
}
