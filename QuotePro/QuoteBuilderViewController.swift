//
//  QuoteBuilderViewController.swift
//  QuotePro
//
//  Created by Cory Alder on 2016-02-16.
//  Copyright © 2016 Cory Alder. All rights reserved.
//

import UIKit

class QuoteBuilderViewController: UIViewController {
    
    var photos = [Photo]()
    var quote = Quote()
    var quoteView = NSBundle.mainBundle().loadNibNamed("QuoteView", owner: nil, options: nil).first! as! QuoteView

    override func viewDidLoad() {
        super.viewDidLoad()

        quoteView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(quoteView)
        quoteView.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor).active = true
        quoteView.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.6).active = true
        quoteView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        quoteView.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
        
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "https://unsplash.it/list")!) {
            data, resp, err in
            
            guard let data = data,
                let json = (try? NSJSONSerialization.JSONObjectWithData(data, options: [])) as? [[String: AnyObject]]
                else {
                    print("error decoding image list \(err)")
                    return
            }
            
            for photoDict in json {
                
                if let photoId = photoDict["id"] as? Int {
                    let newPic = Photo(id: photoId)
                    self.photos.append(newPic)
                }
                
            }
            
            // ok now get a quote
            
            self.loadQuote()
        
        }
        
        task.resume()
        // Do any additional setup after loading the view.
    }
    
    func loadQuote() {
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "http://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json")!) {
            data, resp, err in
            
            
            if let data = data,
                let json = (try? NSJSONSerialization.JSONObjectWithData(data, options: [])) as? [String: AnyObject],
                let text = json["quoteText"] as? String,
                let author = json["quoteAuthor"] as? String {
            
                    self.quote.author = author
                    self.quote.text = text
                    
                    let randomIndex = Int(arc4random_uniform(UInt32(self.photos.count)))
                    self.quote.photo = self.photos[randomIndex]
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.quoteView.setupWithQuote(self.quote)
                    }
            }
            
            
        }
        
        task.resume()
    }


}
