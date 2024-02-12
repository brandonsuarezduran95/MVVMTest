//
//  ViewModel.swift
//  MVVMTest
//
//  Created by Brandon Suarez on 2/9/24.
//

import Foundation

class ViewModel: NSObject {
    var dataSource: [Model] = []
    
    var callBack: (([Model]) -> Void)?
    
    func fetchData() {
        NetworkManager().fetchData { response in
            switch response {
            case .success(let data):
                DispatchQueue.global().async { [unowned self] in
                    self.dataSource = data
                    if let callBack = self.callBack {
                        callBack(data)
                    }
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
}
