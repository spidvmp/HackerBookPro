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

    
    var image: UIImage? {
        set{
            //Me asignan un valor, lo guardo como NSData
            if let i = image {
                self.photoData = UIImageJPEGRepresentation(i, 0.9)
            }
            
        }
        get {
            //saco el valor que es un NSData y devuelvo
            if let a = UIImage(data: self.photoData!) {
                return a
            }
            else {
                return nil
            }
        
        }
    }
    

    
}