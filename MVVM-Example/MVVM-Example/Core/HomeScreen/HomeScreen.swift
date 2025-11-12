//
//  HomeScreen.swift
//  MVVM-Example
//
//  Created by Melike Su KOÇYİĞİT on 1.11.2025.
//

import UIKit

protocol HomeScreenInterface: AnyObject {
    // protocoluns adece bir classa implement edilebileceğinden emin olmak için anyobject
    //bir protocolu weak yapmak için bunun sadece classlara uygulanabileceğini belirtmemiz gerekiyor -> Anyu Object koyduk

    func configureVC()
    func configureCollectionView()
    func reloadCollectionView()
    func navigateToDetailScreen(movie: MovieResult)
}
final class HomeScreen: UIViewController { // hiçbir class bundan inherit yeani miras almayacağı için final koyuyoruzn daha performanslı yani indexleme daha kolay yapılacak

    private let viewModel = HomeViewModel()
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self // bunun garantisini protocol ile sağlıyoruz.senin view in benim diyoruz burada
        viewModel.viewDidLoad()
    }
    
}

extension HomeScreen: HomeScreenInterface {
    func configureVC() {
        view.backgroundColor = .systemBackground
        title = "Popular Movies 🔥"
    }
    
    func configureCollectionView() {
        // collectionview scrollviewdan inherit ediyor, scrollview da uiviewden inherit ediyor.
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createHomeFlowLayout())
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false //storyboarda uğraşmamak için
        collectionView.delegate = self
        collectionView.dataSource = self // aşağıdaki protocollerin gerektirdiklerini saplamak için garantiilemek için self
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID) // cell e register olmak için
        
        
        collectionView.pinToEdgesOf(view: view)
        
   }
    func reloadCollectionView() {
        collectionView.reloadOnMainThread()

    }
    func navigateToDetailScreen(movie: MovieResult) {
        DispatchQueue.main.async {
            let detailScreen = DetailScreen(movie: movie)
            self.navigationController?.pushViewController(detailScreen, animated: true)
        }
    }
    
    
}

extension HomeScreen: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
        
        cell.setCell(movie: viewModel.movies[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { //tableviewde row -> collectionviewde item
        viewModel.getDetail(id: viewModel.movies[indexPath.item]._id)
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    // her an çağrılıyor performanlı dğeil yüzlerce çağrılıyo scroll yapınca
//    }
    
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//    }
    
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        //scrolllama durduğunda çağrılıyor daha performanslı
        let offsetY = scrollView.contentOffset.y //Y EKSENİNDE SCROLLADIĞIMIZ İÇİN. NE KADAR KAYDRIDIĞIMIZ TUTULACAK
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height //EKRANIN TAMAMI COLLECTİON VİEWİN KAPLADIĞI ALAN
        
        print("offsetY: \(offsetY)")
        print("contentHeight: \(contentHeight) ")
        print("height: \(height) ")
        print("")
        
        if offsetY >= contentHeight - (2 * height) {
            //print("GET MOVIES") // YÜZDE 80 LİK KSIMINDAYKEN HEPSİNİN BU ÇAĞIRILIYOR
            viewModel.getMovies()
        }

    }
    
}
