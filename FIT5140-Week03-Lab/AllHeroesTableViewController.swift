//
//  AllHeroesTableViewController.swift
//  FIT5140-Week03-Lab
//
//  Created by Yi Zhang on 15/8/19.
//  Copyright © 2019 Yi Zhang. All rights reserved.
//

import UIKit

class AllHeroesTableViewController: UITableViewController, UISearchResultsUpdating, AddSuperHeroDelegate {
    
    let SECTION_HEROES = 0
    let SECTION_COUNT = 1
    let CELL_HERO = "heroCell"
    let CELL_COUNT = "totalHeroesCell"
    
    var allHeroes: [SuperHero] = []
    var filteredHeroes: [SuperHero] = []
    weak var superHeroDelegate: AddSuperHeroDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDefaultCharacters()
        
        filteredHeroes = allHeroes
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Heroes"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func updateSearchResults(for searchController: UISearchController){
        if let searchText = searchController.searchBar.text?.lowercased(), searchText.count > 0{
            filteredHeroes = allHeroes.filter({ (hero: SuperHero) -> Bool in
                return hero.name.lowercased().contains(searchText)
            })
        }
        else{
            filteredHeroes = allHeroes
        }
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == SECTION_HEROES {
            return filteredHeroes.count
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == SECTION_HEROES {
            let heroCell = tableView.dequeueReusableCell(withIdentifier: CELL_HERO, for: indexPath) as! SuperHeroTableViewCell
            let hero = filteredHeroes[indexPath.row]
            
            heroCell.nameLabel.text = hero.name
            heroCell.abilitiesLabel.text = hero.abilities
            
            return heroCell
        }
        
        let countCell = tableView.dequeueReusableCell(withIdentifier: CELL_COUNT, for: indexPath)
        countCell.textLabel?.text = "\(allHeroes.count) heroes in database"
        countCell.selectionStyle = .none
        return countCell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == SECTION_COUNT {
            tableView.deselectRow(at: indexPath, animated: false)
            return
        }
        if superHeroDelegate!.addSuperHero(newHero: filteredHeroes[indexPath.row]){
            navigationController?.popViewController(animated: true)
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        displayMessage(title: "Party Full", message: "Cannot add any more members to party")
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "createHeroSegue"{
            let destination = segue.destination as! CreateSuperHeroViewController
            destination.superHeroDelegate = self
        }
    }
    
    func addSuperHero(newHero: SuperHero) -> Bool {
        allHeroes.append(newHero)
        filteredHeroes.append(newHero)
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row:filteredHeroes.count - 1, section: 0)], with: .automatic)
        tableView.endUpdates()
        tableView.reloadSections([SECTION_COUNT], with: .automatic)
        return true
    }
    
    func createDefaultCharacters(){
        allHeroes.append(SuperHero(name: "Bruce Wayne", abilities: "Is Rich"))
        allHeroes.append(SuperHero(name: "Superman", abilities: "Super Powered Alien"))
        allHeroes.append(SuperHero(name: "Wonder Woman", abilities: "Goddess"))
        allHeroes.append(SuperHero(name: "The Flash", abilities: "Faster than speed of light"))
        allHeroes.append(SuperHero(name: "Green Lantern", abilities: "Has a magic ring"))
        allHeroes.append(SuperHero(name: "Cyborg", abilities: "Is a cyborg"))
        allHeroes.append(SuperHero(name: "Aquaman", abilities: "Can breathe underwater"))
    }
    
    func displayMessage(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController,animated: true,completion: nil)
    }
}

