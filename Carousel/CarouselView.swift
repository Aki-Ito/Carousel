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
    //実際に表示するセルの横の長さを格納する変数
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
    
    //layoutSubviews
    //制約を使い、サブビューのサイズと位置を調整する。
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let cells = self.visibleCells
        for cell in cells{
            //セルの大きさを変更する
            transformScale(cell: cell)
        }
        
        
    }
    
    
    convenience init(frame: CGRect){
        let layout = UICollectionViewFlowLayout()
//        let layout = PerCellPadingFlowLayout()
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
    
    func transformScale(cell: UICollectionViewCell){
        //計算してスケールを変更する
        let cellCenter: CGPoint = self.convert(cell.center, to: nil)
        let screenCenterX: CGFloat = UIScreen.main.bounds.width/2
        //縮小率
        let reductionRatio: CGFloat = -0.0009
        let maxScale: CGFloat = 1
        //中心までの距離
        let cellCenterDisX: CGFloat = abs(screenCenterX - cellCenter.x)
        let newScale = reductionRatio*cellCenterDisX + maxScale
        cell.transform = CGAffineTransform(scaleX: newScale, y: newScale)
    }
    
    func scrollToFirstItem(){
        self.layoutIfNeeded()
        //pageCount means IndexPath[0]
        if isInfinity{
            self.scrollToItem(at: IndexPath(row: self.pageCount, section: 0), at: .centeredHorizontally, animated: false)
        }
    }

}

extension CarouselView: UICollectionViewDelegate{
    
}

extension CarouselView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return isInfinity ? pageCount*3 : pageCount
        return pageCount*3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CarouselCell
        
        cofigureCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    func cofigureCell(cell: CarouselCell, indexPath: IndexPath){
//        let fixedIndex = isInfinity ? indexPath.row % pageCount : indexPath.row
        let fixedIndex = indexPath.row % pageCount
        cell.contentView.backgroundColor = colors[fixedIndex]
    }
}

//セルの配置位置に関する調整
extension CarouselView: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //contentSizeはscrollViewのスクロール領域を設定している。
        //contentOffsetは初期状態からどれだけスクロールしたかを表している。
        if isInfinity{
            if cellItemsWidth == 0.0{
                cellItemsWidth = floor(scrollView.contentSize.width/3.0)
            }

            if (scrollView.contentOffset.x <= 0.0) || (scrollView.contentOffset.x > cellItemsWidth*2.0){
                scrollView.contentOffset.x = cellItemsWidth
            }
        }
        
        print(scrollView.contentOffset.x)
    }
}
