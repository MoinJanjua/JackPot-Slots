//
//  FeedbackViewController.swift
//  HopeLine Track
//
//  Created by Unique Consulting Firm on 04/01/2025.
//

import UIKit

class FeedbackViewController: UIViewController {

    @IBOutlet weak var feedbackTextView: UITextView!
    @IBOutlet weak var descLb: UILabel!
    @IBOutlet weak var contView: UIView!
    @IBOutlet weak var donebtn: UIButton!
        
    @IBOutlet weak var Mainview: UIView!
    var starButtons: [UIButton] = []
        var selectedRating: Int = 0
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tapGesture)
            setupFeedbackTextView()
            setupStarButtons()
           // applyCornerRadiusToBottomCorners(view: Mainview, cornerRadius: 35)
            
            

        }
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
            feedbackTextView.resignFirstResponder()
        }
        
        func setupFeedbackTextView() {
            feedbackTextView.layer.cornerRadius = 8
               feedbackTextView.layer.shadowColor = UIColor.white.cgColor
               feedbackTextView.layer.shadowOffset = CGSize(width: 0, height: 2)
               feedbackTextView.layer.shadowOpacity = 0.3
               feedbackTextView.layer.shadowRadius = 4.0
               //feedbackTextView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
               feedbackTextView.textColor = .darkGray
               feedbackTextView.font = UIFont.systemFont(ofSize: 16, weight: .medium)
               //feedbackTextView.text = "Write your feedback here..."
               feedbackTextView.textAlignment = .left
        }
        
        func setupStarButtons() {
            let buttonWidth: CGFloat = 50
            let spacing: CGFloat = 10
            
            
            for i in 0..<5 {
                let starButton = UIButton(type: .custom)
                starButton.frame = CGRect(x: 20 + CGFloat(i) * (buttonWidth + spacing) - 10, y: descLb.frame.maxY + 20 , width: 80, height: 100)
                starButton.setImage(UIImage(systemName: "star"), for: .normal)
                starButton.setImage(UIImage(systemName: "star.fill"), for: .selected)
                starButton.tag = i + 1 // Set tag starting from 1
                starButton.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
                starButton.tintColor = .systemYellow
                starButtons.append(starButton)
                contView.addSubview(starButton)
            }
        }
        
        @IBAction func backbtnPressed(_ sender:UIButton)
        {
            self.dismiss(animated: true)
        }
        
        @IBAction func savebtnPressed(_ sender:UIButton)
        {
            submitButtonTapped()
        }
        
        @objc func starButtonTapped(_ sender: UIButton) {
            selectedRating = sender.tag
            
            for button in starButtons {
                button.isSelected = button.tag <= selectedRating
            }
        }
        
         func submitButtonTapped() {
            guard selectedRating > 0, !feedbackTextView.text.isEmpty else {
                
                let alert = UIAlertController(title: "Invalid!", message: "Please provide both feedback and a rating.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            
            let confirmationAlert = UIAlertController(title: "Done!", message: "Thank you for your feedback!", preferredStyle: .alert)
            
            // Add an action with a completion handler to dismiss the UI
            let okAction = UIAlertAction(title: "OK", style: .default) { [self] _ in
                feedbackTextView.text = ""
                selectedRating = 0
                starButtons.removeAll()
                DispatchQueue.main.async {
                    self.dismiss(animated: true)
                }
            }
            confirmationAlert.addAction(okAction)
            
            present(confirmationAlert, animated: true, completion: nil)
        }
    }
