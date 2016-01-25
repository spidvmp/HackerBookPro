//
//  NotesViewController.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 25/1/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

import UIKit

class NotesCollectionViewController: AGTCoreDataCollectionViewController {
//class NotesCollectionViewController: UICollectionViewController {
    
    var stack : AGTSimpleCoreDataStack!
    var book : BookModel!
    

    override init!(fetchedResultsController resultsController: NSFetchedResultsController!, layout: UICollectionViewLayout!) {
        super.init(fetchedResultsController: resultsController, layout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
    
        super.init(coder: aDecoder)

        
    }
    
    

    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        registerNib()
        //coloco el boton para neuva nota
        let new = UIBarButtonItem(title: "Nueva Nota", style: .Plain, target: self, action: "newNoteAction")
        self.navigationItem.rightBarButtonItem = new
        //new.set
    }
    
    
    func registerNib() {
        let  nib = UINib.init(nibName: "NoteCollectionCell", bundle: nil)
        self.collectionView?.registerNib(nib, forCellWithReuseIdentifier: NoteCollectionCell.cellId())
    }
        
    //MARK: - Data source
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        //obtenemos la nota
        let note = self.fetchedResultsController.objectAtIndexPath(indexPath)
        
        //obtenemos la celda
        let cell = collectionView .dequeueReusableCellWithReuseIdentifier(NoteCollectionCell.cellId(), forIndexPath: indexPath) as! NoteCollectionCell
        
        //configurar la celda
        cell.title.text = note.title
        
        
        return cell
        
    }


    // MARK: - Navigation
    
    func newNoteAction() {
        //han pulsado que quieren nueva nota
        let nn  = Annotation()
        
        //creo la nota
        let nota = AnnotationModel(book: self.book!, context: self.stack.context)
        
        //coloco las propiedades
        nn.stack = self.stack
        nn.annotation = nota
        //present modal
        self.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        //self.modalPresentationStyle = .CurrentContext
        self.navigationController?.presentViewController(nn, animated: true, completion: nil)
        
    }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        
//        if segue.identifier == "NewNote" {
//            //nueva nota
//            let destino = segue.destinationViewController as! Annotation
//            
//            //genero una nueva nota vacia
//            let nota = AnnotationModel(book: self.book!, context: self.stack.context)
//            
//            //coloco las propiedades
//            destino.stack = self.stack
//            destino.annotation = nota
//            
//        }
//    }


}
