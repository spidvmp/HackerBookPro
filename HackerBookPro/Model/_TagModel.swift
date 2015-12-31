// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TagModel.swift instead.

import CoreData

public enum TagModelAttributes: String {
    case tag = "tag"
}

public enum TagModelRelationships: String {
    case books = "books"
}

@objc public
class _TagModel: NSManagedObject {

    // MARK: - Class methods

    public class func entityName () -> String {
        return "Tag"
    }

    public class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _TagModel.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged public
    var tag: String?

    // func validateTag(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    // MARK: - Relationships

    @NSManaged public
    var books: BookModel?

    // func validateBooks(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

}

