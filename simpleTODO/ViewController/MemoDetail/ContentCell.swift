//
//  ContentCell.swift
//  simpleTODO
//
//  Created by 윤아영(Yun, AYoung) on 2020/01/23.
//  Copyright © 2020 ayoung. All rights reserved.
//

import UIKit

class ContentCell: UITableViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with content: String) {
        contentLabel.text = content
   }
}
