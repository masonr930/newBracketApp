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
    var visible: [BracketObject] = []
    var numbers: [Int] = []
    var createdBracks: [BracketObject] = []
    var headers = ["Created Brackets", "Other Brackets"]
    
    
    
    @IBOutlet weak var tableviewOutlet: UITableView!
    @IBOutlet weak var textFieldOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(visible[0].title)
        ref = Database.database().reference()
        tableviewOutlet.dataSource = self
        tableviewOutlet.delegate = self
          
        if let items = UserDefaults.standard.data(forKey: "createdBrackets") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([BracketObject].self, from: items) {
                self.createdBracks = decoded
            }
        }
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(createdBracks) {
                UserDefaults.standard.set(encoded, forKey: "createdBrackets")
            print("Delete saved")
        }
                   // snapshot is a dictionary with a key and a dictionary as a value
                    // this gets the dictionary from each snapshot
        
        ref.observe(.childAdded, with: { (snapshot) in
            if !AppData.loaded{
                
                print("reading firebase")
                let dict = snapshot.value as! [String:Any]
                // building a Student object from the dictionary
                let s = BracketObject(dict: dict, reference: snapshot.key)
                // adding the student object to the Student array
                self.brackates.append(s)
            }
            // should only add the student if the student isn’t already in the array
            // good place to update the tableview also
                print("Trying to reload data")
                self.tableviewOutlet.reloadData()
            print(self.visible)
            if let items = UserDefaults.standard.data(forKey: "visibleBrackets") {
                            let decoder = JSONDecoder()
                            if let decoded = try? decoder.decode([Int].self, from: items) {
                                self.numbers = decoded
                            }
                print(self.numbers)
                print(self.brackates.count)
                if self.numbers.count>0{
                    var big: Int = self.numbers[0]
                    for t in self.numbers{
                        if t>big{
                            big = t
                        }
                    }
                    if self.brackates.count > big{
                        print("big number is \(big)")
                        for i in self.numbers {
                            var brack: BracketObject?
                            var niner: Bool = false
                            print("i is \(i)")
                            brack = self.brackates[i]
                            print("i is \(i)")
                            if let j = brack {
                                for l in self.visible{
                                    if l.bracketKey == j.bracketKey{
                                        niner = true
                                    }
                                }
                                if !niner{
                                    self.visible.append(j)
                                }
                            }
                        }
                    }
                   
                }
            }
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
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("This is the number of sections")
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            print("Happppppy")
            if visible.count != 0{
                print(visible.count)
                print(visible[0].rounds[0].matches[0].homeTeam)
            }
            return createdBracks.count
        }
        else{
            print("Size =\(visible.count)")
            return visible.count
        }
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableviewOutlet.dequeueReusableCell(withIdentifier: "bracketCell")
        if indexPath.section == 0{
            cell!.textLabel!.text = createdBracks[indexPath.row].title
        }
        else{
            print("sectionOne")
            cell!.textLabel!.text = visible[indexPath.row].title
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete
        {
            if indexPath.section == 0{
                createdBracks.remove(at: indexPath.row)
                tableviewOutlet.deleteRows(at: [indexPath], with: .fade)
                tableviewOutlet.reloadData()
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(createdBracks) {
                    UserDefaults.standard.set(encoded, forKey: "createdBrackets")
                }
            }
            if indexPath.section == 1{
                visible.remove(at: indexPath.row)
                numbers.remove(at: indexPath.row)
                tableviewOutlet.deleteRows(at: [indexPath], with: .fade)
                tableviewOutlet.reloadData()
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(numbers) {
                    UserDefaults.standard.set(encoded, forKey: "visibleBrackets")
                }
            }
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(numbers) {
                UserDefaults.standard.set(encoded, forKey: "visibleBrackets")
                print("Delete saved")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            rowPick = indexPath.row
            doSegue(brack: createdBracks[rowPick])
        }
        if indexPath.section == 1{
            rowPick = indexPath.row
            doSegue(brack: visible[rowPick])
        }
//        performSegue(withIdentifier: "tableClick", sender: nil)
      }
    
    func doSegue(brack: BracketObject){
        print("Count is")
        print(brack.rounds.count)
        if(brack.owner){
            performSegue(withIdentifier: "tableClick", sender: nil)
        }
        else if brack.rounds.count == 2 {
            performSegue(withIdentifier: "toBracket4", sender: self)
        }
        else if brack.rounds.count == 3 {
            performSegue(withIdentifier: "toBracket8", sender: self)
        }
        else if brack.rounds.count == 4 {
            performSegue(withIdentifier: "toBracket16", sender: self)
        }
        else if brack.rounds.count == 5 {
            performSegue(withIdentifier: "toBracket32", sender: self)
        }
        else if brack.rounds.count == 6 {
            performSegue(withIdentifier: "toBracket64", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        AppData.loaded = true
        if segue.identifier == "tableClick"{
            let nvc = segue.destination as! BracketViewController
            nvc.bigBracket = createdBracks[rowPick]
            nvc.visibleIndex = rowPick
        }
        else if segue.identifier == "create"{
            let nvc = segue.destination as! CreatorViewController
            nvc.brackates = brackates
            nvc.visIndex = visible.count
        }
        else if segue.identifier == "toBracket4"
        {
            let nvc = segue.destination as! Bracket4ViewController
            nvc.theBracket = visible[rowPick]
            nvc.unWind = true
        }
        else if segue.identifier == "toBracket8"
        {
            let nvc = segue.destination as! Bracket8ViewController
            nvc.theBracket = visible[rowPick]
            nvc.unWind = true
        }
        else if segue.identifier == "toBracket16"
        {
            let nvc = segue.destination as! Bracket16ViewController
            nvc.theBracket = visible[rowPick]
            nvc.unWind = true
        }
        else if segue.identifier == "toBracket32"
        {
            let nvc = segue.destination as! NewBracketViewController
            nvc.theBracket = visible[rowPick]
            nvc.unWind = true
        }
        else if segue.identifier == "toBracket64"
        {
            let nvc = segue.destination as! Bracket64ViewController
            nvc.theBracket = visible[rowPick]
            nvc.unWind = true
        }
    }

    @IBAction func unwind(seg: UIStoryboardSegue)
    {
        if let items = UserDefaults.standard.data(forKey: "visibleBrackets") {
                        let decoder = JSONDecoder()
                        if let decoded = try? decoder.decode([Int].self, from: items) {
                            numbers = decoded
                        }
            for i in 0..<brackates.count{
                if (numbers.contains(i)){
                    print(numbers)
                    var keyCheck = true
                    for j in visible {
                        if brackates[i].bracketKey == j.bracketKey{
                            keyCheck = false
                        }
                    }
                    if keyCheck{
                        visible.append(brackates[i])
                    }
                }
            }
        }

        tableviewOutlet.reloadData()
    }
    
    @IBAction func unwind10(_seg: UIStoryboardSegue)
    {
        print("AYOO")
        tableviewOutlet.reloadData()
    }
    
    
    @IBAction func enterKeyButton(_ sender: UIButton)
    {
        for i in 0..<brackates.count{
            if (brackates[i].bracketKey == textFieldOutlet.text){
                var boo = false
                for j in visible{
                    if j.bracketKey == textFieldOutlet.text{
                        boo = true
                        print("true")
                    }
                    print("i is \(i)")
                    print(visible)
                }
                if !boo{
                    print("i is \(i) and cool")
                    if !numbers.contains(i){
                        numbers.append(i)
                        visible.append(brackates[i])
                    }
                    else{
                        print("Already contains")
                    }
                }
                
            }
            let encoder = JSONEncoder()
               if let encoded = try? encoder.encode(numbers) {
                                UserDefaults.standard.set(encoded, forKey: "visibleBrackets")
                   print(numbers)
                            }
        }
        tableviewOutlet.reloadData()
    }
    

}

