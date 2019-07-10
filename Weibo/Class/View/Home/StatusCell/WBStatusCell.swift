//
//  WBStatusCell.swift
//  Weibo
//
//  Created by liyishu on 2019/7/10.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class WBStatusCell: UITableViewCell {

    // MARK: - IBOutlet
    
    /** 头像 */
    @IBOutlet weak var iconView: UIImageView!
    /** 姓名 */
    @IBOutlet weak var nameLabel: UILabel!
    /** 会员图标 */
    @IBOutlet weak var memberIconView: UIImageView!
    /** 时间 */
    @IBOutlet weak var timeLabel: UILabel!
    /** 来源 */
    @IBOutlet weak var sourceLabel: UILabel!
    /** vip图片 */
    @IBOutlet weak var vipIconView: UIImageView!
    /** 微博内容 */
    @IBOutlet weak var statusLabel: UILabel!
    
    // MARK： - override method
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
