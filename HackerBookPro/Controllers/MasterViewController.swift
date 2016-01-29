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

        searchController.searchBar.delegate = self
        
        self.tableView.tableHeaderView = searchController.searchBar
        
        //inicializo el array del filttro de la busqueda
        self.filteredArray = NSMutableArray()
        

        let fet = NSFetchRequest(entityName: BookModel.entityName())
        let s = (NSSortDescriptor(key: "title", ascending: true))
        fet.sortDescriptors = [s]
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fet, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        //registro las celda personalizada
        let celdaNib = UINib(nibName: BookCell.cellId(), bundle: nil)
        self.tableView.registerNib(celdaNib, forCellReuseIdentifier: BookCell.cellId())
        self.tableView.rowHeight = BookCell.cellHeight()
        //desplazo la tabla un poco hacia arriba para que no aparezca el search
        self.tableView.setContentOffset(CGPointMake(0, self.searchController.searchBar.frame.size.height), animated: false)
        
        
        //cambio de color el separador de celdas
        self.tableView.separatorColor = UIColor.defaultColorHacker()
        

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        //compruebo si el controlador de search esta activo, so lo esta he de quitarlo
        if searchController.active {
            //he de quitar el search
            searchController.active = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
/*
    func insertNewObject(sender: AnyObject) {
        objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
*/

    // MARK: - Table View
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        

        let cell = tableView.dequeueReusableCellWithIdentifier(BookCell.cellId() , forIndexPath: indexPath) as! BookCell
        
        let scope = searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex]
        
        var object : BookModel

        //obtengo el libro que hay que mostrar, segun sea de coredata o de la busqueda
        if  self.searchController.active && self.searchController.searchBar.text != nil {
            object = self.filteredArray[indexPath.row] as! BookModel
        } else {
            object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! BookModel
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
            //downloadImage(object.imageUrl, id: object.objectID)
            //observo el notification
        //    NSNotificationCenter.defaultCenter().addObserver(self, selector: "Imageuploaded:", name: IMAGE_DID_FINISH_DOWNLOAD, object: nil)
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), { () -> Void in
                
                if let url = NSURL(string:object.imageUrl!) {
                    //me bajo lo que haya, y si lo hay lo proceso
                    if let data = NSData(contentsOfURL: url) {
                        //print("Bajando \(url)")
                        if let image = UIImage(data: data) {
                            //tengo la imagen, la grabo en coredata
                            //object.cover?.image = image
                            
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

    func Imageuploaded(notification: NSNotification) -> Void {
        print(notification)
        //saco el info
        let info = notification.userInfo
        
    }
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
/*

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
*/
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("ShowBook", sender: indexPath)
    }

    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowBook" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object : BookModel
                if searchController.active && searchController.searchBar.text != "" {
                    object = filteredArray[indexPath.row] as! BookModel

                } else {
                    object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! BookModel
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

