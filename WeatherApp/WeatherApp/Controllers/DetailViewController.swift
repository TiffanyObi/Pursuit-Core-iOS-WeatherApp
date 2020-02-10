//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Tiffany Obi on 2/1/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import ImageKit
import NetworkHelper
import DataPersistence

class DetailViewController: UIViewController, FavoriteDelegate {
    
    func didFavoriteImage() {
        
        print("I was pressed")
                         if let imageData = saveImageData.jpegData(compressionQuality: 0.5){
                            let imageObject = ImageData(imageData: imageData)
                             do {
                                 try dataPersistance.createItem(imageObject)
                                print("success!!!!!")
                             } catch {
                                 print(error)
                             }
                         
                        }
                 }
    
    let detailView = DetailView()
    
    private var weatherDetails: Details!
    
   var dataPersistance = DataPersistence<ImageData>(filename:"images.plist")
    
    override func loadView() {
        super.loadView()
        view = detailView
    }

    var photo: Images?
    var details: Details!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        detailView.delegate = self
       updateUI(details)
    }
    private var saveImageData: UIImage!
    
    private func updateUI (_ details: Details) {
        
        detailView.summaryLabel.text = details.summary
        detailView.dewPointLabel.text = "Dew Point - \(details.dewPoint)"
        
      
        detailView.cityImageView.getImage(with: photo?.largeImageURL ?? "") { [weak self] (result) in
            switch result {
            case.failure:
                self?.detailView.cityImageView.image = UIImage(systemName: "exclamation_mark")
                
            case.success(let image):
                DispatchQueue.main.async {
                    self?.detailView.cityImageView.image = image
                    self?.saveImageData = image
            }
        }
    }
}
}
    




