//
//  BookModel.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 30/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

//import Foundation

public class BookModel : _BookModel {
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    //MARK: - Inicializadores
    init(title t: String, imageUrl i:String, pdfUrl p: String, context c: NSManagedObjectContext) {
        
        super.init(entity: _BookModel.entity(c), insertIntoManagedObjectContext: c)
        self.title = t
        self.imageUrl = i
        self.pdfUrl = p
        

    }
    
    func tagsString() -> String? {
        //funcion que me devuelve los tags que tiene, separador por ,
        //obtengo los tags que tiene el libro, en self.tags hay un array de TagModel

        //genero un array con todos los tags que hay en el libro, con esto solo saco el tag que es un string y se guarda en arr que es un [String]
        if let arr = self.tags.allObjects as? [TagModel] {
            //si estoy aqui, arr contiene por lo menos un elemento, saco solo los tag
            let a = arr.map({$0.tag!})
            //a contiene un array con los tags, lo devuelvo separado por ,
            return a.joinWithSeparator(", ")
        }
        //si pasa por aqui algun erro ha pasado, asi que devuelvo nil
        return nil

    }
    

}

