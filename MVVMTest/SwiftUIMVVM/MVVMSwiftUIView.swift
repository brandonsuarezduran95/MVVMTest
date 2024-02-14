//
//  MVVMSwiftUIView.swift
//  MVVMTest
//
//  Created by Brandon Suarez on 2/12/24.
//

import SwiftUI

struct MVVMSwiftUIView: View {
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading) {
                    Text("MVVM in SwiftUI, in this case, the ViewModel is created as an extension of the SwiftUI's view with the @Observable Macro.")
                        .padding([.leading, .trailing], 16)
                }
                
                List {
                    ForEach(viewModel.dataSource, id: \.self) { modelData in
                        Text(modelData.title)
                        
                    }
                }
            }
            .navigationTitle("SwiftUI + MVVM")
            .toolbar(content: {
                Button(action: {}, label: {
                    NavigationLink {
                        CombineSwiftUIMVVM()
                    } label: {
                        Image(systemName: "plus")
                    }

                })
            })
        }
        .task { // You can use .onAppear {...} or .task {... } both work similarly
            viewModel.fetchData()
        }
    }
}

#Preview {
    MVVMSwiftUIView()
}
