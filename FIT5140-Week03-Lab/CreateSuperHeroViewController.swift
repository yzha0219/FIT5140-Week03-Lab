//
//  CreateSuperHeroViewController.swift
//  FIT5140-Week03-Lab
//
//  Created by Yi Zhang on 15/8/19.
//  Copyright © 2019 Yi Zhang. All rights reserved.
//

import UIKit

class CreateSuperHeroViewController: UIViewController {
    
    weak var superHeroDelegate: AddSuperHeroDelegate?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var abilitiesTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createHero(_ sender: Any) {
        if nameTextField.text != "" && abilitiesTextField.text != ""{
            let name = nameTextField.text!
            let abilities = abilitiesTextField.text!
            let hero = SuperHero(name: name, abilities: abilities)
            let _ = superHeroDelegate!.addSuperHero(newHero: hero)
            navigationController?.popViewController(animated: true)
            return
        }
        
        var errorMsg = "Please ensure all fields are filled:\n"
        
        if nameTextField.text == ""{
            errorMsg += " - Must provide a name\n"
        }
        if abilitiesTextField.text == ""{
            errorMsg += " - Must provide abilities"
        }
        
        
    }
    
    
    func displayMessage(title: String,message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController,animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
