//
//  ImagesStruct.swift
//  WeatherApp
//
//  Created by Tiffany Obi on 2/4/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation
struct CityImage: Equatable, Codable {
    let hits: [Images]
}

struct Images:Equatable, Codable {
    let largeImageURL : String
    let webformatHeight: Double
}

struct ImageData:Equatable, Codable {
    let imageData: Data
}
