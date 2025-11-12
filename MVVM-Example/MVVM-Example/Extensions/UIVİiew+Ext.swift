//
//  UIVİiew+Ext.swift
//  MVVM-Example
//
//  Created by Melike Su KOÇYİĞİT on 2.11.2025.
//

import UIKit // bunda zaten import foundation var

extension UIView {
    func pinToEdgesOf(view: UIView) {
        NSLayoutConstraint.activate([
          topAnchor.constraint(equalTo: view.topAnchor), //self dediğimiz collectionview.koymasak da olur self.topanchor
          leadingAnchor.constraint(equalTo: view.leadingAnchor),
          trailingAnchor.constraint(equalTo: view.trailingAnchor),
          bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


//ben istiyorum ki benim collectionviewim tüm ekranımı kaplasın.aşağıdakini extensiona yazdık
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),   //sol
//            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor), //sağ
//            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
