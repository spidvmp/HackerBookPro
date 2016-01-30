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
    let hud = ProgressHUD(text:"Downloading")
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //compruebo si tengo el pdf, si no lo tengo lo bajo usando AsyncDownload
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.pdfWebView.delegate = self
        

        
        //me apunto a a las notificaciones de cambio de libro
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "bookDidChange:", name: BOOK_DID_CHANGE, object: nil)
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //si estoy bajando algo, he de quitar el HUD
        if downloading {
            self.hud.removeFromSuperview()
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
            //self.view.addSubview(hud)
            
        } else {
            //tengo el fichero cargado, asi que lo muestro
            if let a = self.book!.pdf?.pdfData {
                showPDF(a)
            }
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showPDF(data : NSData) {

        pdfWebView.loadData(data, MIMEType: "application/pdf", textEncodingName: "UTF-8", baseURL: NSURL() )
        
    }
    
//    func bookDidChange(not : NSNotification ){
//        //libro = not.object as? NCTBook
////        if let dic = not.userInfo as? Dictionary<String, NCTBook> {
////            libro = dic["book"]!
////        }
//        
//        showPDF()
//        
//    }
    
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
        //downloading = false
        //hud.removeFromSuperview()
        
        //lo muestro
        showPDF(data)

    }
    
    func downLoadDidFail(urlString: String) {
        print("Error al cargar \(urlString)")
        //oculto el hud
//        downloading = false
//        self.hud.removeFromSuperview()
    }
    


}
