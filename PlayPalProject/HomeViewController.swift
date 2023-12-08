    //
    //  HomeViewController.swift
    //  PlayPalProject
    //
    //  Created by Josesdio on 26/11/23.
    //

    import UIKit

    class HomeViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return listViewImage.count
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let viewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "viewCell", for: indexPath) as! ListCollectionViewCell
            viewCell.listViewImage.image = UIImage(named: listViewImage[indexPath.row])
            viewCell.listViewImage.layer.cornerRadius=50.0
            return viewCell
            
        }
        
        
        
        var listViewImage: [String] = ["car"]

        @IBOutlet weak var greetingLbl: UILabel!
        override func viewDidLoad() {
            super.viewDidLoad()
            
            if let username = UserDefaults.standard.string(forKey: "username") {
                        greetingLbl.text = "Hi, \(username)"
                    } else {
                        greetingLbl.text = "Hi, Guest"
                    }
            // Do any additional setup after loading the view.
        }
        

        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */

    }
