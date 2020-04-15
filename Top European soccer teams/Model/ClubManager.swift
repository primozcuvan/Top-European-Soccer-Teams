//
//  ClubManager.swift
//  Top European soccer teams
//
//  Created by Primoz Cuvan on 15/04/2020.
//  Copyright © 2020 Primoz Cuvan. All rights reserved.
//

import Foundation

//MARK: ClubManagerDelegate
protocol ClubManagerDelegate {
    func didLoadData(clubs: [ClubData])
}

class ClubManager {
    
    var delegate: ClubManagerDelegate?
    
    //MARK: performRequest
    func performRequest(stringURL: String) {
        
        // Create URL
        if let url = URL(string: stringURL) {
            let session = URLSession(configuration: .default) // Create session
            let task = session.dataTask(with: url) { (data, response, error) in
                
                // If there is an error, display it and do nothing
                if error != nil {
                    print("Error: \(error!)")
                    return // Do nothnig
                }
                
                // Process data
                if let safeData = data {
                    if let club = self.parseJSON(club: safeData) {
                        self.delegate?.didLoadData(clubs: club)
                    }
                }
            }
            task.resume()
        }
    }
    
    //MARK: parseJSON
    func parseJSON(club: Data) -> [ClubData]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([ClubData].self, from: club) // Decode data that are decoded in the  [ClubData].self way
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }
    
}
