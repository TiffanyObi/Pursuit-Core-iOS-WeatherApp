//
//  FavoritesCollectionViewCell.swift
//  WeatherApp
//
//  Created by Tiffany Obi on 2/2/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class FavoritesCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    func confgureCell(with imageData: ImageData) {
        
        imageView.image = UIImage(data: imageData.imageData)
    }
    
}
