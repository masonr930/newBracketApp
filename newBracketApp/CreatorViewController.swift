//
//  CreatorViewController.swift
//  newBracketApp
//
//  Created by MASON ROZUMNY on 2/9/23.
//

import UIKit

class CreatorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

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
            
            
        }
    }
    
   
    @IBAction func createButton(_ sender: UIButton) {
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
}
