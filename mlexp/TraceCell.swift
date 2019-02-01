//
//  TraceCellTableViewCell.swift
//  mlexp
//
//  Created by zxj on 2019/2/1.
//  Copyright © 2019 Yamin Wei. All rights reserved.
//

import UIKit

class TraceCell: UITableViewCell {
    @IBOutlet weak var traceImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        self.nameLabel.textColor = UIColor.mBrownColor
        self.nameLabel.font = UIFont.titleFont
    }

    func setup(data: TraceData) {
        self.nameLabel.text = data.name
        self.typeLabel.text = data.type
        self.desLabel.text = data.desc
    }
}
