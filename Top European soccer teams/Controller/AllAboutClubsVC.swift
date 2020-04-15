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
    
    var toogleSorting : Bool = false // Default - ABC...
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the title of the screen
        let title = UILabel()
        title.text = "All About Clubs"
        title.textColor = .white
        title.font = UIFont.boldSystemFont(ofSize: 22)
        title.sizeToFit()
        let leftItem = UIBarButtonItem(customView: title)
        self.navigationItem.leftBarButtonItem = leftItem
        
        // Set tableView properties
        clubsTableView.delegate = self
        clubsTableView.dataSource = self
        
        //
        clubManager.delegate = self
        clubManager.performRequest(stringURL: infoURL)
        
    }
    
    //MARK: SortierenButtonPressed
    @IBAction func SortierenButtonPressed(_ sender: Any) {
        if toogleSorting == false {
            allClubs = allClubs.sorted(by: { $0.value > $1.value }) // Sort by
            clubsTableView.reloadData() // Reload tableView
            toogleSorting = true
        } else {
            // Default
            allClubs = allClubs.sorted(by: { $0.name < $1.name }) // Sort by alphabetical order
            clubsTableView.reloadData() // Reload tableView
            toogleSorting = false
        }
        
    }
    

}

//MARK: TableView
extension AllAboutClubsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allClubs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell") as! AllAboutClubsCellTableViewCell
        cell.configCell(club: allClubs[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        // Simple animation
        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row), animations: {cell.alpha = 1})
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        performSegue(withIdentifier: "GoToDetails", sender: self)
    }
}

//MARK: ClubManagerDelegate
extension AllAboutClubsVC: ClubManagerDelegate {
    
    func didLoadData(clubs: [ClubData]) {
        allClubs = clubs
        allClubs = allClubs.sorted(by: { $0.name < $1.name }) // Sort by alphabetical order -> Default
        DispatchQueue.main.async {
            self.clubsTableView.reloadData()
        }
    }
    
}


