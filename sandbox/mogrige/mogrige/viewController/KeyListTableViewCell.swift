//
//  KeyListTableViewCell.swift
//  mogrige
//
//  Created by Hyunseok Yang on 2020/10/06.
//

import UIKit

class KeyListTableViewCell: UITableViewCell {

    // tableView custum Item 연결
    @IBOutlet weak var keywordImage: UIImageView!
    //@IBOutlet weak var keywordTitle: UILabel!
    @IBOutlet weak var keywordTitle: UILabel!
    @IBOutlet weak var boardNumber: UILabel!
    @IBOutlet weak var keywordDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
