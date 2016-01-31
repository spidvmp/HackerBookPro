//
//  BookCell.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 4/1/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

import UIKit


class BookCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var tags: UILabel!
    @IBOutlet weak var cover: UIImageView!
    
    var coverImage : UIImage? {
        didSet {
            self.cover.image = coverImage
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.cover.layer.masksToBounds = true
        self.cover.layer.cornerRadius = 8
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    //esto seria un metodo de clase
    class func cellId() -> String{
        //return NSStringFromClass(BookCell)
        //debe retornar el mimso nombre que tenga el identificador de la celda prototype en el storyboard
        return "BookCell"
    }
    
    class func cellHeight() -> CGFloat {
        return 50.0
    }
    
}
