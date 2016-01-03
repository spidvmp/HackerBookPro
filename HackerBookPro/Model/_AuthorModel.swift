// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to .AuthorModel.swift instead.

import CoreData

public enum AuthorModelAttributes: String {
    case name = "name"
}

public enum AuthorModelRelationships: String {
    case booksWriten = "booksWriten"
}

@objc public
class _AuthorModel: NSManagedObject {

    // MARK: - Class methods

    public class func entityName () -> String {
        return "Author"
    }

    public class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _AuthorModel.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged public
    var name: String?

    // func validateName(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    // MARK: - Relationships

    @NSManaged public
    var booksWriten: BookModel?

    // func validateBooksWriten(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

}

