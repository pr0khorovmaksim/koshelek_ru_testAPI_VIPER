//
//  LandingRouter.swift
//  koshelek_ru_testAPI_VIPER
//
//  Created by maksim on 06.11.2020.
//

import Foundation

final class LandingRouter : PresenterToLandingRouterProtocol {
    
    static func createLandingModule(from : From?) -> LandingViewController {
        
        let view = LandingViewController()
        
        let presenter : ViewToLandingPresenterProtocol & InteractorToLandingPresenterProtocol = LandingPresenter()
        let interactor : PresenterToLandingInteractorProtocol = LandingInteractor()
        let router : PresenterToLandingRouterProtocol = LandingRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        presenter.from = from
        
        return view
    }
}
