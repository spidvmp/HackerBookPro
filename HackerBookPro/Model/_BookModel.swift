// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to .BookModel.swift instead.

import CoreData

public enum BookModelAttributes: String {
    case imageUrl = "imageUrl"
    case pdfUrl = "pdfUrl"
    case title = "title"
}

public enum BookModelRelationships: String {
    case annotations = "annotations"
    case authors = "authors"
    case cover = "cover"
    case pdf = "pdf"
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
        let entity = _BookModel.entity(managedObjectContext)
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
    var annotations: NSSet

    @NSManaged public
    var authors: NSSet

    @NSManaged public
    var cover: CoverModel?

    // func validateCover(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var pdf: PdfModel?

    // func validatePdf(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var tags: NSSet

}

extension _BookModel {

    func addAnnotations(objects: NSSet) {
        let mutable = self.annotations.mutableCopy() as! NSMutableSet
        mutable.unionSet(objects as! Set<NSObject>)
        self.annotations = mutable.copy() as! NSSet
    }

    func removeAnnotations(objects: NSSet) {
        let mutable = self.annotations.mutableCopy() as! NSMutableSet
        mutable.minusSet(objects as! Set<NSObject>)
        self.annotations = mutable.copy() as! NSSet
    }

    func addAnnotationsObject(value: AnnotationModel!) {
        let mutable = self.annotations.mutableCopy() as! NSMutableSet
        mutable.addObject(value)
        self.annotations = mutable.copy() as! NSSet
    }

    func removeAnnotationsObject(value: AnnotationModel!) {
        let mutable = self.annotations.mutableCopy() as! NSMutableSet
        mutable.removeObject(value)
        self.annotations = mutable.copy() as! NSSet
    }

}

extension BookModel {

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

