// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AnnotationModel.swift instead.

import CoreData

public enum AnnotationModelAttributes: String {
    case created = "created"
    case text = "text"
    case updated = "updated"
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
    var created: NSDate?

    // func validateCreated(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var text: String?

    // func validateText(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var updated: NSDate?

    // func validateUpdated(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    // MARK: - Relationships

}

