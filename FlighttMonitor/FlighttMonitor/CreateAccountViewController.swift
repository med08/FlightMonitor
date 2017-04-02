//
//  CreateAccountViewController.swift
//  FlighttMonitor
//
//  Created by Alexandra Lazea on 02/04/2017.
//  Copyright © 2017 Medeea. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var checkPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearFields()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccount(_ sender: UIButton) {
        if self.emailField.text == "" || self.passwordField.text == "" || self.usernameField.text == "" || self.checkPasswordField.text == "" {
            self.showAlert(title: "Error", message: "All fields must be completed!")
        }
        else {
            if self.passwordField.text != self.checkPasswordField.text{
                self.showAlert(title: "Error", message: "Passwords don't match.")
            }
            else {
                FIRAuth.auth()?.createUser(withEmail: self.emailField.text!, password: self.passwordField.text!, completion: { (user, error) in
                    if error == nil {
                        FIRDatabase.database().reference().child("Users").child(FIRAuth.auth()!.currentUser!.uid).setValue(["username": self.usernameField.text])
                    }
                    else{
                        self.showAlert(title: "Error", message: (error?.localizedDescription)!)
                    }
                })
            }
        }
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func clearFields(){
        self.passwordField.text = ""
        self.emailField.text = ""
        self.checkPasswordField.text = ""
        self.usernameField.text = ""
        
    }

}
