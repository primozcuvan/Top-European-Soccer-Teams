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
    func configCell(club: ClubData) -> Bool {
        let imageData = logoImage.getLogoImage(imageString: club.image)
        
        if  imageData == Data() {
            return false // If imageData is an empty Data return false and display an alert
        }
        
        logo.image = UIImage(data: imageData) // Set club's logo image
        name.text = club.name // Set club's name label
        country.text = club.country // Set club's country label
        value.text = "\(club.value) Millionen" // Set club's value label
        return true
    }
    
}
