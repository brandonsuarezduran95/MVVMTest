//
//  SecondViewController.swift
//  MVVMTest
//
//  Created by Brandon Suarez on 2/11/24.
//

import UIKit
import Combine

class SecondViewController: UIViewController {
    
    let label = UILabel()
    let table = UITableView(frame: .zero, style: .insetGrouped)
    var dataSource: [Model] = [] {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.table.reloadData()
            }
        }
    }
    let viewModel = SecondViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        viewModel.$dataSource.sink { [unowned self] newData in
            self.dataSource = newData
        }.store(in: &cancellables)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchData()
    }
}

extension SecondViewController {
    func setupController() {
        title = "MVVM"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        setupLabel()
        setupTableView()
    }
    
    func setupLabel() {
        view.addSubview(label)
        
        label.text = "Another way to notify when the data is fetched from the viewModel, is by using the Combine framework, in this case, you mark your properties with the @Published and use the .sink() method to retrieve the data."
        label.numberOfLines = 7
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            label.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 17),
            label.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -17)
        ])
    }
    
    func setupTableView() {
        view.addSubview(table)
        
        table.delegate = self
        table.dataSource = self
        
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 12),
            table.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            table.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        
        var content = cell.defaultContentConfiguration()
        content.text = dataSource[indexPath.row].title
        
        cell.contentConfiguration = content
        
        return cell
    }
    
}
