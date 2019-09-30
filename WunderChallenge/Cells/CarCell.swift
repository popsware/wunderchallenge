//
//  CarCell.swift
//  WunderChallenge
//
//  Created by Mohab Ayman on 9/30/19.
//  Copyright © 2019 Mohab Ayman. All rights reserved.
//

import UIKit

class CarCell: UITableViewCell {
    
    @IBOutlet weak var fuelBackView: UIView!
    @IBOutlet weak var fuelLabel: UILabel!
    @IBOutlet weak var interiorExteriorLabel: UILabel!
    @IBOutlet weak var engineLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        fuelBackView.layer.cornerRadius = 60
        fuelBackView.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func fillCar(car: Car) {
        nameLabel.text = car.name
        engineLabel.text = car.engineType
        interiorExteriorLabel.text = car.interior + " / " + car.exterior
        fuelLabel.text = "\(car.fuel)"
        
        switch car.fuel {
        case 0...40:fuelBackView.backgroundColor = Keys.Colors.red1
        case 40...80:fuelBackView.backgroundColor = Keys.Colors.orange1
        case 80...100:fuelBackView.backgroundColor = Keys.Colors.deepspace
        default:
            fuelBackView.backgroundColor = UIColor.gray
        }
        
        
        /*
        switch car.fuel {
        case 0...40:setGradientBackground(colorTop: Keys.Colors.red1, colorBottom: Keys.Colors.red2)
        case 40...80:setGradientBackground(colorTop: Keys.Colors.orange1, colorBottom: Keys.Colors.orange2)
        case 80...100:setGradientBackground(colorTop: Keys.Colors.deepspace, colorBottom: UIColor.black)
        default:
            fuelBackView.backgroundColor = UIColor.gray
        }
        */
    }
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = fuelBackView.bounds
        
        
        fuelBackView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
