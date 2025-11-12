//
//  MovieService.swift
//  MVVM-Example
//
//  Created by Melike Su KOÇYİĞİT on 1.11.2025.
//

import Foundation
// bizim networkmanager ile iletişimde olacak şey benim servislerim olacak.

final class MovieService {
    
    func downloadMovies(page:Int , completion: @escaping ([MovieResult]?) -> ()) {
        guard let url = URL(string: APIURLs.movies(page: page)) else {return}
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            
            // networkmanagerdeki completion escapinngte hemen buras çağırılacak.
            // escapingler memory leak e sebep olduğu için biz weak self yapmalıyız.ramden silinmesini engelliyoruz.
            // böylece birbirini strong oalrak tutmuyor
            // weak self yaptığımzda self optional olur. bu optionalliği guard let oalrak çıakrtabiliriz elimizde var artık.
            
            
            switch result {
            case .success(let data):
                completion(self?.handleWithData(data))
            case .failure(let error):
                self?.handleWithError(error)
            }
        }
    }
    
    func downloadDetail(id: Int, completion: @escaping (MovieResult?) -> ()) {
            guard let url = URL(string: APIURLs.detail(id: id)) else { return }
            
            NetworkManager.shared.download(url: url) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let data):
                   completion( self.handleWithData(data))
                case .failure(let error):
                    self.handleWithError(error)
                }
            }
        }
    
    private func handleWithError(_ error: Error) { // dışarıya değişkeni kapatmak istiyosak _ koyarız
        print(error.localizedDescription)
    }
    
    private func handleWithData (_ data: Data) -> [MovieResult]? {
        do {
            // JSONDECODER ile ben gelen datayı decode ederek struct a çeviricem
            let movie = try JSONDecoder().decode(Movie.self, from: data) //movie ye ulaştık şu an
            return movie.results
        } catch {
            print(error)
            return nil
        }
    }
    
    //polymorphisim
    private func handleWithData(_ data: Data) -> MovieResult? {
        do {
            let movieDetail = try JSONDecoder().decode(MovieResult.self, from: data)
            return movieDetail
        } catch {
            print(error)
            return nil
        }
    }
}
