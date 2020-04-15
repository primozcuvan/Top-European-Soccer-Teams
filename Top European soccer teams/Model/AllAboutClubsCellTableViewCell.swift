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
    
    func configCell(club: Club) {
        let urlImage = club.logo
        
        if let url = URL(string: urlImage) {
            do {
                let data = try Data(contentsOf: url)
                self.logo.image = UIImage(data: data)
            } catch let error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}
