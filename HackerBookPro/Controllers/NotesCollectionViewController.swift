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
        super.init(coder: aDecoder)
    }
   
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        registerNib()
        //coloco el boton para neuva nota
        let new = UIBarButtonItem(title: "Nueva Nota", style: .Plain, target: self, action: "newNoteAction")
        self.navigationItem.rightBarButtonItem = new

        self.collectionView?.backgroundColor = UIColor.whiteColor()
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
        
        cell.layer.cornerRadius = 8
        //configurar la celda
        cell.title.text = note.title
        //habilito que si tocan en el textview se seleccione la celda
        cell.title.userInteractionEnabled = false
        let fmt = NSDateFormatter()
        fmt.dateStyle = NSDateFormatterStyle.MediumStyle
        let d = note.modificationDate!
        cell.modification.text = fmt.stringFromDate(d!)
        
        
        
        return cell
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //seleccionan una nota
        
        let nota = self.fetchedResultsController.objectAtIndexPath(indexPath) as! AnnotationModel
        //la mando al modal como si fuera nueva, pero con esta nota en lugar de una recien generada
        showNote(nota)
    }


    // MARK: - Navigation
    
    func newNoteAction() {
        //creo la nota vacia
        let nota = AnnotationModel(book: self.book!, context: self.stack.context)
        
        showNote(nota)
    }
    
    func showNote(nota: AnnotationModel ) {
        
        //inicializo el controlador modal
        let nn = NoteController()
        //coloco las propiedades
        nn.stack = self.stack
        nn.annotation = nota
        //present modal
        //self.presentViewController(nn, animated: true, completion: nil)
        self.navigationController?.pushViewController(nn, animated: true)
    }



}
