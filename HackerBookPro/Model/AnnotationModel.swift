//
//  AnnotationModel.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 30/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

import Foundation

class AnnotationModel {
    
    let text : String!
    let created : NSDate!
    let updated : NSDate!
    
    //MARK: - inicializadores
    init(text : String){
        self.text = text
        self.created = NSDate()
        self.updated = NSDate()
    }
    
    
}

//MARK: - Extensiones
extension AnnotationModel: CustomStringConvertible {
    
    var description: String {
        get {
            return "<\(self.dynamicType): \(text)"
        }
    }
}
