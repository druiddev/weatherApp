//
//  TableViewCell.swift
//  MindfulWeatherApp
//
//  Created by Sarah on 12/13/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var zipLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
