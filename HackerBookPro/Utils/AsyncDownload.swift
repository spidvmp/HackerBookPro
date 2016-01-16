//
//  AsyncDownload.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 16/1/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

import Foundation

let IMAGE_DID_FINISH_DOWNLOAD = "imagedidfinishdownload"

/*
Procedimiento para bajar ficheros de forma asincrona, cuando se lo baje, envia una notificacion
*/

//class AsyncDownload {
//    
//    //tengo un init de conveniencia para cuando me bajo una portada o un pdf
//    convenience init(imageUrl : NSURL, book: BookModel ){
//        
//    }
//    
//    
//}

func downloadImage(book: BookModel){
    //me pasan el libro y me tengo que bajar la imagen. La guardo en coredata. Al terminar envio notificacion para quien le interese
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE,0)){
        //como me pasan el libro y tengo que bajarme la imagen, la saco de aqui
        if let url = book.imageUrl{
            //tengo la url
            let data = NSData(contentsOfURL: NSURL(string:url)!)
            let img = UIImage(data: data!)
            if let image = img {
                //tengo la imagen bajada y transformada. ahora solo tengo que grabarlo en coredata
                
                //termine de grabar, envio notificacion de que esta descargado
                    let not = NSNotification(name: IMAGE_DID_FINISH_DOWNLOAD, object: self, userInfo: <#T##[NSObject : AnyObject]?#>)
                    NSNotificationCenter.defaultCenter().postNotification(not)
            }
            
        }
    }
    
    
    

}