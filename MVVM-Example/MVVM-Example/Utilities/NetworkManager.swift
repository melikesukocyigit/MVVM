//
//  NetworkManager.swift
//  MVVM-Example
//
//  Created by Melike Su KOÇYİĞİT on 1.11.2025.
//

import Foundation

class NetworkManager {
    //singleton
    static let shared = NetworkManager()
    // initialize private olması gerek tek bir örnek olması için
    private init() {}
    
    @discardableResult // uyarı almamak için annotation warningler gidiyor
    func download(url:URL,completion: @escaping (Result<Data,Error>) -> ()) -> URLSessionDataTask {
        //datayı gönderirken escaping clousure kullanıcaz.çünkü istek attığı  zaman baştan aşağı satıra kadar çslışıcak. ama ben isteği atıyorum bana hemen istek gelemyebilir. bu closure tutuluyor diyor ki istek geldiği zaman ben çalışacağım. bu yüzden escaping kullanıcaz.
        
        // result -> enumaration, generic yapı, ilki succes tipi, 2. error tipi net olması lazım
        
       let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            //önce errore bakacak ondan geçerse response a bakacak geçerliyse, datayı çevireceğim.
            if let error = error { //error ü optionalden kurtardık.
                print(error.localizedDescription) // hatayı yazdırdık
                completion(.failure(error))
                return
            }
        // response un koduna bakacağım bu kod geçerli mi?
        // http 200: OK success
        
        // response a bakacağız ama ilk başta urlresponse da biz bu static koda ulaşamıyoruz yani 200 e . httpurlresponse a çevirmemiz gerek.
        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                //sana response geldi mi geldi, sne bunu httpurlresponse çevirdin mi çeviremediysen return e giriyo.çevirdiyse 200 mü 200 se çık 200 değilse yine return.yani her şey true ise else kısmına girmiyor
                
                completion(.failure(URLError(.badServerResponse)))  //bana gelen yanıt 200 değil. bu bir struct.
                return
            }
            
            //bana gelen datayı service kısmında değiştiricem
            guard let data = data else {
                completion(.failure(URLError(.badURL)))
                return
                
            }

            completion(.success(data))  //movieservisim çağrılcak completionda
        }
        dataTask.resume()
                
        return dataTask
    }
}
