//
//  PosterImageView.swift
//  MVVM-Example
//
//  Created by Melike Su KOÇYİĞİT on 2.11.2025.
//

import UIKit

final class PosterImageView: UIImageView {

    private var dataTask: URLSessionDataTask?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // UI da değişiklik yapacaksam main threadde yapılır. ama api gibi servisler backgorund threadde yapılır urlsseesion vs
    // indirme işlemi background threadde olur
    func downloadImage(movie: MovieResult) {
           guard let url = URL(string: APIURLs.imageURL(posterPath: movie._posterPath)) else { return }
           
           dataTask  = NetworkManager.shared.download(url: url) { [weak self] result in
               guard let self = self else { return }
               
               switch result {
               case .success(let data):
                   DispatchQueue.main.async { self.image = UIImage(data: data) } //main threade geçtik burada.UI yı update ettik. çünkü görsel geldiği zaman biz bunu değiştiricez sonuçta ondan main threade geçiyoruz.
               case .failure(_):
                   break
               }
           }
       }
    
    func cancelDownloading() {
           dataTask?.cancel()
           dataTask = nil
       }
        
    }

