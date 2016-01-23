//
//  AuthorModel.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 30/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

//import Foundation

typealias AuthorModelArray = [AuthorModel]

public class AuthorModel: _AuthorModel {
    //MARK: - inicializadores
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(author a: String, book b:BookModel, context c: NSManagedObjectContext) {
        //recibo un solo autor, lo inserto y lo asocio con el libro.
        super.init(entity: _AuthorModel.entity(c), insertIntoManagedObjectContext: c)
        self.name = a
        
        //añado el libro a los autores
        let au = self.books as! NSMutableSet
        au.addObject(b)
        self.books = au
        
        //la relacion es to many, asi que saco lo que hay y añado este
//        let aut = b.authors as! NSMutableSet
//        aut.addObject(self)
//        b.authors = aut

        
    }
    
    //MARK: - Metodos de clase de Autor
    class func addAuthor(author a: String, book b:BookModel, context c: NSManagedObjectContext) {
        //primero busco si existe el author
        
        var author = AuthorModel.findAuthor(author: a, context: c)
        if author == nil {
            //no lo encontro, lo creo
            author = AuthorModel(author: a, book: b, context: c)
        }
        
        b.addAuthorsObject(author)
        
//        //ahora tenemos la entidad autor, o existeia o la ha creado, se lo añado al libro
//        //la relacion es to many, asi que saco lo que hay y añado este
//        let aut = b.authors as! NSMutableSet
//        if let authorCoreData = author {
//            //no es nil, hay autor
//            aut.addObject(authorCoreData)
//            b.authors = aut
//        }
        
        
        
    }
    
    class func findAuthor(author a: String, context c:NSManagedObjectContext) -> AuthorModel? {
        //busca el nombre del autor, si existe devuelve la entidfad, si no existe devuelve nil
        
        let query = NSFetchRequest(entityName: self.entityName())
        query.predicate = NSPredicate(format: "name == '\(a)'")
        //busco, deberia aparecer 1 o ninguno
        do {
            let result = try c.executeFetchRequest(query)
            switch(result.count){
            case 0:
                return nil
            case 1:
                return result[0] as? AuthorModel

            default:
                print("Encontrados mas de un autor, no deberia suceder")
                return result[0] as? AuthorModel
            }
        } catch {
            //error, pues devuelvo nil
            return nil
        }


    }

    
}

    
    