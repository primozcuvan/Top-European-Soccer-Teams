//
//  Club.swift
//  Top European soccer teams
//
//  Created by Primoz Cuvan on 15/04/2020.
//  Copyright © 2020 Primoz Cuvan. All rights reserved.
//

import Foundation

struct ClubData : Codable {

    let name : String
    let country : String
    let value : Int
    let image : String
    
}

class LogoImage {
    // getLogoImage gets the data from the logo url
    func getLogoImage(imageString: String) -> Data {
        if let url = URL(string: imageString) {
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch let error {
                print("Error: \(error.localizedDescription)")
            }
        }
        return Data()
    }
}
