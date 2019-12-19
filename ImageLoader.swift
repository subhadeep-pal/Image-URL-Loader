//
//  ImageLoader.swift
//  News
//
//  Created by Subhadeep Pal on 18/02/17.
//  Copyright © 2017 Subhadeep Pal. All rights reserved.
//  github: https://github.com/subhadeep-pal/Image-URL-Loader

import UIKit

protocol ImageLoaderProtocol: class {
    func imageLoaded(image: UIImage, forIndexPath indexPath: IndexPath)
}

class ImageLoader: NSObject {
    
    static let cache = NSCache<AnyObject, AnyObject>()
    
    weak var delegate: ImageLoaderProtocol?
    var indexPath: IndexPath?
    
    init(urlString: String, delegate: ImageLoaderProtocol, indexPath: IndexPath) {
        self.delegate = delegate
        self.indexPath = indexPath
        super.init()
        self.imageFromUrl(urlString: urlString)
    }
    
    override init() {
        super.init()
    }
    
    func imageFromUrl(urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            
            let urlSession = URLSession(configuration: .default)
            let dataTask = urlSession.dataTask(with: request, completionHandler: { (data, response, error) in
                if let imageData = data as Data? {
                    let image = UIImage(data: imageData)
                    ImageLoader.cache.setObject(imageData as AnyObject, forKey: urlString as AnyObject)
                    DispatchQueue.main.async {
                        self.delegate?.imageLoaded(image: image!, forIndexPath: self.indexPath!)
                    }
                }
            })
            
            dataTask.resume()
        }
    }
    
    func imageFromUrl(urlString: String, onCompletion: @escaping (UIImage?) -> Void) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            
            let urlSession = URLSession(configuration: .default)
            let dataTask = urlSession.dataTask(with: request, completionHandler: { (data, response, error) in
                if let imageData = data as Data? {
                    let image = UIImage(data: imageData)
                    ImageLoader.cache.setObject(imageData as AnyObject, forKey: urlString as AnyObject)
                    DispatchQueue.main.async {
                        onCompletion(image)
                    }
                }
            })
            
            dataTask.resume()
        }
    }
    
    func imageFromUrl(url: URL?, onCompletion: @escaping (UIImage?) -> Void) {
        if let url = url {
            let request = URLRequest(url: url)
            
            let urlSession = URLSession(configuration: .default)
            let dataTask = urlSession.dataTask(with: request, completionHandler: { (data, response, error) in
                if let imageData = data as Data? {
                    let image = UIImage(data: imageData)
                    ImageLoader.cache.setObject(imageData as AnyObject, forKey: url.absoluteString as AnyObject)
                    DispatchQueue.main.async {
                        onCompletion(image)
                    }
                }
            })
            
            dataTask.resume()
        }
    }
}
