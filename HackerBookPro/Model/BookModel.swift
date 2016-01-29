//
//  BookModel.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 30/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

typealias BookModelArray = [BookModel]


enum BookProcessing : ErrorType{
    case WrongObjectID
    case WrongTitle
}


@objc(BookModel)
public class BookModel : _BookModel {
    
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    //MARK: -Metodos de clase
    class func bookWithID(id: NSManagedObjectID, context: NSManagedObjectContext) throws -> BookModel {
        //busco el id del libro
        do {
            let object = try context.existingObjectWithID(id)
            return object as! BookModel
        } catch {
            throw BookProcessing.WrongObjectID
        }
   
    }
    
    class func booksWithTitleLike(title t:String, context c:NSManagedObjectContext) -> BookModelArray? {
        //devuelve un array con los loibros cuyo titulo coincida con lo pedido, es para el search
        let query = NSFetchRequest(entityName: BookModel.entityName())
        
        //array de NSSortDescriptors
        query.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        query.predicate = NSPredicate(format: "title contains [cd] %@", t)
        
        do {
            let res = try c.executeFetchRequest(query) as? BookModelArray
            return res
            
        } catch {
            return nil
        }
    }
    
    //MARK: - Inicializadores
    init(title t: String, imageUrl i:String, pdfUrl p: String, context c: NSManagedObjectContext) {
        
        super.init(entity: _BookModel.entity(c), insertIntoManagedObjectContext: c)
        self.title = t
        self.imageUrl = i
        self.pdfUrl = p
        
        //he de crear la relacion con la portada, aunque todavia no me haya bajado la imagen
        self.cover = CoverModel(entity: _CoverModel.entity(c), insertIntoManagedObjectContext: c)
        self.pdf = PdfModel(entity: _PdfModel.entity(c), insertIntoManagedObjectContext: c)

    }
    
    
    func tagsString() -> String? {
        //funcion que me devuelve los tags que tiene, separador por ,
        //obtengo los tags que tiene el libro, en self.tags hay un array de TagModel

        //genero un array con todos los tags que hay en el libro, con esto solo saco el tag que es un string y se guarda en arr que es un [String]
        //if let arr = self.tags.allObjects as? TagModelArray {
        
        print("Corregir tagsString en BookModel")
        return "hola como estas"
        
        if let arrBookTag = self.bookTags as? BookTagModelArray {
            //tengo un array de los booktag intermedios. he de sacar el array de los tags que tiene
            let arr = arrBookTag.map({$0.tag!})
            //si estoy aqui, arr contiene por lo menos un elemento, saco solo los tag
            let a = arr.map({$0.tag!})
            //a contiene un array con los tags, lo devuelvo separado por ,
            return a.joinWithSeparator(", ")
        }
        //si pasa por aqui algun erro ha pasado, asi que devuelvo nil
        return nil

    }
    
    func authorsString() -> String? {
        //similar a los tags, devuelve un string con los escritores del libro
        if let wri = self.authors.allObjects as? AuthorModelArray {
            //wri contiene el liestado de los escritores. w sera un array con los nombres
            let w = wri.map({$0.name!})
            
            //devuelvo el string con los autores y la primera letea en mayuscula
            return w.joinWithSeparator(", ").capitalizedString
            
        }
        //si estoy aqui es que por algun motivi no hay autores
        return nil
    }
    

}

