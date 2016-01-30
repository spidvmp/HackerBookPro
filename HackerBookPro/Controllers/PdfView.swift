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
            
        } else {
            //tengo el fichero cargado, asi que lo muestro
            showPDF((self.book!.pdf?.pdfData)!)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showPDF(data : NSData) {

        pdfWebView.loadData(data, MIMEType: "application/pdf", textEncodingName: "UTF-8", baseURL: NSURL(fileURLWithPath: "http://a.com") )
        
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
        
        //lo muestro
        showPDF(data)

    }
    
    func downLoadDidFail(urlString: String) {
        print("Error al cargar \(urlString)")
    }
    


}
