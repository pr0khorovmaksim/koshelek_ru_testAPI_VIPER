//
//  DifferenceProtocols.swift
//  koshelek_ru_testAPI_VIPER
//
//  Created by maksim on 07.11.2020.
//

import Foundation
import UIKit

protocol ViewToDifferencePresenterProtocol : class{
    
    var view : PresenterToDifferenceViewProtocol? { get set }
    var router : PresenterToDifferenceRouterProtocol? { get set }
    var interactor : PresenterToDifferenceInteractorProtocol? { get set }
    
    func preparingData()
    func startTimer()
    func stop()
    func selectQuotedCurrency(select : Int?)
}

protocol PresenterToDifferenceViewProtocol : class{
    
    func viewDataForButton(selectArray : [String]?)
    func viewData(response: DifferenceResponse?)
    func viewTimer(timer : String?)
}

protocol PresenterToDifferenceRouterProtocol : class{
    
    static func createDifferenceModule() -> DifferenceViewController
    
}

protocol PresenterToDifferenceInteractorProtocol : class{
    
    var presenter : InteractorToDifferencePresenterProtocol? { get set }
    
    func startProcessing()
    func timerProcessing()
    func stopProcessing()
    func selectDataProcessing(select : Int?)
}

protocol InteractorToDifferencePresenterProtocol : class{
    
    func dataForButtonTransfer(selectArray : [String]?)
    func dataTransfer(response : DifferenceResponse?)
    func timerTransfer(timer : String?)
}
