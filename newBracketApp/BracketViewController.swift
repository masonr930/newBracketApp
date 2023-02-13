//
//  BracketViewController.swift
//  newBracketApp
//
//  Created by MASON ROZUMNY on 2/9/23.
//

import UIKit

class BracketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var matchesTable: UITableView!
    var labels = ["Third", "Fourth", "Fifth", "Sixth", "Seventh", "Eighth", "Nineth", "Tenth", "Eleventh", "Twelfth", "Thirteenth", "Fourteenth", "Fifteenth"]
    
    
    
    @IBOutlet weak var tableviewOutlet: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        matchesTable.dataSource = self
        matchesTable.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.matches.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! VsCell
        cell.configure(match: AppData.matches[indexPath.row])
        print("CELL MADE")
            return cell
    }
    

}
