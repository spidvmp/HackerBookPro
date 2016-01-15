
public class CoverModel: _CoverModel {

	// Custom logic goes here.
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    var image: UIImage? {
        set(img){
            //Me asignan un valor, lo guardo como NSData
            guard (img != nil) else {
                return
            }

            //tengo una imagen
            self.photoData = UIImageJPEGRepresentation(img!, 0.9)

            
        }
        get {
            //saco el valor que es un NSData y devuelvo
            if let a = self.photoData {
                //tengo algun dato, lo transformo a uiimage
                let i = UIImage(data: a)
                return i
            }
            else {
                return nil
            }
            
        }
    }

}
