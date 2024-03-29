//
//  ViewController.swift
//  MVVMTest
//
//  Created by Brandon Suarez on 2/9/24.
//

import UIKit

class ViewController: UIViewController {
    
    let label = UILabel()
    let table = UITableView(frame: .zero, style: .insetGrouped)
    let viewModel = ViewModel()
    var dataSource: [Model] = [] {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.table.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        addButton()
        
        viewModel.callBack = { [unowned self] newData in
            self.dataSource = newData
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchData()
    }


}

extension ViewController {
    func setupController() {
        title = "MVVM"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        setupLabel()
        setupTableView()
    }
    
    func setupLabel() {
        view.addSubview(label)
        
        label.text = "When creating a viewModel, the simplest way to pass the data back from the viewModel to the controller isn through a callback.\n\nA callBack is a closure in the viewModel where we pass the data when fetched."
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
    
    func addButton() {
        let action = UIAction { [unowned self] _ in
            self.navigationController?.pushViewController(SecondViewController(), animated: true)
        }
        let barButton = UIBarButtonItem(systemItem: .add, primaryAction: action)
        navigationItem.rightBarButtonItem = barButton
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
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
