//
//  MasterViewController.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 30/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

import UIKit

class MasterViewController: AGTCoreDataTableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [AnyObject]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //me genero un stack para acceder a la BD
        let stack = AGTSimpleCoreDataStack(modelName: DATA_BASE)
        
        
        //let stack = AGTSimpleCoreDataStack(modelName: DATA_BASE)
        let fet = NSFetchRequest(entityName: BookModel.entityName())
        let s = (NSSortDescriptor(key: "title", ascending: true))
        fet.sortDescriptors = [s]
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fet, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        //registro las celda personalizada
        let celdaNib = UINib(nibName: BookCell.cellId(), bundle: nil)
        self.tableView.registerNib(celdaNib, forCellReuseIdentifier: BookCell.cellId())
        self.tableView.rowHeight = BookCell.cellHeight()
        
        
        //cambio de color el separador de celdas
        self.tableView.separatorColor = UIColor.defaultColorHacker()
        
        
        
//        // Do any additional setup after loading the view, typically from a nib.
//        self.navigationItem.leftBarButtonItem = self.editButtonItem()
//
//        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
//        self.navigationItem.rightBarButtonItem = addButton
//        if let split = self.splitViewController {
//            let controllers = split.viewControllers
//            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
//        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
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
        

        //obtengo el libro que hay que mostrar
        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! BookModel
        
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
        //    downloadImage(object)
            //observo el notification
        //    NSNotificationCenter.defaultCenter().addObserver(self, selector: "Imageuploaded:", name: IMAGE_DID_FINISH_DOWNLOAD, object: nil)
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), { () -> Void in
                
                if let url = NSURL(string:object.imageUrl!) {
                    //me bajo lo que haya, y si lo hay lo proceso
                    if let data = NSData(contentsOfURL: url) {
                        print("Bajando \(url)")
                        if let image = UIImage(data: data) {
                            //tengo la imagen, la grabo en coredata
                            object.cover?.image = image

                            dispatch_async(dispatch_get_main_queue()) {
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
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

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
                let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! BookModel
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.book = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

}

