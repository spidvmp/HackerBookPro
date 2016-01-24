//
//  Annotation.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 24/1/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

import UIKit

class Annotation: UIViewController {
    
    //modelo de datos a tratar. Cuando llegue aqui esta creado en coredata
    var annotation : AnnotationModel! = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //sincronizo el modelo con la vista
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //sincronizo la vista con el modelo
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func okButton(sender: AnyObject) {
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
