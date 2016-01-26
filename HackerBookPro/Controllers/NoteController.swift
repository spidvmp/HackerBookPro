//
//  NoteController.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 26/1/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

import UIKit

class NoteController: UIViewController {

    @IBOutlet weak var titleTField: UITextField!
    @IBOutlet weak var textTField: UITextView!
    @IBOutlet weak var okButton: UIButton!

    
    //modelo de datos a tratar. Cuando llegue aqui esta creado en coredata
    
    var stack : AGTSimpleCoreDataStack!
    
    var annotation : AnnotationModel? {
        didSet {
            updateUI()
            
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //sincronizo el modelo con la vista
        //compruebo si la nota viene con datos o viene vacia
        updateUI()
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //sincronizo la vista con el modelo
        if self.annotation != nil {
            //le han dado a borrar
            self.annotation?.title = self.titleTField.text
            self.annotation?.text = self.textTField.text
            
            //se supoen que hemos actualizado
            self.annotation?.modificationDate = NSDate()
        }
        //ahora sea lo que sea, grabo
        do {
            try stack.context.save()
        }    catch {
            print ("error al grabar en el modal")
        }
    }
    
    func updateUI() {
        if let a = self.annotation {
            if let t = self.titleTField {
                t.text = a.title
            }
            
            if let x = self.textTField {
                x.text = a.text
            }
            
            
        }
        
    }
    
    
    //MARK: - Acciones
    
    @IBAction func deleteNote(sender: AnyObject) {
        //se borra la nota, asi que tambien se sale de esta vista
        self.stack.context.deleteObject(self.annotation!)
        self.annotation = nil
        //self.dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
    }


}
