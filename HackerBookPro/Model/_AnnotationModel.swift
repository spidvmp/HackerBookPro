// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AnnotationModel.swift instead.

import CoreData

public enum AnnotationModelAttributes: String {
    case creationDate = "creationDate"
    case modificationDate = "modificationDate"
    case text = "text"
    case title = "title"
}

public enum AnnotationModelRelationships: String {
    case book = "book"
    case location = "location"
    case photo = "photo"
}

@objc public
class _AnnotationModel: NSManagedObject {

    // MARK: - Class methods

    public class func entityName () -> String {
        return "Annotation"
    }

    public class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _AnnotationModel.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged public
    var creationDate: NSDate?

    // func validateCreationDate(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var modificationDate: NSDate?

    // func validateModificationDate(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var text: String?

    // func validateText(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var title: String?

    // func validateTitle(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    // MARK: - Relationships

    @NSManaged public
    var book: BookModel?

    // func validateBook(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var location: LocationModel?

    // func validateLocation(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var photo: PhotoModel?

    // func validatePhoto(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

}

