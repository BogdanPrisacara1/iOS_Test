//
//  HomeViewController.swift
//  iOS_Test
//
//  Created by Zumzet Mobile on 01/03/2018.
//  Copyright © 2018 Bogdan Prisacara. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var usersList = Array<User>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        RestApiManager.sharedInstance.getUsers(){(result) in
            
            if let nnResult = result{
                self.usersList = nnResult
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
