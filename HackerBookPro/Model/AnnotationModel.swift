

typealias AnnotationModelArray = [AnnotationModel]

@objc(AnnotationModel)
public class AnnotationModel: _AnnotationModel {

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    init(book: BookModel, context c: NSManagedObjectContext) {
        super.init(entity: _AnnotationModel.entity(c), insertIntoManagedObjectContext: c)
        self.title = "Nueva nota"
        self.text = ""
        self.creationDate = NSDate()
        self.modificationDate = NSDate()
        
        //creo la relacion de la photo, hacemos lo mismo la creamos la relacion pero la foto puede que este vacia, igual que coverimage
        self.photo = PhotoModel(entity: _PhotoModel.entity(c), insertIntoManagedObjectContext: c)
        //creo la relacion con el libro
        self.book = book
        //book.addAnnotationsObject(self)
    }

}
