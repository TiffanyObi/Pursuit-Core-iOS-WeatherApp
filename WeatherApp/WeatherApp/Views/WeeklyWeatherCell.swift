//
//  WeeklyWeatherCell.swift
//  WeatherApp
//
//  Created by Tiffany Obi on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class WeeklyWeatherCell: UICollectionViewCell {
    
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var temperatureHighLabel: UILabel!
    
    @IBOutlet weak var temperatureLowLabel: UILabel!
    
    @IBOutlet weak var humiditylabel: UILabel!
    
    
    


    private var cityNameString = "N/A" {
        didSet {
            locationLabel.text = cityNameString
        }
    }
    
   
    
    public func configureCell(for dayOfTheWeek: Details) {
        
        
        
        
        self.layer.borderWidth = 10
        
        self.layer.borderColor = CGColor(srgbRed: 0.5, green: 0.1, blue: 0.3, alpha: 1.0)
        
        changeBackGround()

        locationLabel.textColor = .black
        locationLabel.font = UIFont(name: "Didot", size: 20)
        descriptionLabel.textColor = .black
        descriptionLabel.text = "EXPECT:  \(dayOfTheWeek.icon.uppercased(with: .current)) "
        descriptionLabel.font = UIFont(name: "Didot", size: 25.0)
        weatherImageView.image = UIImage(named: dayOfTheWeek.icon)
        
        temperatureHighLabel.text = "High: \(dayOfTheWeek.temperatureHigh)"
        temperatureLowLabel.textColor = .white
        temperatureLowLabel.text = "Low: \(dayOfTheWeek.temperatureLow)"
        temperatureHighLabel.textColor = .white
        humiditylabel.textColor = .white
        humiditylabel.text = "Humidity: \(dayOfTheWeek.humidity)"
    }
    
    func changeBackGround() {
        let  randRed = CGFloat.random(in: 0.4...0.8)
        let  randBlue = CGFloat.random(in: 0.4...0.8)
        let  randGreen = CGFloat.random(in: 0.4...0.8)
        print("red -\(randRed), blue - \(randBlue), green -\(randGreen)")
         
         let myColor = UIColor(red: randRed, green: randGreen, blue: randBlue, alpha: 1)
     self.backgroundColor = myColor
     }

}


    
    
   
        
    
   
    
    

