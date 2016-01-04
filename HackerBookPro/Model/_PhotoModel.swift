// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to .PhotoModel.swift instead.

import CoreData

public enum PhotoModelAttributes: String {
    case photoData = "photoData"
}

public enum PhotoModelRelationships: String {
    case annotation = "annotation"
}

@objc public
class _PhotoModel: NSManagedObject {

    // MARK: - Class methods

    public class func entityName () -> String {
        return "PhotoContainer"
    }

    public class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _PhotoModel.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged public
    var photoData: NSData?

    // func validatePhotoData(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    // MARK: - Relationships

    @NSManaged public
    var annotation: AnnotationModel?

    // func validateAnnotation(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

}

