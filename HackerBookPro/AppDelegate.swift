//
//  AppDelegate.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 30/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

import UIKit


@UIApplicationMain
@objc class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?
    var stack : AGTSimpleCoreDataStack!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        print(NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])
        //creamos el stack del coredata
        stack = AGTSimpleCoreDataStack(modelName: DATA_BASE)
        
        //esto se cambia para que se baje o no
//        print("borro la BD")
//        stack.zapAllData()
//        print("userdefaults a false para volver a cargar")
//        let def = NSUserDefaults.standardUserDefaults()
//        def.setBool(false, forKey: FIRST_TIME)

        
        
        //comprobamos si es la primera vez y hay que bajar el json
        checkDownloadedJSON()
     
      
        
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
        splitViewController.delegate = self
        
        //he de acceder al masterViewController para pasarle el stack
        //Master esta en el elemento 0 de los controladores de splitViewController
        let mastNav = splitViewController.viewControllers[0] as! UINavigationController
        let mast = mastNav.viewControllers[0] as! MasterViewController
        mast.stack = self.stack
        
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        
        //grabo los datos en BD
        do {
            try stack.context.save()
            print ("grabado en resignActive")
        }    catch {
            print ("error al grabar")
        }
//        stack.saveWithErrorBlock { (NSError!) -> Void in
//            print("Error al grabar")
//        }
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - Split view

    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController, ontoPrimaryViewController primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
        if topAsDetailController.book == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }
    
    
    //MARK: - Bajar JSON
    func checkDownloadedJSON () {
        //comprueba si ya se ha bajado la primera vez el json, si es que no, se lo baja, lo trata y lo guarda en coredata. Las imagenes se deberian ir cargando segun se necesitasen
        let def = NSUserDefaults.standardUserDefaults()
        //print("Puesto a piñon fijo que es la primera vez")
        
        
        if !def.boolForKey(FIRST_TIME) {
            
            //es la primera vez, me tengo que bajar todo y tratarlo
            //dowloadJSON se baja el JSON trata los datos, devuelve un array de StructBook
            if let arrayLibros = self.downloadJSON() {
                //aqui tengo un array de Book con todos los datos, ahora deberia guardar  en coredata
                for l in arrayLibros {
                    //esto guarda en coredata todo lo referente al libro, en la estructura que tenga que ser
                    l.saveToCoreData(context: self.stack.context)
                    
                }
                
                //lo suyo es grabar todo coredata
                do {
                    try self.stack.context.save()
                    print ("grabado")
                }    catch {
                    print ("error al grabar")
                }
                
            }
            //}
            //es la primera y unica vez que se supone que pasara por aqui. Lo marcomo como que ya ha pasado
            print("comentado el FIRST_TIME")
            def.setBool(true, forKey: FIRST_TIME)
            //ademas pongo por defecto un valor al utlimo libro leido para que aparezca algo. Pongo el primer libro que se sacara del array de libros, asi que el 0
            //def.setInteger(0, forKey: LAST_BOOK)

        } else {
            print("Tengo los datos en BD")
        }
        
        
    }
    
    
    //func downloadJSON() -> [StructBook]? {
    func downloadJSON() -> [Book]? {
        //me bajo el json de forma sincrona
        
        //necesito un array de los libros estructurados, que podria dar error si no hay nada
        var resultStructBooks : [StructBook]? = nil
        var resultBooksArray: [Book]? = nil
        
        let url = NSURL(string: JSON_URL)!
        //me bajo los datos, se los enchufo al JSONSerializartion y si todo va bien devuelvo un JSONArray
        do {
            if let data = NSData(contentsOfURL: url),
                libros = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? JSONArray {
                    
                    //tengo un JSONArray de libros sin tratar, me devuelve un array de StructBook
                    resultStructBooks = decodeJSONArrayToStructBookArray(books: libros)
                    
                    //ahora transformo el array de Struct en array de NCTBook
                    resultBooksArray = decodeStructBooksToBooksArray(books: resultStructBooks!)
                    
            }
        } catch {
            print("Error al descargar el json")
        }
        //return resultStructBooks
        return resultBooksArray
    }


}

