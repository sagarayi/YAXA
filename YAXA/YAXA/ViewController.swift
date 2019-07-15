//
//  ViewController.swift
//  YAXA
//
//  Created by Sagar on 15/07/19.
//  Copyright © 2019 Sagar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var comicTitleLabel: UILabel!
    @IBOutlet weak var comicImageView: UIImageView!
    
    var currentComic: XKCDComic?
    var currentComicId: Int?
    var networkManager: NetworkManager?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(onLongPressed))
        self.comicImageView.addGestureRecognizer(longPress)
        
        let leftSwipe = UISwipeGestureRecognizer.init(target: self, action: #selector(onLeftSwiped))
        leftSwipe.direction = .left
        self.comicImageView.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer.init(target: self, action: #selector(onRightSwiped))
        rightSwipe.direction = .right
        self.comicImageView.addGestureRecognizer(rightSwipe)
        
        self.comicImageView.isUserInteractionEnabled = true
        
        fetchImageForID(imageID: "")
        
        
        // Do any additional setup after loading the view.
    }

    func getImageForURL(url:URL!) -> UIImage {
        let data = try? Data(contentsOf: url)
        
        return UIImage(data: data!)!
    }
    
    @objc func onLongPressed(sender: UILongPressGestureRecognizer) {
        
        if (self.currentComic != nil)
        {    
            let alertController = UIAlertController.init(title: self.currentComic?.title, message: self.currentComic?.altDesc, preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
            
            alertController.addAction(UIAlertAction.init(title: "Copy", style: .default, handler: { (_) in
                UIPasteboard.general.string = self.currentComic?.altDesc
            }))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func onLeftSwiped(sender: UISwipeGestureRecognizer) {
        
        fetchImageForID(imageID: String(currentComicId!+1))
//        if (self.currentComic != nil)
//        {
//            let alertController = UIAlertController.init(title: self.currentComic?.title, message: self.currentComic?.altDesc, preferredStyle: .alert)
//            
//            alertController.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
//            
//            
//            self.present(alertController, animated: true, completion: nil)
//        }
    }
    
    @objc func onRightSwiped(sender: UISwipeGestureRecognizer) {
        
        fetchImageForID(imageID: String(currentComicId!-1))
        
//        if (self.currentComic != nil)
//        {
//            let alertController = UIAlertController.init(title: self.currentComic?.title, message: self.currentComic?.altDesc, preferredStyle: .alert)
//
//            alertController.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
//
//            alertController.addAction(UIAlertAction.init(title: "Copy", style: .default, handler: { (_) in
//                UIPasteboard.general.string = self.currentComic?.altDesc
//            }))
//
//            self.present(alertController, animated: true, completion: nil)
//        }
    }
    
    func fetchImageForID(imageID:String) {
        
        if networkManager == nil {
            networkManager = NetworkManager()
        }
        
        networkManager?.fetchImageForId(imageID: imageID+"/", requestMethod: HTTPRequestMethod.get, completionHandler: { (xkcdComic, response, error) in
            if xkcdComic != nil {
                DispatchQueue.main.async {
                    self.currentComic = xkcdComic
                    self.comicTitleLabel.text = self.currentComic?.title
                    self.comicImageView.image = self.getImageForURL(url: URL(string: self.currentComic!.imgLink!))
                    self.currentComicId = self.currentComic?.id
                }
            }
        })
    }

}

