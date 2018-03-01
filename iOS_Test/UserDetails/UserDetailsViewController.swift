//
//  UserDetailsViewController.swift
//  iOS_Test
//
//  Created by Zumzet Mobile on 01/03/2018.
//  Copyright © 2018 Bogdan Prisacara. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {

    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var emailButton: UIButton!
    @IBOutlet var userPicture: UIImageView!
    @IBOutlet var ageLabel: UILabel!
    
    var selectedUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //add controller content
        userPicture.downloadedFrom(link: selectedUser.userPicture.large, contentMode: .scaleAspectFit, forceCache: true)
        
        userNameLabel.text = selectedUser.name.title + ". " + selectedUser.name.firstName + " " + selectedUser.name.lastName
        
        ageLabel.text = "Age: " + String(selectedUser.age)
        
        emailButton.setTitle(selectedUser.email, for: UIControlState())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openMailComposer(_ sender: UIButton){
        
        if let url = URL(string: "mailto:\(selectedUser.email)") {
            UIApplication.shared.open(url)
        }
    }
}
