//
//  MasterViewController.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 30/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

/*
uisearch http://www.raywenderlich.com/113772/uisearchcontroller-tutorial
*/

import UIKit

class MasterViewController: AGTCoreDataTableViewController, UISearchControllerDelegate   {

    var detailViewController: DetailViewController? = nil
    var objects = [AnyObject]()
    
    //me genero un stack para acceder a la BD
    var stack : AGTSimpleCoreDataStack!
    
    //cargo el userdefults y asi no lo vuelvo a cargar 
    let def = NSUserDefaults.standardUserDefaults()
    



    override func viewDidLoad() {
        super.viewDidLoad()
        
        //defino el controlador de busqueda
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchBar.sizeToFit()
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.definesPresentationContext = true
        self.searchController.searchResultsUpdater = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        //añado el scope para seleccionar donde se busca
        searchController.searchBar.scopeButtonTitles = ["Titulo", "Tag", "Autor"]
        //el delegado
        searchController.searchBar.delegate = self
        //se lo coloco a la tabla
        self.tableView.tableHeaderView = searchController.searchBar
        
        
        //inicializo el array del filtro de la busqueda
        self.filteredArray = NSMutableArray()
        
        
        //segun sea el orden por tag o alfabeticamente, hago una busqueda diferente
        
        let fet = NSFetchRequest(entityName: BookTagModel.entityName())
        let s1 = (NSSortDescriptor(key: "tag.proxyForSorting", ascending: true))
        let s2 = (NSSortDescriptor(key: "book.title", ascending: true))
        fet.sortDescriptors = [s1,s2]
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fet, managedObjectContext: stack.context, sectionNameKeyPath: "tag.tag", cacheName: nil)
        
        
        //registro las celda personalizada
        let celdaNib = UINib(nibName: BookCell.cellId(), bundle: nil)
        self.tableView.registerNib(celdaNib, forCellReuseIdentifier: BookCell.cellId())
        self.tableView.rowHeight = BookCell.cellHeight()
        //desplazo la tabla un poco hacia arriba para que no aparezca el search
        self.tableView.setContentOffset(CGPointMake(0, self.searchController.searchBar.frame.size.height), animated: false)
        
        
        //cambio de color el separador de celdas
        self.tableView.separatorColor = UIColor.defaultColorHacker()
        
        
        //compruebo si es la primera vez
        if !def.boolForKey(FIRST_TIME) {

            /*
            Hago el proceso de bajar con bloques. No se si es asi como se pide, de momento me ha servido para entender el funcionamiento. Para poner un activityView habria que ponerlo en el willappear y se estaria comprobando algo constantemente para un proceso que solo se hace 1 vez y tarda muy poco, compensa?
            */
            checkDownloadedJSON({ (bookArray) -> Void in
                //se supone que se ha bajado todo y lo ha procesado, nos ha devuelto un array con los libros para grabarlos en core data, o puede haber llegado vacio si hubo error

                if let arr = bookArray {
                    //tengo datos, los grabo
                    for l in arr {
                        //esto guarda en coredata todo lo referente al libro, en la estructura que tenga que ser
                        l.saveToCoreData(context: self.stack.context)
                        
                    }
                    
                    //lo suyo es grabar todo coredata
                    do {
                        try self.stack.context.save()
                    }    catch {
                        print ("error al grabar")
                    }
                }
                
                //y ahora que me he bajado esto, pues lomarco en el userdefaults
                self.def.setBool(true, forKey: FIRST_TIME)


            })
            
            
            
        }
        
    }
    


    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        /* ejemplo del puto bloque
        procesando { (resultado) -> Void in
            print("tengo un array de string")
            print(resultado)
        }
        
        hardProcessingWithString("Hola") { (result) -> Void in
            print("ha terminado \(result)")
        }
    */
    }
    
    
    
    
    /*
    ejemplo probando los putos bloques
    func procesando(heFinalizado:(resultado: [String]) -> Void) {
        
        print("Hago lo que sea, no me han mandado ningun parametro")
        //tengo que devolver un array de string
        let a = ["hola","adios","como","estas"]
        
        //he terminado, le devuelvo la pelota a quinme ha llamado con el resultado
        heFinalizado(resultado: a)
    }
    

    func hardProcessingWithString(input: String, completion: (result: Int) -> Void) {
        var a = 3
        print(a)
        let b = 5
        a = a*b*a
        print(a)
        print(input)
        
        completion(result: a)
    }
*/
    
 
 
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        //compruebo si el controlador de search esta activo, so lo esta he de quitarlo
        if searchController.active {
            //he de quitar el search
            searchController.active = false
        }
        
        //sea lo que sea, grabo, si ha bajadoo imagenes de la celda, pues se graban, si no, pues ya se ocupara de no grabar nada
        _ = try? self.stack.context.save()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Table View
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        

        let cell = tableView.dequeueReusableCellWithIdentifier(BookCell.cellId() , forIndexPath: indexPath) as! BookCell
        
        //let scope = searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex]
        
        //estoy buscando el booktag, asi que saco la informacion a traves del BookTag
        var booktag : BookTagModel  //para los tags
        var object : BookModel

        //obtengo el libro que hay que mostrar, segun sea de coredata o de la busqueda
        if  self.searchController.active && self.searchController.searchBar.text != nil {
            //es busqueda, asi que el filter es un array de BookModel
            object = self.filteredArray[indexPath.row] as! BookModel

        } else {
            //en el fetch tengo un array de BookTagModel, tengo que obtener el libro en uestion
            booktag = self.fetchedResultsController.objectAtIndexPath(indexPath) as! BookTagModel
            //ahora tengo el booktag, de aqui sale el libro
            object = booktag.book!
        }
        
       
        //pongo los valores
        cell.title.text = object.title
        cell.tags.text = object.tagsString()
        //cell.coverImage = object.cover?.image
        
        //compruebo si tiene imagen o no
        if let img = object.cover?.image {
            //tengo imagen
            cell.cover.image = img
        } else {
            //hay que bajarse la imagen
            /*
                No es la mejor forma pero funciona, he visto por internet que el metodo es similar. no tengo mucho tiempo para hacer pruebas y usar AsyncDownload
            */
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), { () -> Void in
                
                if let url = NSURL(string:object.imageUrl!) {
                    //me bajo lo que haya, y si lo hay lo proceso
                    if let data = NSData(contentsOfURL: url) {
                        //print("Bajando \(url)")
                        if let image = UIImage(data: data) {
                            //tengo la imagen, la grabo en coredata
                            
                            dispatch_async(dispatch_get_main_queue()) {
                                //tengo la imagen, la grabo en coredata
                                object.cover?.image = image
                                let stack = AGTSimpleCoreDataStack(modelName: DATA_BASE)
                                do{
                                    try stack.context.save()
                                } catch {
                                    print("Error al grabar cell")
                                }
                                //Ya tengo la imagen bajada, la cambio por la que tiene que ser
                                let fr = cell.cover.frame
                                let cent = cell.cover.center
                                //quito el placeholder
                                UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseOut, animations: { () -> Void in
                                    cell.cover.frame = CGRectZero
                                    cell.cover.center = cent
                                    }, completion: { (finished) -> Void in
                                        UIView.animateWithDuration(0.3, animations: { () -> Void in
                                            cell.cover.frame = fr
                                            cell.cover.image = image
                                        })
                                })
                                
                                
                                
                                
                            }
                        }
                    }
                }
                
            })
            
            
            
            
            
            
            
        }

        return cell
    }

//    func Imageuploaded(notification: NSNotification) -> Void {
//        print(notification)
//        //saco el info
//        let info = notification.userInfo
//        
//    }
/*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
*/
/*
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
*/


    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //quito la seleccion que se queda en gris en el ipad
        
        performSegueWithIdentifier("ShowBook", sender: indexPath)
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if let v = view as?UITableViewHeaderFooterView {
            v.backgroundView?.backgroundColor = UIColor.defaultColorHacker()
        }
        
        
    }

    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowBook" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object : BookModel
                if searchController.active && searchController.searchBar.text != "" {
                    object = filteredArray[indexPath.row] as! BookModel

                } else {
                    let booktag = self.fetchedResultsController.objectAtIndexPath(indexPath) as! BookTagModel
                    object = booktag.book!
                }
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.book = object
                controller.stack = self.stack
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    //MARK: - Filtro searchcontroller
    func filterContextForSearchText(searchText: String, scope: String){
        //hago el filtro que tenga que ser. El resultado he de ponerlo en el array filteredResults
        //segun tenga pulsado la opcion del scope

        //borro lo que habia para guardar lo nuevo que se encuentre
        self.filteredArray.removeAllObjects()
        
        //dependiendo del scope hago una busqueda diferente
        switch (scope ){
            
            case "Titulo":
                if let a = BookModel.booksWithTitleLike(title: searchText, context: self.stack.context) {
                    self.filteredArray.addObjectsFromArray(a)
                }

                break
            case "Tag":
                if let t = TagModel.booksWithTagLike(tag: searchText, context: self.stack.context) {
                    self.filteredArray.addObjectsFromArray(t)
                }
                break
            case "Autor":
                if let e = AuthorModel.booksWithAuthorLike(author: searchText, context: self.stack.context) {
                    self.filteredArray.addObjectsFromArray(e)
                }
                break
            default:
                break
        }
        //recargo los datos con lo que se esta buscando
            
        tableView.reloadData()
     
    }
    
    //MARK: - Download data
    
    func checkDownloadedJSON (librosEncontrados:(bookArray: [Book]?) -> Void) {
        //un bloque que llama a una funciona q se baja el JOSN y lo procesa, una vez que lo tenga procesado se lo devuelve para que se grabe en primer plano
        
        librosEncontrados(bookArray: self.downloadJSON())
        
    }
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

        return resultBooksArray
    }

}

extension MasterViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        //obtengo el scope que han pulsado
        let scope = searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex]
        filterContextForSearchText(searchController.searchBar.text!, scope: scope)

    }
}

extension MasterViewController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContextForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

