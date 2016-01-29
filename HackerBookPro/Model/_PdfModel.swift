// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PdfModel.swift instead.

import CoreData

public enum PdfModelAttributes: String {
    case pdfData = "pdfData"
}

public enum PdfModelRelationships: String {
    case book = "book"
}

@objc public
class _PdfModel: NSManagedObject {

    // MARK: - Class methods

    public class func entityName () -> String {
        return "PdfContainer"
    }

    public class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _PdfModel.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged public
    var pdfData: NSData?

    // func validatePdfData(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    // MARK: - Relationships

    @NSManaged public
    var book: BookModel?

    // func validateBook(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

}

