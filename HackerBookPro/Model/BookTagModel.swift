
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

}
