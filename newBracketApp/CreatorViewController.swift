//
//  CreatorViewController.swift
//  newBracketApp
//
//  Created by MASON ROZUMNY on 2/9/23.
//

import UIKit

class CreatorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // added a comment
    
    

    @IBOutlet weak var textfieldOutlet: UITextField!
     var teams: [String] = []
     var numberOfTeams = 0
    var matches: [MatchupClass] = []
    var teamCheck = false
    var rounds = 0

    
    @IBOutlet weak var tableViewOutlet: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
print("I'm having fun!")
        // Do any additional setup after loading the view.
        
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
        tableViewOutlet.dragInteractionEnabled = true
        tableViewOutlet.isEditing = true
        tableViewOutlet.allowsSelectionDuringEditing = true
    }
    
    @IBAction func addTeamButton(_ sender: UIButton) {
        if let x = textfieldOutlet.text {
            teams.append(x)
            tableViewOutlet.reloadData()
            textfieldOutlet.text = ""
            
        }
    }
    

   
    @IBAction func createButton(_ sender: UIButton)
    {
        performSegue(withIdentifier: "createBracket", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        makeBracket(teams: teams)
        if segue.identifier == "createBracket"
        {
            let nvc = segue.destination as! BracketViewController
            nvc.teams = teams
            nvc.matches = matches
            nvc.rounds = rounds
            nvc.teamCheck = teamCheck
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: "teamCell")!
        cell.textLabel?.text = teams[indexPath.row]
        cell.detailTextLabel?.text = "Seed: \(indexPath.row + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete
        {
            teams.remove(at: indexPath.row)
            tableViewOutlet.deleteRows(at: [indexPath], with: .fade)
            tableViewOutlet.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        teams.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        tableViewOutlet.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    //Making this do the whole bracket (Trying). The number is the amount of people who move on to round 2 without having to play anyone. Should be correct.
    func makeBracket(teams: [String]){
        //checks if a bracket is a power of 2 or even
        var tempTeams = teams
        var check = false
        var bies = 0
        var perfect = false
        var count = teams.count
        var firstRoundMatches: Int
        rounds = 0
        if (count%2 == 0){
            while (count%2 == 0 ){
                count = count/2
            }
            if (count == 1){
                perfect = true
                count = teams.count
                Swift.print("Perfect")
            }
            else{
                perfect = false
                count = teams.count
            }
        }
        if(!perfect){
            while(!check){
                count+=1
                bies+=1
                if (count%2 == 0){
                    var temp = count
                    while (temp%2 == 0 ){
                        temp = temp/2
                    }
                    if (temp == 1){
                       check = true
                    }
                }
            }
        }
       
        firstRoundMatches = firstRoundMatchesCalc(perfect: perfect, teams: teams, bies: bies)
        var newCount = firstRoundMatches
        newCount = (firstRoundMatches + bies)/2
        rounds = 2
        while(newCount != 1){
            newCount = newCount/2
            rounds += 1
        }
//        addSegueButtons(rounds2: rounds)
        //this if else covers first round matches and places them into the table, we need to find a way to show a seperate table for seperate matches
        if(perfect){
            var teamsTemp = teams
            for _ in 0..<firstRoundMatches {
                matches.append(MatchupClass.init(hTeam:tempTeams[0], aTeam: tempTeams[1], hScore: 0, aScore: 0, match: true))
                print(teamsTemp)
                tempTeams.remove(at: 0)
                tempTeams.remove(at:0)
                print(matches[0].homeTeam)
            }
//            //make table just print one array[0] and array [1] into each seperate spot and then delete them from the temporary array this is only minimum and first round only populate table with first round matches cells only
        }
        else{
            var teamsTemp = teams
            for _ in 0..<firstRoundMatches {
                matches.append(MatchupClass.init(hTeam:tempTeams[0], aTeam: tempTeams[1], hScore: 0, aScore: 0, match: true))
                print(teamsTemp)
                tempTeams.remove(at: 0)
                tempTeams.remove(at:0)
                print(matches[0].homeTeam)
            }
            for _ in 0..<bies
            {
                matches.append(MatchupClass.init(hTeam: tempTeams[0], aTeam: "BYE", hScore: 0, aScore: 0, match: false))
                tempTeams.remove(at: 0)
                print("HI")
            }
            
//           // populate table with only the amount of cells as first round matches and only run the loop to put people in that many times
        }
        print("test")
    }
    
    //calclulates first roundMatches
    func firstRoundMatchesCalc(perfect: Bool, teams: [String], bies: Int)-> Int{
        var firstRoundMatches = 0
        if(perfect){
            firstRoundMatches = teams.count/2
        }
        else{
            firstRoundMatches = (teams.count+bies)/2 - bies
        }
        return firstRoundMatches
    }
    
    func randomSeeds(teams: [String])
    {
        self.teams.shuffle()
        tableViewOutlet.reloadData()
    }
    
    @IBAction func shuffleButton(_ sender: UIButton) {
        randomSeeds(teams: teams)
    }
    
    
}
