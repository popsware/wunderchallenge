//
//  Keys.swift
//  WunderChallenge
//
//  Created by Mohab Ayman on 9/29/19.
//  Copyright © 2019 Mohab Ayman. All rights reserved.
//

import UIKit

class Keys {
    
    struct Messages {
        static let somethingwrong = "Something went wrong."
        static let trylater = "Please try again later."
        static let nocars = "No Cars were found."
    }
    
    struct Network{
        static let base = "https://s3-us-west-2.amazonaws.com"
        static let carList = "\(base)/wunderbucket/locations.json"
    }
    struct Colors{
        static let deepspace = UIColor(red: 67/255, green: 67/255, blue: 67/255, alpha: 1)
        static let orange1 = UIColor(red:  255/255, green: 183/255, blue: 94/255, alpha: 1)
        static let orange2 = UIColor(red: 237/255, green: 143/255, blue: 3/255, alpha: 1)
        static let red1 = UIColor(red: 229/255, green: 57/255, blue: 53/255, alpha: 1)
        static let red2 = UIColor(red: 227/255, green: 93/255, blue: 91/255, alpha: 1)
    }
}
