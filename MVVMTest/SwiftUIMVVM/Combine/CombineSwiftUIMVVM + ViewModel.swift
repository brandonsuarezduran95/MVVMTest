//
//  CombineSwiftUIMVVM + ViewModel.swift
//  MVVMTest
//
//  Created by Brandon Suarez on 2/13/24.
//

import Foundation

extension CombineSwiftUIMVVM {
    class ViewModel: ObservableObject {
        @Published private(set) var dataSource: [Model] = []
        
        func fetchData() {
            NetworkManager().fetchData { respond in
                switch respond {
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
