//
//  PokedexRoute.swift
//  PokemonApp
//
//  Created by Ken Wakabayashi on 17/12/22.
//

import Foundation
import UIKit

typealias EntryPoint = TableViewProtocol & UIViewController

protocol TableRouterProtocol: AnyObject {
    var entry: EntryPoint? { get }
    static func start() -> TableRouterProtocol
}

class TableRouter: TableRouterProtocol {
    var entry: EntryPoint?
    
    static func start() -> TableRouterProtocol {
        let router = TableRouter()
        
        //VIP
        let view: TableViewProtocol = TableView()
        let presenter: TablePresenterProtocol = TablePresenter()
        let interactor: TableInteractorProtocol = TableInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        
        router.entry = view as? EntryPoint
        
        return router
    }
}
