//
//  User.swift
//  iOS_Test
//
//  Created by Zumzet Mobile on 01/03/2018.
//  Copyright © 2018 Bogdan Prisacara. All rights reserved.
//

import UIKit

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

class User {
    var gender: String!
    var name: Name!
    
    init(rawDictionary: Dictionary<String, AnyObject>){
        
        if let nnGender = rawDictionary["gender"]{
            self.gender = nnGender as! String
        }
        
        if let nnName = rawDictionary["name"]{
            self.name = Name.init(rawDictionary: nnName as! Dictionary<String, String>)
        }
    }
}
