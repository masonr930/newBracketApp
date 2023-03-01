//
//  ViewController.swift
//  newBracketApp
//
//  Created by MASON ROZUMNY on 2/8/23.
//



import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    
    
    
    
    var brackates: [BracketObject] = []

    @IBOutlet weak var tableviewOutlet: UITableView!
    @IBOutlet weak var epicCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        tableviewOutlet.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }



}

