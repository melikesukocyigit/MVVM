//
//  UIHelper.swift
//  MVVM-Example
//
//  Created by Melike Su KOÇYİĞİT on 2.11.2025.
//

import UIKit

enum UIHelper {
    static func createHomeFlowLayout() -> UICollectionViewFlowLayout { // FUNC KOYACAKSAK STATİC OLMALI
        let layout = UICollectionViewFlowLayout()
        
        let itemWidth = CGFloat.dWidth
        
        
        layout.scrollDirection = .vertical
     // layout.sectionInset = UIEdgeInsets(top: 30, left: 10, bottom: 30, right: 10) şu an lazım değil
    //HÜCRE BOYUTU İÇİN, apideki fotoğarflar 1 e 1.5 geldiği için biz de böyle yazdık.

        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)
        layout.minimumLineSpacing = 40 // aralaqrındaki boşluk 
        
        return layout
    }
}
