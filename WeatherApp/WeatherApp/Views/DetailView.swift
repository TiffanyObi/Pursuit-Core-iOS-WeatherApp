//
//  DetailView.swift
//  WeatherApp
//
//  Created by Tiffany Obi on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class DetailView: UIView {
let defaultMessage = "No default color set. please go to settings"
   public lazy var messageLabel: UILabel = {
          let label = UILabel()
          label.backgroundColor = .systemIndigo
          label.textAlignment = .center
          label.font = UIFont(name: "Snell Roundhand", size: 20)
          label.text = defaultMessage
          label.textColor = .white
          return label
      }()
    
       override init(frame: CGRect) {
           super.init(frame:UIScreen.main.bounds)
           commonInit()
       }

       required init?(coder: NSCoder) {
           super.init(coder:coder)
           commonInit()
       }
       
       private func commonInit(){
        setupMessageLabelConstraints()
    }
    
        private func setupMessageLabelConstraints() {
            
            addSubview(messageLabel)
            
            //Step:2
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            
            
            
            //Step:3
            NSLayoutConstraint.activate([
            // set top anchor 20 pointe to the safe area
                
                messageLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
                
                
            // set padding at he leading aand trailing of the mainView
                messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                
                messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            ])
        }

}
