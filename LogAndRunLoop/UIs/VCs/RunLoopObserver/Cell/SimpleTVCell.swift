//
//  SimpleTVCell.swift
//  LogAndRunLoop
//
//  Created by 倪僑德 on 2020/12/27.
//

import UIKit

final class SimpleTVCell: UITableViewCell {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var iconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        iconImageView.image = nil
    }
    
    func configureCell(title: String, coverImage: UIImage? = nil) {
        titleLabel.text = title
        iconImageView.image = coverImage
    }
}
