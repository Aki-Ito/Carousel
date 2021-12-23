//
//  CarouselView.swift
//  Carousel
//
//  Created by 伊藤明孝 on 2021/12/23.
//

import UIKit

class CarouselView: UICollectionView {

    //isInfinity controlls function of the infinite scroll
    let isInfinity: Bool = true
    
    var cellItemsWidth: CGFloat = 0.0

    let cellIdentifier = "carousel"
    let colors: [UIColor] = [.blue, .yellow, .green, .gray, .red]
    let pageCount = 5
    //イニシャライザを記述
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.delegate = self
        self.dataSource = self
        self.register(CarouselCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    convenience init(frame: CGRect){
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: frame.height/2)
        layout.scrollDirection = .horizontal
        self.init(frame: frame, collectionViewLayout: layout)
        
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = UIColor.white
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension CarouselView: UICollectionViewDelegate{
    
}

extension CarouselView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isInfinity ? pageCount*3 : pageCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CarouselCell
        
        cofigureCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    func cofigureCell(cell: CarouselCell, indexPath: IndexPath){
        let fixedIndex = isInfinity ? indexPath.row % pageCount : indexPath.row
        cell.contentView.backgroundColor = colors[fixedIndex]
    }
}

extension CarouselView: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isInfinity{
            if cellItemsWidth == 0.0{
                cellItemsWidth = floor(scrollView.contentSize.width/3.0)
            }
            
            if (scrollView.contentOffset.x <= 0.0) || (scrollView.contentOffset.x > cellItemsWidth*2.0){
                scrollView.contentOffset.x = cellItemsWidth
            }
        }
    }
}
