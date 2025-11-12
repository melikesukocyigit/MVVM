//
//  Movie.swift
//  MVVM-Example
//
//  Created by Melike Su KOÇYİĞİT on 1.11.2025.
//

//aşağıdakiler json formaterdaki değerlere göre adları tıpatıp yazıldı
//Modellerimiz struct oluyor reference type larla uğraşmayalım


// ben istek attığım zaman bana bir struct döndürecek bu bir movie struct içinde page,results vs vs bunlar var.resultuın içinde yebi struct var ve oranın içinde bir sürü değişlkeler var ama benim işime id ve poster_path lazım olduğu için ayrı structta yazdık.

// çok veri olduğunda jsonu kopyalayıp quicktypeio diye yazıp gittiğimizde tıklayıp jsonu verip yapıştırdığımızda bize tümünü swift şeklinde bize veriyor.

//  totalPages: camel case  total_pages: snake case CODİNGKEYS: tanımladığın değişkenin adı jsondakiyle örtüşmediğinde patlamaması için ör biz total_pages yerine totalPges yaparsak:

//enum CodingKeys: String,CodingKey {
//    case page
//    case result
//    case totalPages = "total_pages"
//    case totalResults = "total_results"
//}

struct Movie: Decodable { // gelen jsonu struct a çevirmek için decodable,gelen struct u jsona çevirmek için encodable protokolleri kullanılır.
    let results: [MovieResult]?
}

struct MovieResult: Decodable {
    let id: Int?
    let posterPath: String?
    let overview, releaseDate, title: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case overview, title
        case releaseDate = "release_date"
    }
    var _id: Int {
        id ?? Int.min
    }
    var _posterPath: String { //computed property. değişken değişken adı tipi süslü parantezler. optionallikten çıkardık
        posterPath ?? ""
    }
    
    var _title: String {
        title ?? "N/A"
    }
    var _releaseDate: String {
        releaseDate ?? "N/A"
    }
    var _overview: String {
        overview ?? "there is no overview"
    }
}
