//
//  CurrentPartyTableViewController.swift
//  FIT5140-Week03-Lab
//
//  Created by Yi Zhang on 15/8/19.
//  Copyright © 2019 Yi Zhang. All rights reserved.
//

import UIKit

class CurrentPartyTableViewController: UITableViewController, AddSuperHeroDelegate {
    
    let SECTION_PARTY = 0
    let SECTION_COUNT = 1
    let CELL_HERO = "heroCell"
    let CELL_COUNT = "partySizeCell"
    
    var currentParty: [SuperHero] = []

    override func viewDidLoad() {
        super.viewDidLoad()

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
        if section == SECTION_PARTY {
            return currentParty.count
        } else {
            return 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == SECTION_PARTY {
            let partyCell = tableView.dequeueReusableCell(withIdentifier: CELL_HERO, for: indexPath) as! SuperHeroTableViewCell
            let hero = currentParty[indexPath.row]
            partyCell.nameLabel.text = hero.name
            partyCell.abilitiesLabel.text = hero.abilities
            return partyCell
        }
        
        let countCell = tableView.dequeueReusableCell(withIdentifier: CELL_COUNT, for: indexPath)
        countCell.textLabel?.text = "\(currentParty.count)/6 Heros in party"
        return countCell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if indexPath.section == SECTION_PARTY {
            return true
        }
        return false
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && indexPath.section == SECTION_PARTY {
            // Delete the row from the data source
            self.currentParty.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } //else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        //}
    }
    

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "allHerosSegue" {
            let destination = segue.destination as! AllHeroesTableViewController
            destination.superHeroDelegate = self
        }
    }
    
    func addSuperHero(newHero: SuperHero) -> Bool {
        if currentParty.count >= 6 {
            return false
        }
        
        currentParty.append(newHero)
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: currentParty.count - 1, section: SECTION_PARTY)], with: .automatic)
        tableView.endUpdates()
        tableView.reloadSections([SECTION_COUNT], with: .automatic)
        return false
    }

}
