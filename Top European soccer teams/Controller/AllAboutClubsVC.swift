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
    
    let ClubDetailsVCIdentifier = "GoToDetails" // Identifier to perform a segue
    
    let clubManager = ClubManager()
    var allClubs : [ClubData] = []
    
    var toogleSorting : Bool = false // toogle the sorting method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the title of the navigation screen
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
        
        // Perform request and get the the info about the clubs
        clubManager.delegate = self
        clubManager.performRequest(stringURL: infoURL)
        
    }
    
    func displayAlert() {
        let alert = UIAlertController(title: "Something went wrong", message: "Could not load the data. Check your internet connetion.", preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Continue", style: .default) { (UIAlertAction) in }
        alert.addAction(restartAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: SortierenButtonPressed
    @IBAction func SortierenButtonPressed(_ sender: Any) {
        if toogleSorting == false {
            allClubs = allClubs.sorted(by: { $0.value > $1.value }) // Sort by
            clubsTableView.reloadData() // Reload tableView
            toogleSorting = true
        } else {
            // Default
            allClubs = allClubs.sorted(by: { $0.name < $1.name }) // Sort by ABC...
            clubsTableView.reloadData() // Reload tableView
            toogleSorting = false
        }
        
    }
    
}

//MARK: TableView
extension AllAboutClubsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allClubs.count // Number of all clubs in array
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell") as! AllAboutClubsCellTableViewCell // Custom cell
        let loadedImage = cell.configCell(club: allClubs[indexPath.row]) // Asign the cell its properties
        
        if loadedImage == false && indexPath.row == 0 { // Display alert only once
            displayAlert()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        // Simple animation
        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row), animations: {cell.alpha = 1})
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0 // Set row height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let club = allClubs[indexPath.row]
        performSegue(withIdentifier: ClubDetailsVCIdentifier, sender: club)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ClubDetailsVCIdentifier {
            let detailsVC = segue.destination as! ClubDetailsVC
            detailsVC.club = sender as? ClubData
        }
    }
}

//MARK: ClubManagerDelegate
extension AllAboutClubsVC: ClubManagerDelegate {
    
    func didLoadData(clubs: [ClubData]) {
        allClubs = clubs
        allClubs = allClubs.sorted(by: { $0.name < $1.name }) // Sort by ABC... -> Default Sorting
        print(allClubs)
        DispatchQueue.main.async {
            self.clubsTableView.reloadData() // Reload tableView to show gathered data
        }
    }
    
    func connect(connectionIsEstablished: Bool) {
        if connectionIsEstablished == false {
            print("Creating alert")
            DispatchQueue.main.async {
                self.displayAlert()
            }
        }
    }
    
}


