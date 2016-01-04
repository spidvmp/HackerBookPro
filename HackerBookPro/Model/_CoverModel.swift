// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to .CoverModel.swift instead.

import CoreData

public enum CoverModelAttributes: String {
    case photoData = "photoData"
}

public enum CoverModelRelationships: String {
    case book = "book"
}

@objc public
class _CoverModel: NSManagedObject {

    // MARK: - Class methods

    public class func entityName () -> String {
        return "CoverImage"
    }

    public class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _CoverModel.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged public
    var photoData: NSData?

    // func validatePhotoData(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    // MARK: - Relationships

    @NSManaged public
    var book: BookModel?

    // func validateBook(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

}

