//
//  ScoresTableViewCell.swift
//  Jackpot Slots
//
//  Created by Unique Consulting Firm on 10/01/2025.
//

import UIKit

class ScoresTableViewCell: UITableViewCell {

    @IBOutlet weak var rankLb:UILabel!
    @IBOutlet weak var usernameLb:UILabel!
    @IBOutlet weak var scorelb:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

struct Score {
    let username: String
    let score: Int
}
