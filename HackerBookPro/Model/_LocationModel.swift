// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LocationModel.swift instead.

import CoreData

public enum LocationModelAttributes: String {
    case address = "address"
    case latitude = "latitude"
    case longitude = "longitude"
}

public enum LocationModelRelationships: String {
    case annotations = "annotations"
}

@objc public
class _LocationModel: NSManagedObject {

    // MARK: - Class methods

    public class func entityName () -> String {
        return "Location"
    }

    public class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _LocationModel.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged public
    var address: String?

    // func validateAddress(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var latitude: NSNumber?

    // func validateLatitude(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var longitude: NSNumber?

    // func validateLongitude(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    // MARK: - Relationships

    @NSManaged public
    var annotations: NSSet

}

extension _LocationModel {

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

