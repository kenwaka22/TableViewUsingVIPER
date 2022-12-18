//
//  PokedexView.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 17/12/22.
//

import UIKit

protocol TableViewProtocol: AnyObject {
    var presenter: TablePresenterProtocol? { get set }
    func update(with users: [User])
    func update(with error: String)
}

//MARK: - Properties
class TableView: UIViewController {
    
    var presenter: TablePresenterProtocol?
    var users: [User] = []
    
    private let tableView: UITableView = {
        let element = UITableView()
        element.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        element.isHidden = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let label: UILabel = {
        let element = UILabel()
        element.textAlignment = .center
        element.isHidden = true
        return element
    }()
}

//MARK: - LifeCycle
extension TableView {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(label)
        view.addSubview(tableView)
//        tableView.layout {
//            $0.top == view.safeAreaLayoutGuide.topAnchor
//            $0.bottom == view.safeAreaLayoutGuide.bottomAnchor
//            $0.trailing == view.trailingAnchor
//            $0.leading == view.leadingAnchor
//
//        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
    }
}

//MARK: - Delegate
extension TableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }

}

//MARK: - Protocol
extension TableView: TableViewProtocol {
    func update(with users: [User]) {
        DispatchQueue.main.async {
            self.users = users
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.users = []
            self.tableView.isHidden = true
            self.label.isHidden = false
            self.label.text = error
        }
    }

}
