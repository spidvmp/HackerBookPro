//
//  NotesViewController.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 25/1/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

import UIKit

class NotesCollectionViewController: AGTCoreDataCollectionViewController {
    
    var stack : AGTSimpleCoreDataStack!
    var book : BookModel!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        registerNib()
    }
    
    
    func registerNib() {
        let  nib = UINib.init(nibName: "NoteCollectionCell", bundle: nil)
        self.collectionView?.registerNib(nib, forCellWithReuseIdentifier: NoteCollectionCell.cellID())
    }
        
    //MARK: - Data source
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        //obtenemos la nota
        let note = self.fetchedResultsController.objectAtIndexPath(indexPath)
        
        //obtenemos la celda
        var cell = collectionView .dequeueReusableCellWithReuseIdentifier(NoteCollectionCell.cellID(), forIndexPath: indexPath)
        
        //configurar la celda
        cell.title = note.title
        
        
        return cell
        
    }


    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "NewNote" {
            //nueva nota
            let destino = segue.destinationViewController as! Annotation
            
            //genero una nueva nota vacia
            let nota = AnnotationModel(book: self.book!, context: self.stack.context)
            
            //coloco las propiedades
            destino.stack = self.stack
            destino.annotation = nota
        }
    }


}
