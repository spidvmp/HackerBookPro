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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
