//
//  NotePrototypeCell.swift
//  MyProductivityApp
//
//  Created by Yevhenii Shypitsyn on 3/18/22.
//

import UIKit

class NotePrototypeCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var note: UILabel!
    
    @IBOutlet weak var date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
