//
//  PokemonPresenter.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 17/12/22.
//

import Foundation

enum FetchError: Error {
    case failed
}

protocol TablePresenterProtocol: AnyObject {
    var view: TableViewProtocol? { get set }
    var interactor: TableInteractorProtocol? { get set }
    var router: TableRouterProtocol? { get set }

    func interactorDidFetchUsers(with result: Result<[User], Error>)
}

class TablePresenter: TablePresenterProtocol {
    weak var view: TableViewProtocol?
    var interactor: TableInteractorProtocol? {
        didSet {
            interactor?.getUsers()
        }
    }
    var router: TableRouterProtocol?

    func interactorDidFetchUsers(with result: Result<[User], Error>) {
        switch result {
        case .success(let users):
            view?.update(with: users)
        case.failure(let error):
            view?.update(with: error.localizedDescription)
        }
    }
}
