//
//  PokedexInteractor.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 17/12/22.
//

import Foundation

protocol TableInteractorProtocol: AnyObject {
    var presenter: TablePresenterProtocol? { get set }
    
    func getUsers()
}

class TableInteractor: TableInteractorProtocol {
    weak var presenter: TablePresenterProtocol?
        
    func getUsers() {
        print("Interactor getUsers")
        //Consumo de la API
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
                return
            }
            
            do {
                print("Success")
                let entities = try JSONDecoder().decode([User].self, from: data)
                self?.presenter?.interactorDidFetchUsers(with: .success(entities))
            } catch {
                print("Error")
                self?.presenter?.interactorDidFetchUsers(with: .failure(error))
            }
        }
        task.resume()
    }
}
