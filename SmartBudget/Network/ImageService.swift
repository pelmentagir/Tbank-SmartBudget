import Foundation
import UIKit

class ImageService {
    
    static let cache: NSCache<NSURL, NSData> = .init()
    
    static func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        if let imageData = cache.object(forKey: url as NSURL) {
            completion(UIImage(data: imageData as Data))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            cache.setObject(data as NSData, forKey: url as NSURL)
            completion(UIImage(data: data))
        }.resume()
    }
    
    static func downloadImageData(from urlString: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        if let imageData = cache.object(forKey: url as NSURL) {
            completion(imageData as Data)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            cache.setObject(data as NSData, forKey: url as NSURL)
            completion(data)
        }.resume()
    }
}
