//
//  ImageLoader.swift
//  News
//
//  Created by Subhadeep Pal on 18/02/17.
//  Copyright © 2017 Subhadeep Pal. All rights reserved.
//
import UIKit

protocol ImageLoaderProtocol {
    func imageLoaded(image: UIImage, forIndexPath indexPath: IndexPath)
}

class ImageLoader: NSObject {
    
    static let cache = NSCache<AnyObject, AnyObject>()
    
    var delegate: ImageLoaderProtocol
    var indexPath: IndexPath
    
    init(delegate: ImageLoaderProtocol, indexPath: IndexPath) {
        self.delegate = delegate
        self.indexPath = indexPath
    }
    
    func imageFromUrl(urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            
            let urlSession = URLSession(configuration: .default)
            let dataTask = urlSession.dataTask(with: request, completionHandler: { (data, response, error) in
                if let imageData = data as Data? {
                    let image = UIImage(data: imageData)
                    ImageLoader.cache.setObject(imageData as AnyObject, forKey: urlString as AnyObject)
                    DispatchQueue.main.async { Void in
                        self.delegate.imageLoaded(image: image!, forIndexPath: self.indexPath)
                    }
                }
            })
            
            dataTask.resume()
        }
    }
}
