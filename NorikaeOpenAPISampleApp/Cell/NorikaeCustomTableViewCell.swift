//
//  NorikaeCustomTableViewCell.swift
//  NorikaeOpenAPISampleApp
//
//  Created by MasamiYamate on 2018/07/06.
//  Copyright © 2018年 MasamiYamate. All rights reserved.
//

import UIKit

class NorikaeCustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var LineColorBaseView: UIView!
    
    @IBOutlet weak var currentFirstLineColorView: UIView!
    @IBOutlet weak var currentSecondLineColorView: UIView!
    
    @IBOutlet weak var nextFirstLineColorView: UIView!
    @IBOutlet weak var nextSecondLineColorView: UIView!
    
    @IBOutlet weak var PointCircle: UIView!
    
    @IBOutlet weak var DataLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        PointCircle.layer.cornerRadius = PointCircle.frame.size.width
        PointCircle.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
