//
//  HomeViewController.swift
//  iOS_Test
//
//  Created by Zumzet Mobile on 01/03/2018.
//  Copyright © 2018 Bogdan Prisacara. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var usersList = Array<User>()
    var pageNr = 1
    var isReloadAllowed = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getUserData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func getUserData(){
        showLoadingInView(view: self.view)
        
        var array = Array<User>()
        
        RestApiManager.sharedInstance.getUsers(pageNr: pageNr){(result) in
            
            if let nnResult = result{
                array = nnResult
                
                self.usersList = self.usersList + array
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.pageNr += 1
                    self.hideLoadingInView(view: self.view)
                    self.isReloadAllowed = true
                }
            }
        }

    }
    
    //MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let  cell = Bundle.main.loadNibNamed("UserDetailsCell", owner: self, options: nil)![0] as! UserDetailsCell
        
        let user = usersList[indexPath.row]
        
        //add cell content
        cell.userPicture.downloadedFrom(link: user.userPicture.thumbnail, contentMode: .scaleAspectFit, forceCache: true)
        cell.userNameLabel.text = user.name.title + ". " + user.name.firstName + " " + user.name.lastName
        cell.nationalityLabel.text = "Nat: " + user.nationality
        cell.ageLabel.text = "Age: " + String(user.age)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nextController = UserDetailsViewController()
        nextController.selectedUser = usersList[indexPath.row]
        self.navigationController?.pushViewController(nextController, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if(self.tableView.contentOffset.y > CGFloat(pageNr - 1) * tableView.rowHeight * 5.0){
            if(isReloadAllowed){
                isReloadAllowed = false
                getUserData()
            }
            
        }
    }
    
    //functions for display/hide loading indicator
    func showLoadingInView(view:UIView) {
        let LOADING_TAG = 1000230
        let existingLoadingView = view.viewWithTag(LOADING_TAG)
        
        if let nnLoadingView = existingLoadingView {
            view.bringSubview(toFront: nnLoadingView)
            return
        }
        
        let loadingView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        loadingView.tag = LOADING_TAG
        loadingView.layer.cornerRadius = 10
        loadingView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.startAnimating()
        loadingView.addSubview(activityIndicator)
        
        loadingView.center = CGPoint(x: view.bounds.size.width/2, y: view.bounds.size.height/2)
        
        view.addSubview(loadingView)
        
    }
    
    func hideLoadingInView(view :UIView) {
        let LOADING_TAG = 1000230
        let existingLoadingView = view.viewWithTag(LOADING_TAG)
        
        if let nnLoadingView = existingLoadingView {
            nnLoadingView.removeFromSuperview()
        }
    }
}
