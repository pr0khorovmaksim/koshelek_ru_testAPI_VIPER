//
//  TabBarRouter.swift
//  koshelek_ru_testAPI_VIPER
//
//  Created by maksim on 06.11.2020.
//

import Foundation
import UIKit

final class TabBarRouter{
    
    fileprivate static let constants : Constants = Constants()
    fileprivate var viewController : UIViewController
    
    typealias SubModules = (bid : UIViewController, ask : UIViewController, details : UIViewController)
    
    init(viewController : UIViewController) {
        self.viewController = viewController
    }
    
    static func createTabBarModule(submodules : TabBarRouter.SubModules) -> UITabBarController {
        
        let tabs = TabBarRouter.tabs(subModules: submodules)
        let tabBarConroller = TabBarController(tabs : tabs)
        
        return tabBarConroller
    }
}

extension TabBarRouter{
    
    static private func tabs(subModules : SubModules) -> Tabs{
        
        let bid = UIImage(named: constants.tabBarBidIcon)?.withRenderingMode(.alwaysTemplate)
        let ask = UIImage(named: constants.tabBarAskIcon)?.withRenderingMode(.alwaysTemplate)
        let details = UIImage(named: constants.tabBarDetailsIcon)?.withRenderingMode(.alwaysTemplate)
        
        let bidBarItem = UITabBarItem(title: constants.tabBarBidItem, image: bid, tag: 11)
        let askBarItem = UITabBarItem(title: constants.tabBarAskItem, image: ask, tag: 12)
        let detailsBarItem = UITabBarItem(title: constants.tabBarDetailsItem, image: details, tag: 13)
        
        subModules.bid.tabBarItem = bidBarItem
        subModules.ask.tabBarItem = askBarItem
        subModules.details.tabBarItem = detailsBarItem
        
        return (bid : subModules.bid, ask : subModules.ask, details : subModules.details)
    }
}
