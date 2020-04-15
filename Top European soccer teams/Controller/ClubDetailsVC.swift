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
    
    var image : String?
    var country : String?
    var name : String?
    var value : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Name: \(name ?? "")")
        
        logoImage.image = UIImage(data: logo.getLogoImage(imageString: image ?? ""))
        countryLabel.text = country
        
        let details = NSMutableAttributedString(string: "Der Club " , attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
        details.append(NSAttributedString(string: name ?? "", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)]))
        details.append(NSAttributedString(string: " aus \(country ?? "") hat einen Wert von \(value ?? 0) Millionen Euro.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]))

        
        detailsLabel.attributedText = details
        
        
    }
    
}
