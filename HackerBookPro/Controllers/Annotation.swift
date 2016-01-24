//
//  Annotation.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 24/1/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

import UIKit

class Annotation: UIViewController {
    
    @IBOutlet weak var titleTField: UITextField!
    @IBOutlet weak var textTField: UITextView!
    
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
        }
        //ahora sea lo que sea, grabo
        do {
            try stack.context.save()
            print ("grabado en annotation modal")
        }    catch {
            print ("error al grabar")
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
    @IBAction func okButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func deleteNote(sender: AnyObject) {
        //se borra la nota, asi que tambien se sale de esta vista
        self.stack.context.deleteObject(self.annotation!)
        self.annotation = nil
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
