//
//  DifferencePresenter.swift
//  koshelek_ru_testAPI_VIPER
//
//  Created by maksim on 07.11.2020.
//

import Foundation

final class DifferencePresenter : ViewToDifferencePresenterProtocol{
    
    var view: PresenterToDifferenceViewProtocol?
    var router: PresenterToDifferenceRouterProtocol?
    var interactor: PresenterToDifferenceInteractorProtocol?
    
    
    func preparingData(){
        interactor?.startProcessing()
    }
    
    func startTimer(){
        interactor?.timerProcessing()
    }
    
    func stop(){
        interactor?.stopProcessing()
    }
    
    func selectQuotedCurrency(select : Int?){
        interactor?.selectDataProcessing(select : select)
    }
}

extension DifferencePresenter : InteractorToDifferencePresenterProtocol{
    
    func dataForButtonTransfer(selectArray : [String]?){
        view?.viewDataForButton(selectArray : selectArray)
    }
    
    func dataTransfer(response : DifferenceResponse?){
        view?.viewData(response : response)
    }
    
    func timerTransfer(timer : String?){
        view?.viewTimer(timer : timer)
    }
}
