//
//  NoteCollectionCell.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 25/1/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

import UIKit

class NoteCollectionCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //esto seria un metodo de clase
    class func cellId() -> String{
        //debe retornar el mimso nombre que tenga el identificador de la celda prototype en el storyboard
        return "NoteCollectionCell"
    }
}
