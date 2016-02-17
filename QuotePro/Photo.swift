//
//  Photo.swift
//  QuotePro
//
//  Created by Cory Alder on 2016-02-16.
//  Copyright © 2016 Cory Alder. All rights reserved.
//

import UIKit


struct Photo {
    let id: Int
    
    func urlWithSize(size: CGSize, blur: Bool) -> NSURL {
        
        let blurStr = blur ? "&blur" : ""
        
        return NSURL(string: "https://unsplash.it/\(size.width)/\(size.height)/?image=\(id)\(blurStr)")!
    }
}