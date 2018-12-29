//
//  RadioTableViewCell.swift
//  scorpio
//
//  Created by 山浦功 on 2018/12/29.
//  Copyright © 2018 com.yamaura. All rights reserved.
//

import UIKit

class RadioTableViewCell: UITableViewCell {

    @IBOutlet private weak var radioImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.spWhite
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func updateCell(isChecked: Bool, title: String? = nil) {
        if isChecked {
            self.titleLabel.textColor = UIColor.spDarkBlue
        } else {
            self.titleLabel.textColor = UIColor.spBlue
        }
        if let title = title, !title.isEmpty {
            self.titleLabel.text = title
        }
    }
}
