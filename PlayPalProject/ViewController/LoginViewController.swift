//
//  LoginViewController.swift
//  PlayPalProject
//
//  Created by Josesdio on 29/10/23.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        guard let email = usernameTxt.text, !email.isEmpty else {
                   print("Email is empty")
                   // Tampilkan pesan kesalahan ke pengguna (optional)
                   return
               }
               guard let password = passTxtField.text, !password.isEmpty else {
                   print("Password is empty")
                   // Tampilkan pesan kesalahan ke pengguna (optional)
                   return
               }
               
               Auth.auth().signIn(withEmail: email, password: password) { [weak self] firebaseResult, error in
                   if let e = error {
                       print("Error: \(e.localizedDescription)")
                       // Tampilkan pesan kesalahan ke pengguna (optional)
                       self?.showError(message: "Invalid email or password")
                   } else {
                       // Login berhasil, lanjutkan dengan verifikasi data pengguna
                       self?.saveAndSegue(email: email)
                   }
               }
           }
           
           func saveAndSegue(email: String) {
               // Save username to UserDefaults
               UserDefaults.standard.set(email, forKey: "username")
               
               // Verifikasi data pengguna di Firestore
               let db = Firestore.firestore()
               db.collection("users").whereField("email", isEqualTo: email).getDocuments { [weak self] (querySnapshot, error) in
                   if let error = error {
                       print("Error querying user data: \(error.localizedDescription)")
                       // Menampilkan pesan kesalahan ke pengguna (optional)
                       self?.showError(message: "Error querying user data")
                   } else {
                       if let document = querySnapshot?.documents.first {
                           // Data pengguna ditemukan, lanjutkan dengan aksi yang diperlukan (e.g., segue ke layar berikutnya)
                           self?.performSegue(withIdentifier: "goToNext", sender: self)
                       } else {
                           // Data pengguna tidak ditemukan
                           print("User data not found.")
                           // Menampilkan pesan kesalahan ke pengguna (optional)
                           self?.showError(message: "User data not found")
                       }
                   }
               }
           }
           
           func showError(message: String!) {
               let errorAlert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
               let ok = UIAlertAction(title: "OK", style: .default)
               errorAlert.addAction(ok)
               present(errorAlert, animated: true)
           }
       }
