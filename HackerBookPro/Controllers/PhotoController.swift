//
//  PhotoController.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 27/1/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

import UIKit

class PhotoController: UIViewController {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var trashButton: UIBarButtonItem!
    
    //me pasan la nota a la que pertenece
    var nota : AnnotationModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //compruebo si tengo algo en la imagen de coredata, si lo tengo lo muestro, si no pongo la imagen por defecto
        var img : UIImage
        if let a = nota.photo?.image {
            img = a
            
        }else {
            img = UIImage(named: "emptyPic.jpg")!
            //deshabilitola posibilidad de borrar
            trashButton.enabled = false
            
        }
        
        //tengo la imagen o de coredata o por defecto
        if let i = photoView {
            i.image = img
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func photoLibrary(sender: AnyObject) {
    }
    @IBAction func takePhoto(sender: AnyObject) {
        //se supone que tengo foto, habilito la posibilidad de biorrar
        trashButton.enabled = true
    }

    @IBAction func deletePhoto(sender: AnyObject) {
    }
}
