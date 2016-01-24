//
//  LocationModel.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 24/1/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

import Foundation

public class LocationModel: _LocationModel {
    
    //MARK: - Inicializador
    init(latitude: Double, longitude: Double, annotation: AnnotationModel, context c: NSManagedObjectContext) {
        super.init(entity: _LocationModel.entity(c), insertIntoManagedObjectContext: c)
        self.latitude = latitude
        self.longitude = longitude
        
        //añado las coordenadas a la anotacion
        self.addAnnotationsObject(annotation)
    }

}