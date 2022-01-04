//
//  PerCellPadingFlowLayout.swift
//  Carousel
//
//  Created by 伊藤明孝 on 2021/12/23.
//

import UIKit

class PerCellPadingFlowLayout: UICollectionViewFlowLayout {
    
    var cellWidth: CGFloat = 200
    let windowWidth: CGFloat = UIScreen.main.bounds.width
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        var offsetAdjustment: CGFloat = CGFloat(MAXFLOAT)
        let horizontalOffset: CGFloat = proposedContentOffset.x + (windowWidth - cellWidth)/2
        let targetRect = CGRect(x: proposedContentOffset.x,
                                y: 0,
                                width: self.collectionView!.bounds.size.width,
                                height: self.collectionView!.bounds.size.height)
        
        let array = super.layoutAttributesForElements(in: targetRect)
        
        for layoutAttributes in array!{
            let itemOffset = layoutAttributes.frame.origin.x
            if abs(itemOffset - horizontalOffset) < abs(offsetAdjustment){
                offsetAdjustment = itemOffset - horizontalOffset
            }
        }
        
        return CGPoint(x: proposedContentOffset.x, y: proposedContentOffset.y)
    }

}
