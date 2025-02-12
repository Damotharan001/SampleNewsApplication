//
//  ImageCacheManager.swift
//  SampleNewsApplication
//
//  Created by Home on 12/02/25.
//

import UIKit
import Foundation

class ImageCacheManager {
    static let shared = ImageCacheManager()
    private let cache = NSCache<NSString, AnyObject>()
    
    private init() {}

    /// Fetch image from cache or download if not available
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        // If not cached, download the image
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.downloadTask(with: URLRequest(url: url), completionHandler: { (filelocation, response, error) in
            guard let filelocation else {
                completion(nil)
                return
            }
            do {
                let data = try Data(contentsOf: filelocation)
                if let image = UIImage(data: data) {
                    self.cache.setObject(image, forKey: urlString as NSString)
                    completion(image)
                    return
                }
            } catch { }
            completion(nil)
            
        }).resume()
    }
    
    func getImage(urlString: String) -> UIImage? {
        // Check if the image is already cached
        cache.object(forKey: urlString as NSString) as? UIImage
    }
    
    func reset() {
        cache.removeAllObjects()
    }
}

extension UIImageView {
    func setImage(from urlString: String, placeholder: UIImage? = nil) {
        self.image = ImageCacheManager.shared.getImage(urlString: urlString)
    }
}
