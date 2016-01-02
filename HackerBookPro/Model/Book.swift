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
    
    
    //MARK: - Inicializadores
    init(title: String!) {
        self.title = title
    }
    
}
