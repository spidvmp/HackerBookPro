//
//  PhotoModel.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 30/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

//import UIKit

public class PhotoModel: _PhotoModel {
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
//    let photoData : NSData?
//    
//    init(image: UIImage){
//
//        if let a = UIImageJPEGRepresentation(image, 0.9) {
//            self.photoData = a
//        } else {
//            self.photoData = nil
//        }
//
//    }
//    
//    //obtengo la imagen transformada de NSData
//    func image() -> UIImage? {
//        if let a = UIImage(data: self.photoData!) {
//            return a
//        }
//        else {
//            return nil
//        }
//
//    }
//    
}