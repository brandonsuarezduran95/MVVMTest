//
//  SecondViewModel.swift
//  MVVMTest
//
//  Created by Brandon Suarez on 2/11/24.
//

import UIKit

class SecondViewModel: ObservableObject {
    @Published var dataSource: [Model] = []
    
    func fetchData() {
        NetworkManager().fetchData { result in
            switch result {
            case .success(let data):
                DispatchQueue.global().async { [unowned self] in
                    self.dataSource = data
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
}
