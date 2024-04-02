//
//  VideoModel.swift
//  VideoPlayerSwiftUI
//
//  Created by Aziz Ahmed on 2024-04-01.
//

import Foundation

struct VideoModel : Decodable, Identifiable {

    let id : String
    let title : String
    let hlsURL: String
    let fullURL: String
    let description: String
    let publishedAt: String
    let author: Author
}

struct Author : Decodable {
    let id: String
    let name: String
    
}
