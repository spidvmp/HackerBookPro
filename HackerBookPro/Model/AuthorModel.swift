//
//  AuthorModel.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 30/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

typealias AuthorModelArray = [AuthorModel]

@objc(AuthorModel)
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
    }
    
    class func booksWithAuthorLike(author a:String, context c:NSManagedObjectContext) -> BookModelArray? {
        //devuelve un array con los libros cuyo autor coincida con lo pedido, es para el search
        let query = NSFetchRequest(entityName: AuthorModel.entityName())
        
        //array de NSSortDescriptors
        query.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        query.predicate = NSPredicate(format: "name contains [cd] %@", a)
        
        do {
            //primero busco todos los autores que encajen con lo puesto en el search
            let aut = try c.executeFetchRequest(query) as? AuthorModelArray
            
            //ahora con todos estos autores, he de sacar los libros que han escrito, se pueden repetir, asi que lo meto en un NSSet
            //creo el conjunto de libros vacio
            var booksSet = Set<BookModel>()

            for each in aut! {
                //inserto los libros que tenga en el conjunto
                _ = each.books.map({booksSet.insert($0 as! BookModel)})
            }
            //tengo un nsset de BookModel, he de obtener un array ordenado
            let arr = booksSet.map({$0})
            return arr
            
        } catch {
            return nil
        }
        
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

    
    