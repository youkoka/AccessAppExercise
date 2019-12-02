//
//  TableViewCell.swift
//  Awesome
//
//  Created by colt on 2019/11/29.
//  Copyright © 2019 colt. All rights reserved.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {

    static let identifier = "TableViewCell"
    
    @IBOutlet var avatarImg:UIImageView?
    
    @IBOutlet var lbLogin:UILabel?
    
    @IBOutlet var lbType:UILabel?
    
    var avatarUrl:String = "" {
        
        didSet {
            
            avatarImg?.sd_setImage(with: URL(string: self.avatarUrl), completed: nil)
        }
    }
    
    var name:String = "" {
        
        didSet {
            
            lbLogin?.text = self.name
        }
    }

    var isAdmin:Bool = false {

        didSet {
            
            if self.isAdmin {
                
                lbType?.text = "Staff"
            }
            else {
                
                lbType?.text = ""
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        avatarImg?.layer.cornerRadius = 32
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
