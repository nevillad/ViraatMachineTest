//
//  UserDataTableViewCell.swift
//  CoreDataTestNL
//
//  Created by Nevil Lad on 25/09/19.
//  Copyright © 2019 Nevil Lad. All rights reserved.
//

import UIKit

class UserDataTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userAddress: UILabel!
    
    private var viewModel: UserDataViewModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setViewModel(viewModel: UserDataViewModel) {
        self.viewModel = viewModel
        self.userName.text =  viewModel.getUserName()
        self.userAddress.text = viewModel.getUserAddress()
    }

}
