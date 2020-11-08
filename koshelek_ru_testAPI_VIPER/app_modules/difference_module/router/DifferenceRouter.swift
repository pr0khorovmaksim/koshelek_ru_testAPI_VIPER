//
//  DifferenceRouter.swift
//  koshelek_ru_testAPI_VIPER
//
//  Created by maksim on 07.11.2020.
//

import Foundation

final class DifferenceRouter : PresenterToDifferenceRouterProtocol{
    
    static func createDifferenceModule() -> DifferenceViewController {
        
        let view = DifferenceViewController()
        
        let presenter : ViewToDifferencePresenterProtocol & InteractorToDifferencePresenterProtocol = DifferencePresenter()
        let interactor : PresenterToDifferenceInteractorProtocol = DifferenceInteractor()
        let router : PresenterToDifferenceRouterProtocol = DifferenceRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}
