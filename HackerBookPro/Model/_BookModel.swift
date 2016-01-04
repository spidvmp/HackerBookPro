// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to .BookModel.swift instead.

import CoreData

public enum BookModelAttributes: String {
    case imageUrl = "imageUrl"
    case pdfUrl = "pdfUrl"
    case title = "title"
}

public enum BookModelRelationships: String {
    case authors = "authors"
    case tags = "tags"
}

@objc public
class _BookModel: NSManagedObject {

    // MARK: - Class methods

    public class func entityName () -> String {
        return "Book"
    }

    public class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _.BookModel.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged public
    var imageUrl: String?

    // func validateImageUrl(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var pdfUrl: String?

    // func validatePdfUrl(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var title: String?

    // func validateTitle(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    // MARK: - Relationships

    @NSManaged public
    var authors: NSSet

    @NSManaged public
    var tags: NSSet

}

extension _BookModel {

    func addAuthors(objects: NSSet) {
        let mutable = self.authors.mutableCopy() as! NSMutableSet
        mutable.unionSet(objects as! Set<NSObject>)
        self.authors = mutable.copy() as! NSSet
    }

    func removeAuthors(objects: NSSet) {
        let mutable = self.authors.mutableCopy() as! NSMutableSet
        mutable.minusSet(objects as! Set<NSObject>)
        self.authors = mutable.copy() as! NSSet
    }

    func addAuthorsObject(value: AuthorModel!) {
        let mutable = self.authors.mutableCopy() as! NSMutableSet
        mutable.addObject(value)
        self.authors = mutable.copy() as! NSSet
    }

    func removeAuthorsObject(value: AuthorModel!) {
        let mutable = self.authors.mutableCopy() as! NSMutableSet
        mutable.removeObject(value)
        self.authors = mutable.copy() as! NSSet
    }

}

extension _BookModel {

    func addTags(objects: NSSet) {
        let mutable = self.tags.mutableCopy() as! NSMutableSet
        mutable.unionSet(objects as! Set<NSObject>)
        self.tags = mutable.copy() as! NSSet
    }

    func removeTags(objects: NSSet) {
        let mutable = self.tags.mutableCopy() as! NSMutableSet
        mutable.minusSet(objects as! Set<NSObject>)
        self.tags = mutable.copy() as! NSSet
    }

    func addTagsObject(value: TagModel!) {
        let mutable = self.tags.mutableCopy() as! NSMutableSet
        mutable.addObject(value)
        self.tags = mutable.copy() as! NSSet
    }

    func removeTagsObject(value: TagModel!) {
        let mutable = self.tags.mutableCopy() as! NSMutableSet
        mutable.removeObject(value)
        self.tags = mutable.copy() as! NSSet
    }

}

