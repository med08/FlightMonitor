//
//  ViewController.swift
//  FlighttMonitor
//
//  Created by Alexandra Lazea on 01/04/2017.
//  Copyright © 2017 Medeea. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var logoutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let user = FIRAuth.auth()?.currentUser {
            self.logoutButton.alpha = 1.0
            self.usernameLabel.text = user.email
        }
        else {
            self.logoutButton.alpha = 0.0
            self.usernameLabel.text = ""
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccount(_ sender: UIButton) {
        
        performSegue(withIdentifier: "loginToCreateAccount", sender: self)
        
        /*if self.emailField.text == "" || self.passwordField.text == "" {
            self.showAlert(title: "Error", message: "Alege user si parola")
        }
        else {
            FIRAuth.auth()?.createUser(withEmail: self.emailField.text!, password: self.passwordField.text!, completion: { (user, error) in
                if error == nil {
                    self.logoutButton.alpha = 1.0
                    self.usernameLabel.text = user!.email
                    self.clearFields()
                }
                else{
                    self.showAlert(title: "Error", message: (error?.localizedDescription)!)
                }
            })
        }
*/
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        if self.emailField.text == "" || self.passwordField.text == "" {
            self.showAlert(title: "Error", message: "Alege user si parola")
        }
        else {
            FIRAuth.auth()?.signIn(withEmail: self.emailField.text!, password: self.passwordField.text!, completion: { (user, error) in
                if error == nil {
                    self.logoutButton.alpha = 1.0
                    self.usernameLabel.text = user!.email
                    self.clearFields()
                }
                else{
                    self.showAlert(title: "Error", message: (error?.localizedDescription)!)
                }
            })
        }
    }
    
    @IBAction func logoutAction(_ sender: UIButton) {
        try! FIRAuth.auth()?.signOut()
        self.clearFields()
        self.logoutButton.alpha = 0.0
        self.usernameLabel.text = ""
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

    }

}

