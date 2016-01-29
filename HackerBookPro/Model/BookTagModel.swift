
typealias BookTagModelArray = [BookTagModel]

@objc(BookTagModel)
public class BookTagModel: _BookTagModel {

	// Esto genera la entidad intermedia BOOKTAg pero no crea sus relaciones
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(newTag t:String, withTitleBook b:String, inContext c:NSManagedObjectContext) {
        super.init(entity: _BookTagModel.entity(c), insertIntoManagedObjectContext: c)
        
        //le añado el nombre copmpuesto por el titulo y el tag todo junto
        self.name = b + t
        
    }
    
    
    //MARK: - Metodos de clase
    class func removeTag(tag t:String, fromBook b:BookModel, inContext c: NSManagedObjectContext) {
        //elimino el registro de booktag que tenga como nombre el formado por y que el libro sea el del parametro
        let query = NSFetchRequest(entityName: BookTagModel.entityName())
        query.predicate = NSPredicate(format: "name == %@", b.title! + t)
        //busco y deberia aparecer solo 1 registro
        do {
            let result = try c.executeFetchRequest(query)
            switch(result.count){
            case 0:
                return
            case 1:
                //me cepillo el registro
                //if let r = result[0] as? BookTagModel {
                //    c.deleteObject(r)
                print(result[0])
                let r = result[0] as! BookTagModel
                c.deleteObject(r)
                do {
                    try r.managedObjectContext!.save()
                }    catch {
                    print ("error al grabar en clase BookTagModel")
                }
                
                //}
                return
                
            default:
                print("Encontrados mas de un tag, al borrar no deberia suceder")
                return
            }
        } catch {
            //error, pues devuelvo nil
            return
        }
        
    }


}
