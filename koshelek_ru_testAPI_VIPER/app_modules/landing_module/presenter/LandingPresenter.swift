//
//  LandingPresenter.swift
//  koshelek_ru_testAPI_VIPER
//
//  Created by maksim on 06.11.2020.
//

import Foundation

final class LandingPresenter : ViewToLandingPresenterProtocol {
    
    var view: PresenterToLandingViewProtocol?
    var router: PresenterToLandingRouterProtocol?
    var interactor: PresenterToLandingInteractorProtocol?
    
    var from : From?
    
    func preparingData(){
        interactor?.startProcessing(from : from)
    }
    
    func stop(){
        interactor?.stopProcessing()
    }
    
    func selectQuotedCurrency(select : Int?){
        interactor?.selectDataProcessing(select : select)
    }
}

extension LandingPresenter : InteractorToLandingPresenterProtocol{
    
    func fromTabBarTransfer(from : From?, selectArray : [String]?){
        view?.fromTabBar(from : from, selectArray : selectArray)
    }
    func dataTransfer(response : LandingResponse?){
        view?.viewData(response : response)
    }
}
