//
//  CombineSwiftUIMVVM.swift
//  MVVMTest
//
//  Created by Brandon Suarez on 2/13/24.
//

import SwiftUI

struct CombineSwiftUIMVVM: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("To use combine with SwiftUI, have your ViewModel inherit from ObservableObject Protocol, have your dataSource wrapped with the @Publised property wrapper, and your viewModel instance on your View be wrapped with the @StateObject property wrapper")
                    .padding(17)
                
                List {
                    ForEach(viewModel.dataSource) { modelData in
                        Text(modelData.title)
                    }
                }
            }
            .navigationTitle("Combine MVVM")
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
}

#Preview {
    CombineSwiftUIMVVM()
}
