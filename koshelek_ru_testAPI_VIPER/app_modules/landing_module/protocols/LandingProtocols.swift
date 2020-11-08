//
//  LandingProtocols.swift
//  koshelek_ru_testAPI_VIPER
//
//  Created by maksim on 06.11.2020.
//

import Foundation
import UIKit

protocol ViewToLandingPresenterProtocol : class{
    
    var view : PresenterToLandingViewProtocol? { get set }
    var router : PresenterToLandingRouterProtocol? { get set }
    var interactor : PresenterToLandingInteractorProtocol? { get set }
    
    var from : From? { get set }
    
    func preparingData()
    func stop()
    func selectQuotedCurrency(select : Int?)
}

protocol PresenterToLandingViewProtocol : class{
    
    func fromTabBar(from : From?, selectArray : [String]?)
    func viewData(response : LandingResponse?)
}

protocol PresenterToLandingRouterProtocol : class{
    
    static func createLandingModule(from : From?) -> LandingViewController
    
}

protocol PresenterToLandingInteractorProtocol : class{
    
    var presenter : InteractorToLandingPresenterProtocol? { get set }
    
    func startProcessing(from : From?)
    func stopProcessing()
    func selectDataProcessing(select : Int?)
}

protocol InteractorToLandingPresenterProtocol : class{
    
    func fromTabBarTransfer(from : From?, selectArray : [String]?)
    func dataTransfer(response : LandingResponse?)
}
