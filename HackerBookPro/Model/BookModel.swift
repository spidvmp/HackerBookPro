//
//  BookModel.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 30/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

import Foundation

class BookModel {
    
    //definos las propiedades
    let title : String!
    
    
    //MARK: - Inicializadores
    init (title: String) {
        self.title = title
    }
    
    
    
}

//MARK: - Extensiones
extension BookModel: CustomStringConvertible {
    
    var description: String {
        get {
            return "<\(self.dynamicType): \(title)"
        }
    }
}
