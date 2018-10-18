//
//  Station.swift
//  Radio
//
//  Created by Georgy Dyagilev on 18/10/2018.
//  Copyright © 2018 Georgy Dyagilev. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Station {
    var name: String
    var description: String
    var image: UIImage
    var streamURL: String
    
    init(name: String, description: String, image: UIImage, streamURL: String) {
        self.name = name
        self.description = description
        self.image = image
        self.streamURL = streamURL
    }
}

func loadStations (complition: @escaping ([Station]) -> Void) {
    var stations = [Station]()
    guard let url = URL(string: "https://api.dirble.com/v2/stations/popular?token=5af2c41a815f5057290d30e55f") else { return }
    Alamofire.request(url, method: .get).responseData { (response) in
        if let data = response.result.value {
            let json = JSON(data)
            
            for (_, subJson):(String, JSON) in json {
                let name = subJson["name"].stringValue
                var description = ""
                let desc = subJson["categories"][0]["description"].stringValue
                
                if desc != "" {
                    description = desc
                } else {
                    description = "No description"
                }
                
                let imageURL = subJson["image"]["thumb"]["url"].stringValue
                let image = loadImage(from: imageURL)
                let streamingURL = subJson["streams"][0]["stream"].stringValue
                
                let station = Station(name: name,
                                      description: description,
                                      image: image,
                                      streamURL: streamingURL)
                stations.append(station)
            }
            complition(stations)
        }
    }
}

func loadImage(from: String) -> UIImage {
    guard let url = URL(string: from) else {
        return UIImage(named: "radio.png")!
    }
    guard let data = try? Data(contentsOf: url) else {
        return UIImage(named: "radio.png")!
    }
    guard let image = UIImage(data: data) else {
        return UIImage(named: "radio.png")!
    }
    
    let size = image.size
    let widthRatio = 58 / size.width
    let heightRatio = 58 / size.height
    let newSize = widthRatio > heightRatio ? CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio, height: size.height * heightRatio)
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
}
