//
//  TagModel.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 30/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

//import Foundation

typealias TagModelArray = [TagModel]

public class TagModel : _TagModel {
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    //MARK: - Inicializadores
    init(tag t: String, book b:BookModel, context c: NSManagedObjectContext) {
        //recibo un solo autor, lo inserto y lo asocio con el libro.
        super.init(entity: _TagModel.entity(c), insertIntoManagedObjectContext: c)
        self.tag = t
        //incluyo book a los libros del tag
        let bk = self.books as! NSMutableSet
        bk.addObject(b)
        self.books = bk
        
        //como es tomany, saco lo que hay y añado este
//        let tg = b.tags as! NSMutableSet
//        tg.addObject(self)
//        b.tags = tg
        
    }
    
    //MARK: - Metodos de clase de Tag
    class func addTag(tag t: String, book b:BookModel, context c: NSManagedObjectContext) {
        //primero busco si existe el tag
        
        var tag = TagModel.findTag(tag: t, context: c)
        if tag == nil {
            //no lo encontro, lo creo
            tag = TagModel(tag: t, book: b, context: c)
        }
        
        
        b.addTagsObject(tag)
        //ahora tenemos la entidad tag, o existeia o la ha creado, se lo añado al libro
        //la relacion es to many, asi que saco lo que hay y añado este
//        let tg = b.tags as! NSMutableSet
//        
//        if let tagCoreData = tag {
//            //no es nil, hay tag
//            tg.addObject(tagCoreData)
//
//            b.tags = tg
//        }
        
        
        
    }
    
    class func booksWithTagLike(tag t:String, context c:NSManagedObjectContext) -> BookModelArray? {
        //devuelve un array con los libros cuyo tag coincida con lo pedido, es para el search
        let query = NSFetchRequest(entityName: TagModel.entityName())
        
        //array de NSSortDescriptors
        query.sortDescriptors = [NSSortDescriptor(key: "tag", ascending: true)]
        query.predicate = NSPredicate(format: "tag contains [cd] %@", t)
        
        do {
            let res = try c.executeFetchRequest(query) as? TagModelArray
            //ahora con todos los tags he de recorreme todos los libros que tienen cada tag
            var booksSet = Set<BookModel>()
            for each in res! {
                //inseto los libros en el conjunto para evitar que se repitan
                _ = each.books.map({booksSet.insert($0 as! BookModel)})
            }
            //ahora obtengo el array de libros
            let arr = booksSet.map({$0})
            return arr
            
            
        } catch {
            return nil
        }
    }
    
    class func findTag(tag t: String, context c:NSManagedObjectContext) -> TagModel? {
        //busca el nombre del tag, si existe devuelve la entidfad, si no existe devuelve nil
        
        let query = NSFetchRequest(entityName: self.entityName())
        query.predicate = NSPredicate(format: "tag == '\(t)'")
        //busco, deberia aparecer 1 o ninguno
        do {
            let result = try c.executeFetchRequest(query)
            switch(result.count){
            case 0:
                return nil
            case 1:
                return result[0] as? TagModel
                
            default:
                print("Encontrados mas de un tag, no deberia suceder")
                return result[0] as? TagModel
            }
        } catch {
            //error, pues devuelvo nil
            return nil
        }
        
        
    }
    
}