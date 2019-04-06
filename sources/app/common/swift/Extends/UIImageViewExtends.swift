//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit

//MARK: - Custom UIImageView
extension UIImageView{
    func setImage(_ image: UIImage?,_ color: UIColor?){
        
        if let img = image{
            self.image = img.withRenderingMode(.alwaysTemplate)
        }else{
            self.image = image
        }
        
        self.tintColor = color
    }
}

let imageCaches = NSCache<AnyObject, AnyObject>()

//MARK: - UIImageView load image from url
extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit,image placeholder: UIImage? = nil,_ completion: ((UIImage)->Void)? = nil,_ failed: ((Error?)->Void)? = nil) {
        
        image = nil
        
        if let imageFromCache = imageCaches.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: self.frame.width * 0.8, height: self.frame.height * 0.8)
        activityIndicator.hidesWhenStopped = true
        self.superview?.addSubview(activityIndicator)
        activityIndicator.center = self.center
        self.superview?.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
        
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    DispatchQueue.main.async {
                        if let defaultImg : UIImage = placeholder {
                            self.image = defaultImg
                        }
                        activityIndicator.stopAnimating()
                        activityIndicator.removeFromSuperview()
                    }
                    failed?(error)
                    return
            }
            DispatchQueue.main.async() {
                self.image = image
                imageCaches.setObject(image, forKey: url as AnyObject)
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
                completion?(image)
            }
            }.resume()
    }
    
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit, image placeholder: UIImage? = nil,_ completion: ((UIImage)->Void)?,_ failed: ((Error?)->Void)? = nil) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode,image:placeholder,completion,failed)
    }
}
