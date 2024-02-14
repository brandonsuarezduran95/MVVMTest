//
//  MVVMSwiftUIView + ViewModel.swift
//  MVVMTest
//
//  Created by Brandon Suarez on 2/13/24.
//

import Foundation

extension MVVMSwiftUIView {
    @Observable
    class ViewModel {
        private(set) var dataSource: [Model] = []
        
        func fetchData() {
            NetworkManager().fetchData { response in
                switch response {
                case .success(let data):
                    DispatchQueue.main.async { [unowned self] in
                        self.dataSource = data
                    }
                case .failure(let error):
                    print(error.rawValue)
                }
            }
        }
    }
}
