//
//  ListOfNewsCell.swift
//  SampleNewsApplication
//
//  Created by Damotharan KG on 10/02/25.
//

import UIKit

class ListOfNewsCell: UITableViewCell {
    @IBOutlet weak var newsImageView: UIViewCustom!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var personImg: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var newsCategory: UILabel!
    @IBOutlet weak var newsName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        newsImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
