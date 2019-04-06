//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    //To load image from local
    convenience init?(localImage name: String) {
        // declare image location
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsURL.appendingPathComponent("\(name)")
        
        var data: Data?
        // check if the image is stored already
        if FileManager.default.fileExists(atPath: fileURL.path),
            let imageData: Data = try? Data(contentsOf: fileURL){
            data = imageData
        }
        
        self.init(data: data ?? Data())
    }
    
    //To save data
    func saveImage(name: String) throws{
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsURL.appendingPathComponent("\(name)")
        try self.pngData()?.write(to: fileURL)
    }
    
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    public func withRoundCorners(_ cornerRadius: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let rect = CGRect(origin: CGPoint.zero, size: size)
        let context = UIGraphicsGetCurrentContext()
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        
        context?.beginPath()
        context?.addPath(path.cgPath)
        context?.closePath()
        context?.clip()
        
        draw(at: CGPoint.zero)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return image;
    }

    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ quality: JPEGQuality) -> Data? {
        return self.jpegData(compressionQuality: quality.rawValue)
    }
    
    func withColor(color:UIColor)->UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
    func resizeImageWith(newSize: CGSize) -> UIImage {
        
        let horizontalRatio = newSize.width / size.width
        let verticalRatio = newSize.height / size.height
        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContext( newSize );
        self.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let dataImage = newImage.pngData()
        return UIImage(data: dataImage!)!
    }
    
    func drawGradientImage(from beginColor: UIColor?, to endColor: UIColor?, imageSize: CGSize,offset: CGFloat = 0,strokeColor: UIColor?) -> UIImage? {
        //   set sideline width
        let lineWidth: CGFloat = 2.0
        //   set a canvas, and use the imageSize
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        //   set RGB color space
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        //   set draw context
        let context = UIGraphicsGetCurrentContext()
        //   set color to array
        let gradientColors = [beginColor?.cgColor, endColor?.cgColor]
        //   set range 0~1
        //   two value, cause two color
        //   if more color, add more value
        let gradientLocation: [CGFloat] = [0, 1]
        //   set gradient info
        let gradient = CGGradient(colorsSpace: colorSpace, colors: gradientColors as CFArray, locations: gradientLocation)
        //   set rectangle path for bezier path
        let bezierPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        context?.saveGState()
        bezierPath.addClip()
        //   set gradient start point and end point
        let beginPoint = CGPoint(x: imageSize.width / 2, y: 0)
        let endPoint = CGPoint(x: imageSize.width / 2, y: imageSize.height - offset)
        //   add position to linear gradient
        context?.drawLinearGradient(gradient!, start: beginPoint, end: endPoint, options: [])
        if (strokeColor != nil) {
            //   set sideline info
            context?.setStrokeColor(UIColor.black.cgColor)
            //   draw sideline
            bezierPath.lineWidth = lineWidth
            //   fill gradient color
            bezierPath.stroke()
        }
        context?.restoreGState()
        context?.fillPath()
        
        //   output context to image
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        //   context end and release
        UIGraphicsEndImageContext()
        return image
    }
    
    
    func save(withName: String, compressionQuality min: Int) -> URL? {
        
        guard let imageData = self.jpegData(compressionQuality: 1) else {
            return nil
        }
        let imageSize = Double(imageData.count) / 1024.0
        var x: Double = round(Double(min) / imageSize * 100.0) / 100.0
        x = x > 0.3 ? x : 0.3
        let finalData = UIImage(data: imageData)?.jpegData(compressionQuality: CGFloat(x))
        do {
            let imageURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(withName)
            try finalData?.write(to: imageURL)
            return imageURL
        } catch {
            return nil
        }
    }

}
