//
//  WeatherForecastController.swift
//  WeatherApp
//
//  Created by David Rifkin on 10/8/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit
import DataPersistence


class WeatherForecastController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var zipCodeTextFeild: UITextField!
    
    @IBOutlet weak var centerYConstraint: NSLayoutConstraint!
    
    private var keyboardIsVisible =  false
    private var originalCenterYContraint: NSLayoutConstraint!
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
        collectionView.isPagingEnabled = true
        zipCodeTextFeild.delegate = self
        changeBackGround()
registerForKerboardNoftifications()
        collectionView.backgroundColor = UIColor(displayP3Red: 0.7, green: 0.1, blue: 0.4, alpha: 0.5)
        getForcast(with: zipCode)
       
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unregisterForKeyboardNotifications()
    }
    
    
    var locationPictures = [Images]()
    
    var cityName = "N/A" {
        didSet{
            locationLabel.text = cityName
    }
}
    var zipCode = "11203" {
        didSet {
            DispatchQueue.main.async {
           
                self.getForcast(with: self.zipCode)
                self.collectionView.reloadData()
                
                
                
        }
    }
}
    private func getForcast(with string: String) {
        
        ZipCodeHelper.getLatLong(fromZipCode: string) { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.showAlert(title: "Please enter a valid zipcode!", message: "Error: \(error)")
                
            case .success(let coordinates):

                print(coordinates.placeName)
                
                self?.cityName = coordinates.placeName
                self?.getImage(for: coordinates.placeName)
                
                
                self?.getCoordinates(lat: coordinates.lat, long: coordinates.long)
        }
    }
}
    
    func getCoordinates(lat:Double, long: Double) {
        WeatherAPIClient.getForcast(with: lat, long: long) { [weak self] (result) in
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
    
    func getImage(for string: String){
        PhotoApiClient.getImageURL(with: string) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("THIS IS THE ERROR\(error)")
                
            case .success(let images):
                DispatchQueue.main.async {
                    self?.locationPictures = images
                    print(self?.locationPictures.first?.largeImageURL ?? "nothing here")
                    
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
    
    private func registerForKerboardNoftifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object:nil)
    }
    
    private func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object:nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object:nil)
        
    }
    
    @objc
    private func keyboardWillShow(_ notification: NSNotification){
       
        

        
        guard let keyboardFrame = notification.userInfo?["UIKeyboardFrameBeginUserInfoKey"] as? CGRect else {
            return
    }
        
        moveKeyboardUp(keyboardFrame.size.height)
        
    }
    
    @objc
    private func keyboardWillHide(_ notification: NSNotification){

      resetUI()
    }
    
    func moveKeyboardUp(_ height: CGFloat) {
        if keyboardIsVisible {return}
    originalCenterYContraint = centerYConstraint
        centerYConstraint.constant -= (height - 75)
        
        UIView.animate(withDuration: 1.0, delay: 0.2, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        keyboardIsVisible = true
    }
    
    
    func resetUI() {
        
       
        centerYConstraint.constant -= originalCenterYContraint.constant
    
        keyboardIsVisible = false
    }
    
}
extension WeatherForecastController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print(weatherForTheWeek.count)
        return weatherForTheWeek.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let dayOfTheWeekCell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayOfTheWeekCell", for: indexPath) as? WeeklyWeatherCell else {
            fatalError("could not downcast to WeeklyWeatherCell")
        }
        
        let cellInRow = weatherForTheWeek[indexPath.row]
        
        dayOfTheWeekCell.locationLabel.text = cityName
        
        dayOfTheWeekCell.configureCell(for: cellInRow)
        
        return dayOfTheWeekCell
    }
    
    
}

extension WeatherForecastController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
       
        
        return CGSize(width: 400, height: 460)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let detailVC = DetailViewController()
        detailVC.detailView.backgroundColor = UIColor(displayP3Red: 0.2, green: 0.1, blue: 0.5, alpha: 0.6)
        
        detailVC.photo = locationPictures[indexPath.row]
        detailVC.details = weatherForTheWeek[indexPath.row]
    
    
        navigationController?.pushViewController(detailVC, animated: true)
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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


