//
//  User.swift
//  iOS_Test
//
//  Created by Zumzet Mobile on 01/03/2018.
//  Copyright © 2018 Bogdan Prisacara. All rights reserved.
//

import UIKit
import Foundation

class User {
    var gender: String!
    var name: Name!
    var nationality: String!
    var userPicture: UserPicture!
    var email: String!
    var age: Int!
    
    init(rawDictionary: Dictionary<String, AnyObject>){
        
        if let nnGender = rawDictionary["gender"]{
            self.gender = nnGender as! String
        }
        
        if let nnName = rawDictionary["name"]{
            self.name = Name.init(rawDictionary: nnName as! Dictionary<String, String>)
        }
        
        if let nnNat = rawDictionary["nat"]{
            self.nationality = nnNat as! String
        }
        
        if let nnPicture = rawDictionary["picture"]{
            self.userPicture = UserPicture.init(rawDictionary: nnPicture as! Dictionary<String, String>)
        }
        
        if let nnEmail = rawDictionary["email"]{
            self.email = nnEmail as! String
        }
        if let dob = rawDictionary["dob"]{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let userDate = dateFormatter.date(from: dob as! String)
            let currentDate = Date()
            
            let calendar = NSCalendar.current
            self.age = calendar.dateComponents([.year], from: userDate!, to: currentDate).year

        }
        
    }
}

struct Name{
    var title: String!
    var firstName: String!
    var lastName: String!
    
    init(rawDictionary: Dictionary<String, String>){
        
        if let nnTitle = rawDictionary["title"]{
            self.title = nnTitle
        }
        if let nnFirst = rawDictionary["first"]{
            self.firstName = nnFirst
        }
        if let nnLast = rawDictionary["last"]{
            self.lastName = nnLast
        }
    }
}

struct UserPicture{
    var large: String!
    var medium: String!
    var thumbnail: String!
    
    init(rawDictionary: Dictionary<String, String>){
        
        if let nnLarge = rawDictionary["large"]{
            self.large = nnLarge
        }
        if let nnMedium = rawDictionary["medium"]{
            self.medium = nnMedium
        }
        if let nnThumbnail = rawDictionary["thumbnail"]{
            self.thumbnail = nnThumbnail
        }
    }
}

