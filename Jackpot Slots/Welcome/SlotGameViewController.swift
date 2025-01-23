//
//  SlotGameViewController.swift
//  Jackpot Slots
//
//  Created by Unique Consulting Firm on 05/01/2025.
//

import UIKit

class SlotGameViewController: UIViewController {

    // MARK: - UI Elements
    
        
        // MARK: - Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            
         let balance = UserDefaults.standard.integer(forKey: "CoinBalance")
            
            if balance <= 0
            {
                UserDefaults.standard.set(100, forKey: "CoinBalance")
                UserDefaults.standard.set(0, forKey: "BetAmount")
            }
            
        }
                
        // MARK: - Actions
        @IBAction private func didTapPlay() {
            // Navigate to the game screen
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "SlotReelsViewController") as! SlotReelsViewController
            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
        }
    
    @IBAction private func scorebtn() {
        // Navigate to the game screen
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ScoresViewController") as! ScoresViewController
        newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction private func historybtn() {
        // Navigate to the game screen
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
        newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction private func settingsbtn() {
        // Navigate to the game screen
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
    }
    
    
    }



