//
//  AsyncDownload.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 16/1/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

import Foundation

//let IMAGE_DID_FINISH_DOWNLOAD = "com.nicatec.HackerPro.imagedidfinishdownload"
//let IMAGE_DOWNLOADED = "imagedownloaded"
//typealias ImageDictionay = [String: UIImage]

/*
Procedimiento para bajar ficheros de forma asincrona, cuando se lo baje, envia una notificacion
*/
enum AsyncDownloadTypes {
    case UIImage
    case PDF
}

class AsyncDownload: NSObject {
    
    //delegado a quien va a pasar los mensajed del protocolo
    var delegate: AsyncDownloadProtocol? = nil
    
    
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
    
    func downloadFile(urlString u: String, type : AsyncDownloadTypes) {
        print("entro en download")
        if let url = NSURL(string: u) {
            //let request = NSURLRequest(URL: url)
            
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession(configuration: config)
//            let task  = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
//                if error == nil {
//                    //tengo los datos en data
//                    print(data)
//                    print(response)
//                }
//            })
            //task.resume()
            
            
            //lo mismo pero pasando la url en vez del request
            let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                if error == nil {

                    //tengo los datos en data, se los paso al delegado, ciompruebo que responde al selector
                    if ((self.delegate != nil) && (self.delegate?.respondsToSelector(Selector("downLoadDidFinish")))!) {
                        self.delegate?.downLoadDidFinish(data!)
                    }

                }
            })
            task.resume()
            
            //        esto funciona pero esta deprecated
            //        let mainQueue = NSOperationQueue.mainQueue()
            //        NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue) { (response, data, error) -> Void in
            //            if error == nil {
            //                let image = UIImage(data:data!)
            //                
            //                
            //            }
            //            print(a)
            //        }
        }

    }
}
//MARK: - Protocol
protocol AsyncDownloadProtocol: NSObjectProtocol {
    //Se ha termiando de bajar
    func downLoadDidFinish(data: NSData)
}