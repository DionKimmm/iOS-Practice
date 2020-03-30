//
//  DemoURL.swift
//  Cassini
//
//  Created by 김동욱 on 29/03/2020.
//  Copyright © 2020 dionkim. All rights reserved.
//

import Foundation

struct  DemoURL
{
//    static let Stanford = "http://comm.stanford.edu/wp-content/uploads/2013/01/stanford-campus.png"
    static  let NASA = [
        "Cassini"  :  "http://www.nasa.gov/sites/default/files/thumbnails/image/pia20486-1041.jpg",
        "Earth"  :  "http://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg",
        "Saturn"  :  "http://www.nasa.gov/sites/default/files/saturn_collage.jpg"
    ]
    
    static  func  NASAImageNamed ( imageName : String? ) -> URL? {
        if  let urlstring = NASA [imageName ??  "" ] {
            return  URL ( string : urlstring)
        } else {
            return  nil
        }
    }
}
