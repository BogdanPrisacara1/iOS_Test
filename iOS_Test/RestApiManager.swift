//
//  RestApiManager.swift
//
//  Created by Zumzet Mobile on 8/30/16.
//  Copyright © 2016 Zumzet Mobile. All rights reserved.
//

import UIKit

class RestApiManager: NSObject {
    static let sharedInstance = RestApiManager()
    
    func makeHTTPGetRequest(_ path: String,
                            inputDictionary: Dictionary<String, AnyObject>?=nil,
                            onCompletion: @escaping (Array<AnyObject>?,String?, String?) -> Void) {
        
        //create the request
        let request:NSMutableURLRequest = NSMutableURLRequest(url: URL(string: path)!)
        
        //add input dictionary
        if let nnInputDictionary = inputDictionary
        {
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do{
                let data = try JSONSerialization.data(withJSONObject: nnInputDictionary , options:[])
                request.httpBody = data
            }
            catch {
            }
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) {(data, response, error) -> Void in
            print(path)
            if let nnData = data{
                do{
                    let json = try JSONSerialization.jsonObject(with: nnData, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    
                    if let nnResponse = json["results"] as? Array<AnyObject>{
                        
                        onCompletion(nnResponse, nil, nil)
                        return
                    }

                }
                catch {
                    let dataString = String(data: nnData, encoding: String.Encoding.utf8)
                    print("wrong data: ")
                    if let nnDataString = dataString{
                        print(nnDataString)
                    }
                }
            }
            else{
                //if no data, just error, send the error
                if let nnError = error{
                    onCompletion(nil, nil, nnError.localizedDescription)
                    return
                }
            }
        }
        task.resume()
    }
    
    
    func getUsers(pageNr:Int!, onCompletion: @escaping (Array<User>?) -> Void) {
        
        let baseURL = "https://randomuser.me/api?page=" + String(pageNr) + "&results=20"
        
        makeHTTPGetRequest(baseURL,
                           onCompletion: { (jsonArray, success, errorString) in
        
                            var usersArray = Array<User>()
                            if let nnJson = jsonArray{
                                for dict in nnJson{
                                    let user = User.init(rawDictionary: dict as! Dictionary<String,AnyObject>)
                                    
                                    usersArray.append(user)
                                }
                            }
                            onCompletion(usersArray)
        })
    }
    
}
