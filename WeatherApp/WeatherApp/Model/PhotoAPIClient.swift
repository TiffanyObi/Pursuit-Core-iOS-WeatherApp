//
//  PhotoAPIClient.swift
//  WeatherApp
//
//  Created by Tiffany Obi on 2/4/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation
import NetworkHelper


struct PhotoApiClient {
    
static func getImageURL(with string: String,completion: @escaping (Result<[Images],AppError>) -> ()) {
    
    
    let string = string.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    
     
    let imageURLString = "https://pixabay.com/api/?key=14991195-8bdef4aad1892394c43a7f47f&q=\(string ?? "new york")&image_type=photo"
     
     guard let url = URL(string: imageURLString ) else { return }
    
     let request = URLRequest(url: url)
     
     NetworkHelper.shared.performDataTask(with: request) { (result) in
         switch result {
         case.failure(let appError):
            completion(.failure(.networkClientError(appError)))
             print("THIS IS NOT WORKING")
         case .success(let imageData):
             
             do {
              let imagesData = try JSONDecoder().decode(CityImage.self, from: imageData)
                 
                completion(.success(imagesData.hits))
                print("THIS IS WORKING\(imagesData.hits.first?.largeImageURL ?? "")")
                
             } catch {
                 print(error)
             }
         }
     }
     
 }
 
}
