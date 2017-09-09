//
//  AddNewTaskViewController.swift
//  TO-DO list app
//
//  Created by NSMohamedElalfy on 9/8/17.
//  Copyright © 2017 NSMohamedElalfy. All rights reserved.
//

import UIKit
import CoreData

class AddNewTaskViewController: UIViewController , UITextViewDelegate {

  @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var doneButton: UIButton!
  @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      textView?.delegate = self
      
      NotificationCenter.default.addObserver(self,
                                             selector: #selector(keyboardWillShow(_:)),
                                             name: NSNotification.Name.UIKeyboardWillShow,
                                             object: nil)
      NotificationCenter.default.addObserver(self,
                                             selector: #selector(keyboardWillHide(_:)),
                                             name: NSNotification.Name.UIKeyboardWillHide,
                                             object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  func keyboardWillShow(_ notification: Notification) {
   // adjustInsetForKeyboardShow(true, notification: notification)
    let userInfo = notification.userInfo ?? [:]
    let keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
    let adjustmentHeight = keyboardFrame.height
    UIView.animate(withDuration: (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue) {
      self.bottomConstraint.constant = adjustmentHeight
      self.view.layoutIfNeeded()
      
    }
  }
  
  func keyboardWillHide(_ notification: Notification) {
    //adjustInsetForKeyboardShow(false, notification: notification)
    let userInfo = notification.userInfo ?? [:]
    UIView.animate(withDuration: (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue) {
      self.bottomConstraint.constant = 0
      self.view.layoutIfNeeded()
      
    }
  }
    
  @IBAction func onCancel(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }

  @IBAction func onDone(_ sender: UIButton) {
    
    if (textView?.text.isEmpty)! || textView?.text == "Type anything Here ..."{
      print("No Data")
      
      let alert = UIAlertController(title: "Please Type Something", message: "Your entry was left blank.", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Okay", style: .default) { action in
        
      })
      
      self.present(alert, animated: true, completion: nil)
      
    } else {
      
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        dismiss(animated: true, completion: nil)
        return
      }
      
      let context = appDelegate.persistentContainer.viewContext
      let newTask = Task(context: context)
      newTask.name = textView?.text!
      newTask.done = false
      
      appDelegate.saveContext()
      
      self.isEditing = false
      dismiss(animated: true, completion: nil)
      
    }
    
  }
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    //textView.text = ""
    textView.textColor = UIColor.darkGray
  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if (text == "\n") {
      textView.resignFirstResponder()
      return false
    }
    return true
  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

