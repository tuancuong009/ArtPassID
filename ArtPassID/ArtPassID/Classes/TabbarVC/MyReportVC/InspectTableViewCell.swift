//
//  InspectTableViewCell.swift
//  ArtPassID
//
//  Created by QTS Coder on 14/5/25.
//  Copyright © 2025 QTS Coder. All rights reserved.
//

import UIKit

class InspectTableViewCell: UITableViewCell {
    @IBOutlet weak var imgAvatar: UIImageViewX!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    var tapRemove: (() ->())?
    var tapReport: (() ->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func doReport(_ sender: Any) {
        self.tapReport?()
    }
    
    @IBAction func doRemove(_ sender: Any) {
        self.tapRemove?()
    }
}
