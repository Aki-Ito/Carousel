//
//  ViewController.swift
//  Carousel
//
//  Created by 伊藤明孝 on 2021/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    var carouselView: CarouselView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        carouselView = CarouselView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        carouselView.center = CGPoint(x: width/2, y: height/2)
        self.view.addSubview(carouselView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        carouselView.scrollToFirstItem()
    }


}

