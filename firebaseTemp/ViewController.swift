//
//  ViewController.swift
//  firebaseTemp
//
//  Created by Bhavya Jain on 26/06/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn


class ViewController: UIViewController {
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func googleSignInTapped(_ sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in

          if let error = error {
              print("Error because \(error.localizedDescription)")
            return
          }

          guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)

          print("Successful Google Log In")
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error{
                    print(error.localizedDescription)
                }
                checkUserInfo()
            }
        }
        

    }
    
    @IBAction func createAccTapped(_ sender: Any) {
        let storyboard=UIStoryboard(name: "Main", bundle: nil)
        let vc=storyboard.instantiateViewController(withIdentifier: "signUp")
        vc.modalPresentationStyle = .overFullScreen
        present(vc,animated: true)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        validate()
    }
    
    func validate() {
        if emailInput.text?.isEmpty == true{
            print("No text in Email Field")
            return
        }
        if passwordInput.text?.isEmpty == true {
            print("No text in Password Field")
            return
        }
        login()
    }
    
    func login(){
        Auth.auth().signIn(withEmail: emailInput.text!, password: passwordInput.text!){ [weak self]
            authResult, error in
            guard let strongSelf = self else {return}
            if let error = error{
                print(error.localizedDescription)
            }
            self!.checkUserInfo()
        }
    }
    
    func checkUserInfo(){
        if Auth.auth().currentUser != nil {
            print(Auth.auth().currentUser?.uid)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "logIn")
            vc.modalPresentationStyle = .overFullScreen
            present(vc,animated: true)
        }
    }
}
