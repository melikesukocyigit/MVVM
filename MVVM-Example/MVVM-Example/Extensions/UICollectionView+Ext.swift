//
//  UICollectionView+Ext.swift
//  MVVM-Example
//
//  Created by Melike Su KOÇYİĞİT on 2.11.2025.
//

import UIKit

extension UICollectionView {
    func reloadOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
