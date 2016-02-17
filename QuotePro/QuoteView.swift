//
//  QuoteView.swift
//  QuotePro
//
//  Created by Cory Alder on 2016-02-16.
//  Copyright © 2016 Cory Alder. All rights reserved.
//

import UIKit

class QuoteView: UIView {
    @IBOutlet var quotePhoto: UIImageView!
    @IBOutlet var quoteLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    
    func setupWithQuote(quote: Quote) {
        self.quoteLabel.text = quote.text
        self.authorLabel.text = quote.author
        
        if let pic = quote.photo {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(pic.urlWithSize(self.frame.size, blur: true)) {
                data, resp, err in
                
                if let data = data {
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.quotePhoto.image = UIImage(data: data)
                    }
                }
                
            }
            
            task.resume()
            
        }
        
    }
}
