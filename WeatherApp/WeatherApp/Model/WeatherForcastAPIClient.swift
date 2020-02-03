//
//  WeatherForcastAPIClient.swift
//  WeatherApp
//
//  Created by Tiffany Obi on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation
import NetworkHelper

struct WeatherAPIClient {
    
    static func getForcast(with lat: Double, long: Double, completion: @escaping (Result<[Details],AppError>) -> () ) {

        
        let weatherForecastUrl = "https://api.darksky.net/forecast/830f4b6fb284e95da3d4baf7d280824f/\(lat),\(long)"
        
        guard let url = URL(string: weatherForecastUrl) else {
            print(AppError.badURL(weatherForecastUrl))
            return
                    }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
                
            case .failure(let appError):
                completion(.failure(appError))
                
            case.success(let data):
                do {
            let weatherForcast = try JSONDecoder().decode(WeatherForecast.self, from: data)
                    completion(.success(weatherForcast.daily.data))
                } catch {
                    print(AppError.decodingError(error))
                }
                
            }
        }
        
    }
    
    
}
