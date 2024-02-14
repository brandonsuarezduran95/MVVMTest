//
//  Model.swift
//  MVVMTest
//
//  Created by Brandon Suarez on 2/9/24.
//

import Foundation

struct Model: Codable, Identifiable , Hashable{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
