//
//  PdfView.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 15/1/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//
//http://code.tutsplus.com/tutorials/reading-displaying-pdf-documents--mobile-11145
//http://sketchytech.blogspot.com.es/2015/05/adventures-in-pdf-swift-and-pdfkit.htmlp
//https://github.com/mobfarm/FastPdfKit

import UIKit


class PdfView: UIViewController, UIWebViewDelegate, AsyncDownloadProtocol {

    @IBOutlet weak var pdfWebView: UIWebView!
    
    var stack : AGTSimpleCoreDataStack!
    
    //muestro una progreso
    let hud = ProgressHUD(text:"Download")
    //saber si esta bajando algo o no
    var downloading : Bool = false
    
    
    var book : BookModel? {
        //observador de propiedades, sirve para saber cuando se ha modificado una propiedad
        //willSet se llama antes de asignarse la variable y didSet despues de asignarse, asi que en willSet libro es nil y en didSet ya tiene valor
        willSet {
            
        }
        didSet {
            updateUI()
        }
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.pdfWebView.delegate = self
        showPDF(self.book?.pdf?.pdfData)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //si estoy bajando algo, he de quitar el HUD
        if downloading {
            dispatch_async(dispatch_get_main_queue()) {
                self.hud.removeFromSuperview()
            }
        }
    }

    func updateUI(){
        //me han pasado el libro,
        self.title = book?.title
        //compruebo si tengo el pdf bajado
        if self.book!.pdf?.pdfData == nil {
            //hay que bajarselo
            let async = AsyncDownload()
            //me bajo el fichero, lo tengo en book.urlPdf
            async.downloadFile(urlString: (self.book?.pdfUrl)!)
            async.delegate = self
            //muestro el
            self.view.addSubview(hud)

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showPDF(data : NSData?) {
        //compruebo que tengo el dato en coredata
        if let a = data {
            pdfWebView.loadData(a, MIMEType: "application/pdf", textEncodingName: "UTF-8", baseURL: NSURL() )
        }

    }
    

    
    //MARK: - AsyncDownload Protocol
    func downLoadDidFinish(data : NSData) {
        //ha terminado de bajar, lo guardo en su sitio de coredata
        self.book!.pdf?.pdfData = data
        //grabo
        do {
            try self.book?.managedObjectContext?.save()
        } catch {
            print("Error al grabar el pdf")
        }
        
        //termino de bajar, quito el hud
        downloading = false

        //para quitar el hud hay que hacerlo de estaforma, si no viene autolayout y tira la aplicacion en modo Yoda
        dispatch_async(dispatch_get_main_queue()) {
            //self.activity.removeFromSuperview()
            self.hud.removeFromSuperview()
        }
        //lo muestro
        showPDF(data)

    }
    
    func downLoadDidFail(urlString: String) {
        print("Error al cargar \(urlString)")

        //oculto el hud
        downloading = false
        dispatch_async(dispatch_get_main_queue()) {
            self.hud.removeFromSuperview()
        }
    }
    


}
