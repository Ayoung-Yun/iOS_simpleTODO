//
//  DateCell.swift
//  simpleTODO
//
//  Created by 윤아영(Yun, AYoung) on 2020/01/23.
//  Copyright © 2020 ayoung. All rights reserved.
//

import UIKit

class DateCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(with date: Date) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        formatter.locale = Locale(identifier: "Ko_kr")
        dateLabel.text = formatter.string(from: date)
    }
}
