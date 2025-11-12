//
//  HomeViewModel.swift
//  MVVM-Example
//
//  Created by Melike Su KOÇYİĞİT on 1.11.2025.
//

import Foundation

//fonksiyonların hepsini protocol aracılığıyla homeviewmodele vereceğiz clousure ile de olabilir ama biz protocol kullanıcaz.
protocol HomeViewModelInterface {
    var view: HomeScreenInterface? {get set}
    
    func viewDidLoad()
    func getMovies()
    
    
}
final class HomeViewModel {
// hiçbir class bundan inherit yani miras almayacağı için final koyuyoruzn daha performanslı yani
// tüm talimatları viewmodel viewcontrollera söyler. bütün kararlar buradan geçer. biz ne yap dersek viewcontroller onu yapar
   weak var view: HomeScreenInterface? 
//bir protocolu weak yapmak ,için bunun sadece classlara uygulanabileceğini belirtmemiz gerekiyor -> Anyu Object koyduk
   private let service = MovieService()
   var movies: [MovieResult] = []
    private var page: Int = 1
    
}


extension HomeViewModel: HomeViewModelInterface {
    //extensionlara computed property koyabiliyorum ama stored property konulmuyor.
    func viewDidLoad() {
        view?.configureVC()
        view?.configureCollectionView()
        getMovies()
    }
    
    func getMovies() {
//        shouldDownloadMore = false
        service.downloadMovies(page: page) { [weak self] returnedMovies in
            guard let self = self else { return }
            guard let returnedMovies = returnedMovies else { return }
            //closure içşinde olduğumuz için self kullanıyoruz
            
            self.movies.append(contentsOf: returnedMovies)
            self.page += 1   //pagination işlemi
            self.view?.reloadCollectionView() // yeni data olduğu için yenilemek gerekiyor
            //self.shouldDownloadMore = true
            
           // self.movies = returnedMovies
        }
    }
    
    func getDetail(id:Int) {
        service.downloadDetail(id: id ) { [weak self] returnedDetail in
            guard let self = self else { return } // view e ulaşacağımız için kullanıyoruz
            guard let returnedDetail = returnedDetail else { return }

            self.view?.navigateToDetailScreen(movie: returnedDetail)

        }
    }
    
}
