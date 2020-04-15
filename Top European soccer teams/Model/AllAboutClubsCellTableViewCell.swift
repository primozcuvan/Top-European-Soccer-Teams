//
//  AllAboutClubsCellTableViewCell.swift
//  Top European soccer teams
//
//  Created by Primoz Cuvan on 15/04/2020.
//  Copyright © 2020 Primoz Cuvan. All rights reserved.
//

import UIKit

class AllAboutClubsCellTableViewCell: UITableViewCell {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var value: UILabel!
    
    let logoImage = LogoImage()
    
    // Configure Cell's info
    func configCell(club: ClubData) {
        logo.image = UIImage(data: logoImage.getLogoImage(imageString: club.image)) //
        name.text = club.name // Set club's name label
        country.text = club.country // Set club's country label
        value.text = "\(club.value) Millionen" // Set club's value label
    }
    
}
