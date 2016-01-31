//
//  TagModel.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 30/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//


typealias TagModelArray = [TagModel]
typealias SetBookModel = Set<BookModel>

@objc(TagModel)
public class TagModel : _TagModel {
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    //MARK: - Inicializadores
    init(tag t: String, book b:BookModel, context c: NSManagedObjectContext) {
        //recibo un solo autor, lo inserto y lo asocio con el libro.
        super.init(entity: _TagModel.entity(c), insertIntoManagedObjectContext: c)
        self.tag = t
        //incluyo el proxySort, que sera igual que el tag excepto para el favorito
        if t == FAVORITE_TAG {
            self.proxyForSorting = "__" + FAVORITE_TAG
        } else {
            self.proxyForSorting = t
        }
       
    }
    
    //MARK: - Metodos de clase de Tag
    class func addTag(tag t: String, book b:BookModel, context c: NSManagedObjectContext) {
        /*
        utilizo este metodo para crear un tag de un libro. Esto supone buscar a ver si ya existe el tag y no repetirlo, una vez que tenemos el objeto tag, creo una entidad intermedia BOOKTAG que sirve para romper la relacion N-N que se generaria con los libros, asi que BOOKTAG con tag tiene una relacion de 1 TAG N BOOKTAG y 1 BOOKTAG tiene 1 tag y por otro lado BOOKTAG se conecta con los libros en una relacion similar, un BOOKTAG tiene 1 libro y un libro tiene N BOOKTAG

        */
        //primero busco si existe el tag
        
        var tag = TagModel.findTag(tag: t, context: c)
        if tag == nil {
            //no lo encontro, lo creo
            tag = TagModel(tag: t, book: b, context: c)
        }
        
        //tengo la entidad tag, sin relacionar con nada. Cero la entidad BookTag, que es con quien voy a relacionar el tag y el libro
        //necesita el nombre del tag y el nnombre del libro y porsupu el contexto
        let bookTag = BookTagModel(newTag: t, withTitleBook: b.title!, inContext: c)
        
        //ya tengo la entidad tag, la intermedia BookTag y el libro, he de relacionarlas
        //el bookTag tiene un solo tag
        bookTag.tag = tag
        //el booktag solo tiene un libro
        bookTag.book = b

    }

 
    class func booksWithTagLike(tag t:String, context c:NSManagedObjectContext) -> BookModelArray? {
        //devuelve un array con los libros cuyo tag coincida con lo pedido, es para el search
        let query = NSFetchRequest(entityName: TagModel.entityName())
        
        //array de NSSortDescriptors, busco toos los tags que coincidan con lo seleccionado
        query.sortDescriptors = [NSSortDescriptor(key: "tag", ascending: true)]
        query.predicate = NSPredicate(format: "tag contains [cd] %@", t)
        
        do {
            if let res = try c.executeFetchRequest(query) as? TagModelArray {
                //en res tengo los tags que coinciden, he de obtener los libros, asi que tengo que pasar por la entidad intermedia de BookTag
                var booksSet : SetBookModel = Set()
                //me recorro el resultado. res es de tipo TagModel, ha buscado en tags
                for each in res {
                    //ahora del tag he de obtener cuantos libros tiene este tag, eso esta en la relacion con BookTag, asi que necesito el booktag al que apunta
                    //booktags es un NSSet de todos los libros que tiene el tag (uno en concreto, me estoy recorriendo todos los tags que encontro y de ahi todos los libros)
                    let booktags = each.bookTags
                    
                    //ahora inseto los libros en elñ conjunto de libros, es un Set para evitar repetidos
                    //_ = booktags.map({booksSet.insert($0.book as! BookModel)})
                    
                    //inseto los libros en el conjunto para evitar que se repitan
                    //_ = each.books.map({booksSet.insert($0 as! BookModel)})
                }
                //ahora obtengo el array de libros
                let arr = booksSet.map({$0})
                return arr
            }
            //no hay res, asi que retirn nil
            return nil
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