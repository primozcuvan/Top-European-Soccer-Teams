//
//  ViewController.swift
//  Top European soccer teams
//
//  Created by Primoz Cuvan on 15/04/2020.
//  Copyright © 2020 Primoz Cuvan. All rights reserved.
//

import UIKit

class AllAboutClubsVC: UIViewController {

    @IBOutlet weak var clubsTableView: UITableView!
    
    let infoURL = "https://public.allaboutapps.at/hiring/clubs.json"
    
    let clubManager = ClubManager()
    var allClubs : [ClubData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        clubsTableView.delegate = self
        clubsTableView.dataSource = self
        
        clubManager.delegate = self
        clubManager.performRequest(stringURL: infoURL)
        
    }



}

extension AllAboutClubsVC: ClubManagerDelegate {
    
    func didLoadData(clubs: [ClubData]) {
        allClubs = clubs
        DispatchQueue.main.async {
            self.clubsTableView.reloadData()
        }
    }
    
}

extension AllAboutClubsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allClubs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell") as! AllAboutClubsCellTableViewCell
        cell.configCell(club: allClubs[indexPath.row])
        
        return cell
    }
    
    
}
