//
//  NoteCollectionCell.swift
//  HackerBookPro
//
//  Created by Vicente de Miguel on 25/1/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

import UIKit

class NoteCollectionCell: UICollectionViewCell {

    @IBOutlet weak var title: UITextView!

    @IBOutlet weak var modification: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor.defaultColorHacker()
        self.title.backgroundColor = UIColor.defaultColorHacker()
        self.modification.backgroundColor = UIColor.defaultColorHacker()
        //self.title.tintColor = UIColor.whiteColor()
        //self.modification.tintColor = UIColor.whiteColor()
        

    }


    //esto seria un metodo de clase
    class func cellId() -> String{
        //debe retornar el mimso nombre que tenga el identificador de la celda prototype en el storyboard
        return "NoteCollectionCell"
    }
    
    //devuelve el tamaño de la celda
    class func cellSize() -> CGSize {
        return CGSizeMake(150, 100)
    }

}
