//
//  ViewController.swift
//  newBracketApp
//
//  Created by MASON ROZUMNY on 2/8/23.
//
// MASON THIS IS THE GOOD ONE NOT THE OTHER ONE DONT DELETE THIS CAUSE THIS ONE IS THE ONE!!!!!!!!
//
//
// THIS ONE ********************
//
//
//

class AppData {
   static var loaded = false
}

import UIKit


import FirebaseCore
import FirebaseDatabase
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    
    
    
    var ref: DatabaseReference!
    var brackates: [BracketObject] = []
    var rowPick: Int = 0
    
    @IBOutlet weak var tableviewOutlet: UITableView!
    @IBOutlet weak var textFieldOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        tableviewOutlet.dataSource = self
        tableviewOutlet.delegate = self
          
                   // snapshot is a dictionary with a key and a dictionary as a value
                    // this gets the dictionary from each snapshot
        
        ref.observe(.childAdded, with: { (snapshot) in
            if !AppData.loaded{
                
                print("reading firebase")
                let dict = snapshot.value as! [String:Any]
                print("Timer2")
                // building a Student object from the dictionary
                let s = BracketObject(dict: dict, reference: snapshot.key)
                print("timer3")
                // adding the student object to the Student array
                self.brackates.append(s)
                print("timer4")
            }
            // should only add the student if the student isn’t already in the array
            // good place to update the tableview also
                print("Trying to reload data")
                self.tableviewOutlet.reloadData()
                    })
        
        
        
        ref.observe(.childChanged) { snapshot  in
            print("changing")
           var replaced = false
            let dict = snapshot.value as! [String:Any]
            let s = BracketObject(dict: dict, reference: snapshot.key)
            s.fireKey = snapshot.key
            print(s.made)
            for i in 0 ..< self.brackates.count {
                print("count is \(self.brackates.count)")
//                print("FireKey is")
//                print(self.brackates[i].fireKey)
//                print("Normal Key")
//                print(s.fireKey)
                if s.fireKey == self.brackates[i].fireKey{
                    print(i)
                    replaced = true
                    print("replace")
                    s.made = true
                    self.brackates[i] = s
                    print(self.brackates[i].made)
                    if self.brackates[i].made{
                        s.made = true
                    }
                    else{
                        s.made = true
                        print(s.made)
                        print("made")
                        self.brackates.append(s)
                        print(self.brackates[self.brackates.count-1].made)
                        self.brackates[i].made = true
                    }
                }
                else{
                    print("Not Replace")
                }
            }
            if !replaced{
                s.made = true
                print("made")
                self.brackates.append(s)
            }
        }

        
                
        tableviewOutlet.reloadData()
        
        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        tableviewOutlet.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brackates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableviewOutlet.dequeueReusableCell(withIdentifier: "bracketCell")
        cell!.textLabel!.text = brackates[indexPath.row].title
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowPick = indexPath.row
        performSegue(withIdentifier: "tableClick", sender: nil)
      }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        AppData.loaded = true
        if segue.identifier == "tableClick"{
            let nvc = segue.destination as! BracketViewController
            nvc.bigBracket = brackates[rowPick]
        }
        else if segue.identifier == "bracketSegue"{
            let nvc = segue.destination as! NewBracketViewController
        }
    }

    @IBAction func unwind(seg: UIStoryboardSegue)
    {
        tableviewOutlet.reloadData()
    }
    
    @IBAction func enterKeyButton(_ sender: UIButton)
    {
        
        
       // performSegue(withIdentifier: "bracketSegue", sender: nil)
    }
    

}

