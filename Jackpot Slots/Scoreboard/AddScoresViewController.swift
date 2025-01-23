//
//  AddScoresViewController.swift
//  Jackpot Slots
//
//  Created by Unique Consulting Firm on 10/01/2025.
//

import UIKit

class AddScoresViewController: UIViewController {

    @IBOutlet weak var date:UITextField!
    @IBOutlet weak var usernameLb:UITextField!
    @IBOutlet weak var scorelb:UITextField!
    
    var score = String()
    var scores: [(name: String, score: Int, date: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    func setUpUI()
    {
        date.text = getCurrentDate()
        scorelb.text = score
    }
    

    private func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: Date())
    }
    
    @IBAction func SavebtnPressed(_ sender: UIButton) {
        guard let pName = usernameLb.text, !pName.isEmpty,
              let scoreText = scorelb.text, !scoreText.isEmpty,
              let scoreValue = Int(scoreText) // Safely convert to Int
        else {
            showAlert(title: "Error!", message: "Please ensure all fields are completed and the score is a valid number.")
            return
        }
        
        let date = getCurrentDate()
        
        // Retrieve existing scores from UserDefaults
        var savedScores = UserDefaults.standard.array(forKey: "SlotGameScores") as? [[String: Any]] ?? []
        
        // Append the new record
        let newRecord: [String: Any] = ["name": pName, "score": scoreValue, "date": date]
        savedScores.append(newRecord)
        
        // Save updated scores back to UserDefaults
        UserDefaults.standard.set(savedScores, forKey: "SlotGameScores")
        
        // Reset Coin Balance and Bet Amount
        UserDefaults.standard.set(100, forKey: "CoinBalance")
        UserDefaults.standard.set(0, forKey: "BetAmount")
        
        // Navigate to ScoresViewController
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ScoresViewController") as! ScoresViewController
        newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
    }


    @IBAction func backbuttonPressed(_ sender: UIButton) {
        UserDefaults.standard.set(100, forKey: "CoinBalance")
        UserDefaults.standard.set(0, forKey: "BetAmount")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SlotGameViewController") as! SlotGameViewController
        newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
    }

}
