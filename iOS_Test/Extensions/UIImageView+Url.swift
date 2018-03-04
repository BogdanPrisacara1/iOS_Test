import UIKit

extension UIImageView {
    
    func downloadedFrom(link: String, contentMode: UIViewContentMode, forceCache: Bool) {
        if !forceCache {
            self.downloadedFrom(link: link, contentMode: contentMode)
        }
        
        //check if file with name "link" exists
        //stringByRemovingPercentEncoding
        let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        if let fileName = link.removingPercentEncoding {
            let path = URL(fileURLWithPath: dir).appendingPathComponent(fileName.replacingOccurrences(of: "/", with: "", options: NSString.CompareOptions.caseInsensitive, range: nil))
            
            if FileManager.default.fileExists(atPath: path.path){
                if let data = try? Data(contentsOf: URL(fileURLWithPath: path.path)){
                    let image = UIImage(data: data)
                    self.image = image
                    return;
                }
            }
        }
        
        //if not, load from url and save it
        guard
            let url = URL(string: link)
            else {return}
        self.contentMode = contentMode
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            guard
                let httpURLResponse = response as? HTTPURLResponse , httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType , mimeType.hasPrefix("image"),
                let data = data , error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async { () -> Void in
                self.image = image
                
                //create file in cache directory
                let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
                if let fileName = link.removingPercentEncoding{
                    let path = URL(fileURLWithPath: dir).appendingPathComponent(fileName.replacingOccurrences(of: "/", with: "", options: NSString.CompareOptions.caseInsensitive, range: nil))
                    try? data.write(to: path, options: [.atomic])
                }
            }
        }).resume()
    }
    
    func downloadedFrom(link: String, contentMode : UIViewContentMode) {
        guard
            let url = URL(string: link)
            else {return}
        self.contentMode = contentMode
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async { () -> Void in
                self.image = image
            }
        }).resume()
    }
}
