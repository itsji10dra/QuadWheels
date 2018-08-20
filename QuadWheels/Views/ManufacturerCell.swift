//
//  ManufacturerCell.swift
//  QuadWheels
//
//  Created by Jitendra on 04/08/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit

class ManufacturerCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet weak var titleLabel: UILabel?
    
    // MARK: - View

    override func awakeFromNib() {
        super.awakeFromNib()
        
        accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
