//
//  AsyncDownload.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 16/1/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

import Foundation

let IMAGE_DID_FINISH_DOWNLOAD = "com.nicatec.HackerPro.imagedidfinishdownload"
let IMAGE_DOWNLOADED = "imagedownloaded"
typealias ImageDictionay = [String: UIImage]

/*
Procedimiento para bajar ficheros de forma asincrona, cuando se lo baje, envia una notificacion
*/


//func downloadImage(book: BookModel) -> Void{
func downloadImage(url: String?, id : NSManagedObjectID) -> Void {
    //me pasan el libro y me tengo que bajar la imagen. La guardo en coredata. Al terminar envio notificacion para quien le interese
    //print(id)
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE,0)) {
        if let u = url{
            //tengo la url
            let data = NSData(contentsOfURL: NSURL(string:u)!)
            if let image = UIImage(data: data!) {
                //tengo la imagen bajada y transformada. ahora solo tengo que grabarlo en coredata
                let stack = AGTSimpleCoreDataStack(modelName: DATA_BASE)
                //sabiendo el id, obtengo el libro, se supone que como no se borra, deberia exister siempre
                if let book = stack.context.objectWithID(id) as? BookModel {
                    //le pongo la imagen bajada
                    print("libro encontrado \(book.title)")
                    book.cover?.image = image
                    //grabo
                    do {
                        try stack.context.save()
                    } catch {
                        print("Error al grabar cover de \(book.title)")
                    }
                }
                //                        }
                //                        //termine de grabar, envio notificacion de que esta descargado
                //                        //genero un diccionario con lo que voy a pasar
                //                        let info : ImageDictionay = [IMAGE_DOWNLOADED: image]
                //                        let not = NSNotification(name: IMAGE_DID_FINISH_DOWNLOAD, object: nil, userInfo: info)
                //                        NSNotificationCenter.defaultCenter().postNotification(not)
            }
            
        }
        
        
    }
    
}