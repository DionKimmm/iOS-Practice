//
//  CassiniViewController.swift
//  Cassini
//
//  Created by 김동욱 on 30/03/2020.
//  Copyright © 2020 dionkim. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {
    
    // *** 스토리보드 어디든 넣은 String은 여기 struct로 수집될 예정
    private struct Storyboard {
        static let ShowImageSegue = "Show Image"
    
    }
    
    // segue Way를 우리는 지금 버튼으로 다루고 있으니
    // sender 자리는 UIButton 타입이 될 것임.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.ShowImageSegue {
            if let ivc = (segue.destination.contentView as? ImageViewController)  {
                let imageName = (sender as? UIButton)?.currentTitle
                ivc.imageURL = DemoURL.NASAImageNamed(imageName: imageName) as NSURL?
                ivc.title = imageName
                
            }
        }
    }
    
    extension UIViewController {
        var contentViewController: UIViewController {
            if let navcon = self as? UINavigationController {
                return navcon.visibleViewController ?? self
            } else {
                return self
            }
        }
    }
}
