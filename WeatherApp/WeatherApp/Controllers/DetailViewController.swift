//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Tiffany Obi on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import ImageKit

class DetailViewController: UIViewController {
    let detailView = DetailView()
    
    private var weatherDetails: Details!
    override func loadView() {
        super.loadView()
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        updateUI()
    }
    
var imageName = "New york"
    
    private func updateUI() {
        
   
        
        let image = "https://pixabay.com/api/?key=14991195-8bdef4aad1892394c43a7f47f&q=\(imageName)"
        
        detailView.cityImageView.getImage(with: image) { (result) in
            switch result {
            case.failure:
                break
                
            case.success(let image):
                self.detailView.cityImageView.image = image
            }
        }
        
    }

}
