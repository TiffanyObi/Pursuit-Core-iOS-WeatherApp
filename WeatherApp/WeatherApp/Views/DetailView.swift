//
//  DetailView.swift
//  WeatherApp
//
//  Created by Tiffany Obi on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import NetworkHelper

protocol FavoriteDelegate: AnyObject {
    func didFavoriteImage()
}

class DetailView: UIView {
    
    
    
 
weak var delegate: FavoriteDelegate?
let defaultMessage = ""
   public lazy var messageLabel: UILabel = {
          let label = UILabel()
          label.backgroundColor = .systemIndigo
          label.textAlignment = .center
          label.font = UIFont(name: "Didot", size: 30)
          label.text = defaultMessage
          label.textColor = .white
          return label
      }()
    
    public lazy var cityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
       
        return imageView
    }()
    private var toggleButtonColor:Bool = true
    public lazy var favoriteButton:UIButton = {
        let button = UIButton()
        button.setTitle("Favorite This Photo?", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        
        return button
    }()
    @objc private func saveButtonPressed(){
        if toggleButtonColor == false {
            favoriteButton.backgroundColor = .systemRed
            favoriteButton.setTitle("Favorite This Photo", for: .normal)
            toggleButtonColor = true } else if toggleButtonColor == true {
            favoriteButton.isEnabled = false
            favoriteButton.backgroundColor = .systemBlue
             favoriteButton.setTitle("Saved To Favorites", for: .normal)
            toggleButtonColor = false
        }
        delegate?.didFavoriteImage()
    }
    
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
        setUpImageViewConstraints()
        setUpButtonConstraints()
        
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
    
    func setUpImageViewConstraints() {
        addSubview(cityImageView)
        cityImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            cityImageView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 40),
            cityImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            cityImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            cityImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.4)
        
        
        ])
    }

    func setUpButtonConstraints() {
        addSubview(favoriteButton)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            favoriteButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            favoriteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -200)
        
        ])
    }

}
