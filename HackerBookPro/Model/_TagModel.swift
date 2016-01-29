// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TagModel.swift instead.

import CoreData

public enum TagModelAttributes: String {
    case proxyForSorting = "proxyForSorting"
    case tag = "tag"
}

public enum TagModelRelationships: String {
    case bookTags = "bookTags"
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
    var proxyForSorting: String?

    // func validateProxyForSorting(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var tag: String?

    // func validateTag(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    // MARK: - Relationships

    @NSManaged public
    var bookTags: NSSet

}

extension _TagModel {

    func addBookTags(objects: NSSet) {
        let mutable = self.bookTags.mutableCopy() as! NSMutableSet
        mutable.unionSet(objects as! Set<NSObject>)
        self.bookTags = mutable.copy() as! NSSet
    }

    func removeBookTags(objects: NSSet) {
        let mutable = self.bookTags.mutableCopy() as! NSMutableSet
        mutable.minusSet(objects as! Set<NSObject>)
        self.bookTags = mutable.copy() as! NSSet
    }

    func addBookTagsObject(value: BookTagModel!) {
        let mutable = self.bookTags.mutableCopy() as! NSMutableSet
        mutable.addObject(value)
        self.bookTags = mutable.copy() as! NSSet
    }

    func removeBookTagsObject(value: BookTagModel!) {
        let mutable = self.bookTags.mutableCopy() as! NSMutableSet
        mutable.removeObject(value)
        self.bookTags = mutable.copy() as! NSSet
    }

}

