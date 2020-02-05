//
//  FavoritesCollectionViewCell.swift
//  WeatherApp
//
//  Created by Tiffany Obi on 2/4/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

protocol ImageCellDelegate: AnyObject { //Any Object requires ImageCellDelegate only works with class types
    
    // list required functions, initializers, variables
    func didLongPress(_ imageCell: FavoritesCollectionViewCell)

}

class FavoritesCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    weak var delegate: ImageCellDelegate?
    
    override func layoutSubviews() {
           super.layoutSubviews()

           // function gets called when longpress is activated
           addGestureRecognizer(longPressGesture)
       }
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(longPressAction(gesture:)))
        return gesture
    }()

    @objc
     private func longPressAction(gesture: UILongPressGestureRecognizer){
         
         if gesture.state == .began {
             gesture.state = .cancelled
             return
         }
         
         print("long press activated")
         
         //STEP 3: creating custom delegation - explicitly use
         // delegate object to notify of any updates
         // notifying the ImageViewController when the user long presses the cell
         
         delegate?.didLongPress(self)
         
     }
    
    
    public func configureCell(with imageData: ImageData){
        imageView.image = UIImage(data: imageData.imageData)
    }
    
}
