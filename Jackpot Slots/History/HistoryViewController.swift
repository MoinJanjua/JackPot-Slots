//
//  HistoryViewController.swift
//  Jackpot Slots
//
//  Created by Unique Consulting Firm on 11/01/2025.
//

import UIKit

class HistoryViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nodatalb: UILabel!
    
    // MARK: - Data
    private var scores: [(name: String, score: Int, date: String)] = []
   
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        nodatalb.isHidden = true
        loadScoresFromUserDefaults()
    }

    // MARK: - Load Scores
    private func loadScoresFromUserDefaults() {
        if let savedScores = UserDefaults.standard.array(forKey: "SlotGameScores") as? [[String: Any]] {
            scores = savedScores.compactMap {
                guard let name = $0["name"] as? String,
                      let score = $0["score"] as? Int,
                      let date = $0["date"] as? String else { return nil }
                return (name: name, score: score, date: date)
            }
        }
        
        if scores.isEmpty
        {
            nodatalb.isHidden = false
        }
    }
    
    
    private func saveScoresToUserDefaults() {
         let savedScores = scores.map { ["name": $0.name, "score": $0.score, "date": $0.date] }
         UserDefaults.standard.set(savedScores, forKey: "SlotGameScores")
     }

    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HistoryTableViewCell else {
            return UITableViewCell()
        }
        
        let score = scores[indexPath.row]
        cell.usernameLb.text = score.name
        cell.coinslb.text = "Coins :\(score.score)"
        cell.datelb.text = "\(score.date)"
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               // Remove the record from the array
               scores.remove(at: indexPath.row)
               
               // Save updated scores to UserDefaults
               saveScoresToUserDefaults()
               
               // Reload the table view
               tableView.deleteRows(at: [indexPath], with: .automatic)
               
               // Show "No Data" label if the scores array is empty
               nodatalb.isHidden = !scores.isEmpty
           }
       }
    
    @IBAction func backbuttonPressed(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SlotGameViewController") as! SlotGameViewController
        newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
    }
}
