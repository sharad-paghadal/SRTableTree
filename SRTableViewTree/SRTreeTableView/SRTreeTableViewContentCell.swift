//
//  SRTreeTableViewContentCell.swift
//  SRTreeTableView
//
//  Created by Sharad Paghadal on 2017/09/01.
//  Copyright © 2017 Sharad Paghadal. All rights reserved.
//

import UIKit

class SRTreeTableViewContentCell: UITableViewCell {

    var node:SRTreeTableViewNode?{
        didSet{
            indentationLevel = node?.depth ?? 0
            indentationWidth = 30
            textLabel?.text = node?.nodeName
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
