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
    @IBOutlet weak var favoriteButton: UIButton!
    
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
            if let fav = self.favoriteButton {
                if let f = book.isFavorite as? Bool {
                    if f {
                        //es favorito
                        fav.setTitle("Quitar Favorito", forState: UIControlState.Normal)
                        
                    } else {
                        //no es favorito
                        fav.setTitle("Favorito", forState: UIControlState.Normal)
                        
                    }
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
        }

    }


    //MARK: - Actions
    @IBAction func notesAction(sender: AnyObject) {
        //pulsan el boton de notas, me voy al controlador NoteController pero de la forma tradicional, sin storyboard y con el init
        
        //busco sobre las notas las que tengan como libro el seleccionado
        let fetch = NSFetchRequest(entityName: AnnotationModel.entityName())
        let pred = NSPredicate(format: "book == %@", self.book!)
        let sort = NSSortDescriptor(key:"title", ascending: true)
        fetch.sortDescriptors = [sort]
        fetch.predicate = pred
        let fc = NSFetchedResultsController(fetchRequest: fetch, managedObjectContext: self.book!.managedObjectContext! , sectionNameKeyPath: nil, cacheName: nil)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = NoteCollectionCell.cellSize()
        //con esto indico que el scroll va a ser en vertical
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        layout.minimumLineSpacing = 20.0
        layout.minimumInteritemSpacing = 10.0
        layout.sectionInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)
        
        //layout.scrollDirection = UICollectionViewScrollDirection
        
        let nVC = NotesCollectionViewController(fetchedResultsController: fc, layout: layout)
        nVC.book = self.book
        nVC.stack = self.stack
        self.navigationController?.pushViewController(nVC, animated: true)
    }
    
    @IBAction func favorite(sender: AnyObject) {
        //Pulsan el boton de favorito, compruebo a que valor esta y lo cambio
        if (book!.isFavorite == true) {
            //es favorito y va a dejar de serlo
            self.favoriteButton.setTitle("Favorito", forState: UIControlState.Normal)
            BookTagModel.removeTag(tag: FAVORITE_TAG, fromBook: self.book!, inContext: stack.context)
            self.book!.isFavorite = false
        } else {
            //no es favorito y ahora lo va a ser
            self.favoriteButton.setTitle("Quitar Favorito", forState: UIControlState.Normal)
            TagModel.addTag(tag: FAVORITE_TAG, book: self.book!, context: stack.context)
            self.book!.isFavorite = true
        }
        
        //grabo
        do {
            try stack.context.save()
        }    catch {
            print ("error al grabar en boton favorite")
        }

    }
    
}

