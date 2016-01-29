// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BookTagModel.swift instead.

import CoreData

public enum BookTagModelAttributes: String {
    case name = "name"
}

public enum BookTagModelRelationships: String {
    case book = "book"
    case tag = "tag"
}

@objc public
class _BookTagModel: NSManagedObject {

    // MARK: - Class methods

    public class func entityName () -> String {
        return "BookTag"
    }

    public class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _BookTagModel.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged public
    var name: String?

    // func validateName(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    // MARK: - Relationships

    @NSManaged public
    var book: BookModel?

    // func validateBook(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var tag: TagModel?

    // func validateTag(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

}

