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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //esto seria un metodo de clase
    class func cellId() -> String{
        return NSStringFromClass(BookCell)
    }
    
    class func cellHeight() -> CGFloat {
        return 50.0
    }
    
}
