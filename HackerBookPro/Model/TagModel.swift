//
//  TagModel.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 30/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

import Foundation

class TagModel {
    
    let tag : String!
    
    
    //MARK: - inicializadores
    init(tag : String){
        self.tag = tag
    }
    
    
}

//MARK: - Extensiones
extension TagModel: CustomStringConvertible {
    
    var description: String {
        get {
            return "<\(self.dynamicType): \(tag)"
        }
    }
    
    
}