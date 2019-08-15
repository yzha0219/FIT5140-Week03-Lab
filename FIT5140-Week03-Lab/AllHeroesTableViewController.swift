//
//  AllHeroesTableViewController.swift
//  FIT5140-Week03-Lab
//
//  Created by Yi Zhang on 15/8/19.
//  Copyright © 2019 Yi Zhang. All rights reserved.
//

import UIKit

class AllHeroesTableViewController: UITableViewController, UISearchResultsUpdating, AddSuperHeroDelegate {
    
    let SECTION_HEROS = 0
    let SECTION_COUNT = 1
    let CELL_HERO = "heroCell"
    let CELL_COUNT = "totalHerosCell"
    
    var allHeros: [SuperHero] = []
    var filteredHeros: [SuperHero] = []
    weak var superHeroDelegate: AddSuperHeroDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDefaultCharacters()
        
        filteredHeros = allHeros
        
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == SECTION_HEROS {
            return filteredHeros.count
        } else {
            return 1
        }
    }

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text?.lowercased(), searchText.count > 0 {
            filteredHeros = allHeros.filter({(hero: SuperHero) -> Bool in return hero.name.lowercased().contains(searchText)})
        }
        else {
            filteredHeros = allHeros
        }
        
        tableView.reloadData()
    }
    
    func addSuperHero(newHero: SuperHero) -> Bool {
        <#code#>
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == SECTION_HEROS {
            let heroCell = tableView.dequeueReusableCell(withIdentifier: CELL_HERO, for: indexPath) as! SuperHeroTableViewCell
            let hero = filteredHeros[indexPath.row]
            
            heroCell.nameLabel.text = hero.name
            heroCell.abilitiesLabel.text = hero.abilities
            
            return heroCell
        }
        
        let countCell = tableView.dequeueReusableCell(withIdentifier: CELL_COUNT, for: indexPath)
        countCell.textLabel?.text = "\(allHeros.count) Heros in database"
        countCell.selectionStyle = .none
        return countCell
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == SECTION_HEROS {
            tableView.deselectRow(at: indexPath, animated: false)
            return
        }
        
        if superHeroDelegate!.addSuperHero(newHero: filteredHeros[indexPath.row]) {
            navigationController?.popViewController(animated: true)
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

