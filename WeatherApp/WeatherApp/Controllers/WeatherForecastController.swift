//
//  WeatherForecastController.swift
//  WeatherApp
//
//  Created by David Rifkin on 10/8/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class WeatherForecastController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var zipCodeTextFeild: UITextField!
    
    public var weatherForTheWeek = [Details]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        zipCodeTextFeild.delegate = self
        changeBackGround()
        collectionView.backgroundColor = UIColor(displayP3Red: 0.7, green: 0.1, blue: 0.4, alpha: 0.5)
        getForcast(with: zipCode)
    }

    var cityName = ""
    var zipCode = "11203" {
        didSet {
            DispatchQueue.main.async {
           
                self.getForcast(with: self.zipCode)
                self.collectionView.reloadData()
        }
    }
}
    private func getForcast(with string: String) {
        
        ZipCodeHelper.getLatLong(fromZipCode: string) { [weak self](result) in
            switch result {
            case .failure(let error):
                print(error)
                
            case .success(let coordinates):
                
                self?.cityName = coordinates.placeName
                print(coordinates.placeName)
                WeatherAPIClient.getForcast(with: coordinates.lat, long: coordinates.long) { [weak self] (result) in
                    switch result {
                    case .failure(let error):
                        print(error)
                        
                    case .success(let details):
                        DispatchQueue.main.async {
                        
                        self?.weatherForTheWeek = details
                    }
                }
            }
        }
    }
}
    
   public func changeBackGround() {
       let  randRed = CGFloat.random(in: 0...1)
       let  randBlue = CGFloat.random(in: 0...1)
       let  randGreen = CGFloat.random(in: 0...1)
        
        let myColor = UIColor(red: randRed, green: randGreen, blue: randBlue, alpha: 1)
    view.backgroundColor = myColor
    }
}
extension WeatherForecastController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(weatherForTheWeek.count)
        return weatherForTheWeek.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let dayOfTheWeekCell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayOfTheWeekCell", for: indexPath) as? WeeklyWeatherCell else {
            fatalError("could not downcast to WeeklyWeatherCell")
        }
        
        let cellInRow = weatherForTheWeek[indexPath.row]
        
        
        dayOfTheWeekCell.configureCell(for: cellInRow)
        
        return dayOfTheWeekCell
    }
    
    
}

extension WeatherForecastController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       
        
        return CGSize(width: 375, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let detailVC = DetailViewController()
        
        
        navigationController?.pushViewController(detailVC, animated: true)
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

extension WeatherForecastController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard !(textField.text?.isEmpty ?? true) else {
            return false
        }
        textField.resignFirstResponder()
        zipCode = textField.text ?? "90210"
        
        changeBackGround()
        return true
    }
}


