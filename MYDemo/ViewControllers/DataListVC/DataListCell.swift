//
//  DataListCell.swift
//  MYDemo
//
//  Created by mac on 20/05/19.
//  Copyright © 2019 mhn. All rights reserved.
//

import UIKit

class DataListCell: UITableViewCell {

    @IBOutlet var btnSelect: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
