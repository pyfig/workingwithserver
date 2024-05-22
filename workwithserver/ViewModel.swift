//
//  ViewModel.swift
//  workwithserver
//
//  Created by user on 21.05.2024.
//

import Foundation
import Alamofire

struct AllPost: Decodable,Hashable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
struct OnePost: Codable,Hashable{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

