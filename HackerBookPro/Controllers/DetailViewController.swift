//
//  DetailViewController.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 30/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var titleTField: UITextView!
    @IBOutlet weak var tagsTField: UITextView!
    @IBOutlet weak var authorsTField: UITextView!
    
    @IBOutlet weak var readButton: UIButton!
    
    var stack : AGTSimpleCoreDataStack!
    
    var book: BookModel? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
//        if let detail = self.detailItem {
//            if let label = self.detailDescriptionLabel {
//                label.text = detail.description
//            }
//        }
        if let book = self.book {
            //actualizo los datos del modelo a la vista
            if let field = self.titleTField {
                field.text = book.title
            }
            
            if let tag = self.tagsTField {
                tag.text = book.tagsString()
            }
            
            if let aut = self.authorsTField {
                aut.text = book.authorsString()
            }
            
            if let img = self.cover {
                //miro antes a ver que tenga la imagen
                if let i = book.cover?.image {
                    img.image = i
                }
            }
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //aqui hay varias acciones que pueden suceder
        if segue.identifier == "PdfViewer" {
            let destino = segue.destinationViewController as! PdfView
            destino.book = book
            destino.stack = self.stack
        } else  if segue.identifier == "NoteList" {

            //muestro la collection View de las notas
            let destino = segue.destinationViewController as! NotesCollectionViewController
            
            //genero la busqueda de las notas del libro
            let fetch = NSFetchRequest(entityName: AnnotationModel.entityName())
            let fc = NSFetchedResultsController(fetchRequest: fetch, managedObjectContext: self.book!.managedObjectContext! , sectionNameKeyPath: nil, cacheName: nil)
            
            //definmos el layout
            let layout = UICollectionViewLayout()
            
            //layout.itemSize = CGSizeMake(120, 120)
            
            //coloco las propiedades
            destino.stack = self.stack
            destino.book = self.book
            destino.fetchedResultsController = fc
            destino.la
            
        }
    }

}

