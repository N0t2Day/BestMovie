

import UIKit

open class CacheImageView: UIImageView {
  public static let imageCache = NSCache<NSString, CacheImageViewItem>()
    
  open var shouldUseEmptyImage = true
    
  private var urlStringForChecking: String?
  private var emptyImage: UIImage?
    
  public init(cornerRadius: CGFloat = 0, emptyImage: UIImage? = nil) {
    super.init(frame: .zero)
    contentMode = .scaleAspectFill
    clipsToBounds = true
    layer.cornerRadius = cornerRadius
    self.emptyImage = emptyImage
  }
    
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    image = nil
  }
    
  open func loadImage(urlString: String, completion: (() -> ())? = nil) {
    image = nil
        
    urlStringForChecking = urlString
        
    let urlKey = urlString as NSString
        
    if let cachedItem = CacheImageView.imageCache.object(forKey: urlKey) {
      image = cachedItem.image
      completion?()
      return
    }
        
    guard let url = URL(string: urlString) else {
      if shouldUseEmptyImage {
        image = emptyImage
      }
      return
    }
    URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data, _, error in
      if error != nil {
        return
      }
            
      DispatchQueue.main.async {
        if let image = UIImage(data: data!) {
          let cacheItem = CacheImageViewItem(image: image)
          CacheImageView.imageCache.setObject(cacheItem, forKey: urlKey)
                    
          if urlString == self?.urlStringForChecking {
            self?.image = image
            completion?()
          }
        }
      }
            
    }).resume()
  }
}
