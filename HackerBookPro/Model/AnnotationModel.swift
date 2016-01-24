//@objc(AnnotationModel)

typealias AnnotationModelArray = [AnnotationModel]

public class AnnotationModel: _AnnotationModel {

	
    //MARK: - Inicializador
    init(title: String = "Nueva nota", text : String?, book: BookModel, context c : NSManagedObjectContext) {
        
        super.init(entity: _AnnotationModel.entity(c), insertIntoManagedObjectContext: c)
        //asigno los valores
        self.title = title
        self.text = text
        
        //creo la relacion de la photo, hacemos lo mismo la creamos la relacion pero la foto puede que este vacia, igual que coverimage
        self.photo = PhotoModel(entity: _PhotoModel.entity(c), insertIntoManagedObjectContext: c)
    }

}
