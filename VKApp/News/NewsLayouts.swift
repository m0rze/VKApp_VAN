//
//  NewsLayouts.swift
//  VKApp
//
//  Created by Алексей Виноградов on 03.09.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import UIKit

class NewsLayouts: UICollectionViewLayout {
    
    
    var cacheAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
    var columnsCount = 1
    private var totalCellsHeight: CGFloat = 0
    
    
    
    override func prepare() {
        self.cacheAttributes = [:]
        
        guard let collectionView = self.collectionView else { return }
        let cellHeight: CGFloat = collectionView.frame.height
        
        let itemsCount = collectionView.numberOfItems(inSection: 0)
        
        guard itemsCount > 0 else { return }
        
        let bigCellWidth = collectionView.frame.width
        
        var lastY: CGFloat = 0
        
        for index in 0..<itemsCount {
            let indexPath = IndexPath(item: index, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = CGRect(x: 0, y: lastY,
                                      width: bigCellWidth, height: cellHeight)
            
            lastY += cellHeight
            
            cacheAttributes[indexPath] = attributes
        }
        
        self.totalCellsHeight = lastY
        
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cacheAttributes.values.filter { attributes in
            return rect.intersects(attributes.frame)
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cacheAttributes[indexPath]
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: self.collectionView?.frame.width ?? 0,
                      height: self.totalCellsHeight)
    }
    
}
