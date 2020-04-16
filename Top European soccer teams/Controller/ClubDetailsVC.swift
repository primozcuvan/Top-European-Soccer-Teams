//
//  ClubDetailsVC.swift
//  Top European soccer teams
//
//  Created by Primoz Cuvan on 15/04/2020.
//  Copyright © 2020 Primoz Cuvan. All rights reserved.
//

import UIKit

class ClubDetailsVC: UIViewController {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    
    let logo = LogoImage()
    
    var club : ClubData! = nil // Init
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the title of the navigation screen
        let title = UILabel()
        title.text = club.name
        title.textColor = .white
        title.font = UIFont.boldSystemFont(ofSize: 22)
        title.sizeToFit()
        self.navigationItem.titleView = title
        
        logoImage.image = UIImage(data: logo.getLogoImage(imageString: club.image)) // Set logo image
        countryLabel.text = club.country // Set country label
        
        // Set details text
        let details = NSMutableAttributedString(string: "Der Club " , attributes:
            [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
        details.append(NSAttributedString(string: club.name, attributes:
            [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)]))
        details.append(NSAttributedString(string: " aus \(club.country) hat einen Wert von \(club.value) Millionen Euro.", attributes:
            [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]))
        
        detailsLabel.attributedText = details
    }
    
}
