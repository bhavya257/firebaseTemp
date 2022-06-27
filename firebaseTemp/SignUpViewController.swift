//
//  SignUpViewController.swift
//  firebaseTemp
//
//  Created by Bhavya Jain on 26/06/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func alreadyHaveAccTapped(_ sender: Any) {
        self.dismiss(animated: true)
        //let storyboard = UIStoryboard(name:"Main",bundle:nil)
        //let vc = storyboard.instantiateViewController(withIdentifier: "home")
        //vc.modalPresentationStyle = .overFullScreen
        //present(vc, animated: true)
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        if emailInput.text?.isEmpty == true{
            print("No Text in Email Field")
            return
        }
        if passwordInput.text?.isEmpty == true{
            print("No Text in Password Field")
            return
        }
        signUp()
    }
    
    func signUp() {
        Auth.auth().createUser(withEmail: emailInput.text!, password: passwordInput.text!){authResult,
            error in
            guard let user=authResult?.user, error==nil else{
                print("Error \(error?.localizedDescription)")
                return
            }
            
            let storyboard=UIStoryboard(name: "Main", bundle: nil)
            let vc=storyboard.instantiateViewController(withIdentifier: "home")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
            return
        }
    }
}
