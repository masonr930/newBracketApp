//
//  CreatorViewController.swift
//  newBracketApp
//
//  Created by MASON ROZUMNY on 2/9/23.
//

import UIKit

class CreatorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var teams = [String]()

    @IBOutlet weak var textfieldOutlet: UITextField!
    @IBOutlet weak var tableViewOutlet: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
    }
    
    @IBAction func addTeamButton(_ sender: UIButton) {
        if let x = textfieldOutlet.text {
            teams.append(textfieldOutlet.text!)
            tableViewOutlet.reloadData()
            textfieldOutlet.text = ""
            
        }
    }
    
   
    @IBAction func createButton(_ sender: UIButton) {
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: "teamCell")!
        cell.textLabel?.text = teams[indexPath.row]
        return cell
    }
    
}
