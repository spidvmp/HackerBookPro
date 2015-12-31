//
//  PdfModel.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 30/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

import Foundation


class PdfModel {
    
    let pdfData : NSData?
    
    init(pdf: NSData){

        self.pdfData = pdf

        
    }
    
    //obtengo la imagen transformada de NSData
    func pdf() -> NSData? {
        return self.pdfData
    }
    
}