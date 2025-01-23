//
//  HistoryTableViewCell.swift
//  Jackpot Slots
//
//  Created by Unique Consulting Firm on 11/01/2025.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var datelb:UILabel!
    @IBOutlet weak var usernameLb:UILabel!
    @IBOutlet weak var coinslb:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
