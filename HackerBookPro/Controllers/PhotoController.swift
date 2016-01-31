//
//  PhotoController.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 27/1/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//
//http://makeapppie.com/2014/12/04/swift-swift-using-the-uiimagepickercontroller-for-a-camera-and-photo-library/


import UIKit


class PhotoController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var trashButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!

    
    //me pasan la nota a la que pertenece
    var nota : AnnotationModel!
    //control para saber si me voy al carrete o a la camara
    var exitToTakeAPic: Bool = false
    
    //defino el picker
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self

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
            //recalculo el tamaño
            //recalculatePhotoViewFrameWithNewSize(photoView.image?.size)
        }
        
        //compruebo si tengo opcion a sacar una foto
        if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Rear) {
            //hay camara
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            //habilito el boton
            cameraButton.enabled = true
        } else {
            //no hay camara
            cameraButton.enabled = false
        }
        
        //acabo de entrar, asi que a false que salgo a tomar foto
        exitToTakeAPic = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        //conpruebo si salgo por irme a la foto o al carrete
        if exitToTakeAPic {
            return
        }
        // no voy a tomar una foto, pongo la foto tomada en coredata
        self.nota.photo?.image = self.photoView.image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: - Actions
    @IBAction func photoLibrary(sender: AnyObject) {
        //lo pongo a true para que mno haga nada al salir
        exitToTakeAPic = true
        
        
        //asigno el carrete
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(picker, animated: true, completion: nil)
        
    }
    @IBAction func takePhoto(sender: AnyObject) {
        //lo pongo a true para que mno haga nada al salir
        exitToTakeAPic = true
        
        //se supone que tengo foto, habilito la posibilidad de biorrar
        trashButton.enabled = true
        picker.allowsEditing = false
        // ya comprobe en el willapperar si tengo opcion de foto
        
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        picker.cameraCaptureMode = .Photo
        picker.modalPresentationStyle = .FullScreen
        presentViewController(picker, animated: true, completion: nil)
        
    }

    @IBAction func deletePhoto(sender: AnyObject) {
    }
    
    //MARK: - PickerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //de aqui  tengo que sacar la imagen seleccionada
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //hay que modificar el taamañop de la imagen la reduzco al 20% del tamaño real
        let newPhotoSize = CGSizeMake(chosenImage.size.width * 0.20, chosenImage.size.height * 0.20)
        //se la coloco al coredata
        self.nota.photo?.image = chosenImage.resizedImage(newPhotoSize, interpolationQuality: CGInterpolationQuality.Medium)

        //ya hanseleccionado la foto, desactivo el que me fui a por algo
        exitToTakeAPic = false

        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
}


