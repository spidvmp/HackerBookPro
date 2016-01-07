//
//  DetailViewController.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 30/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var titleTField: UITextView!
    @IBOutlet weak var tagsTField: UITextView!
    @IBOutlet weak var authorsTField: UITextView!
    
    
    var book: BookModel? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
//        if let detail = self.detailItem {
//            if let label = self.detailDescriptionLabel {
//                label.text = detail.description
//            }
//        }
        if let book = self.book {
            //actualizo los datos del modelo a la vista
            if let field = self.titleTField {
                field.text = book.title
            }
            
            if let tag = self.tagsTField {
                tag.text = book.tagsString()
            }
            
            if let aut = self.authorsTField {
                aut.text = book.authorsString()
            }
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

