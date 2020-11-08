//
//  TabBarRouter.swift
//  koshelek_ru_testAPI_VIPER
//
//  Created by maksim on 06.11.2020.
//

import Foundation
import UIKit

final class TabBarRouter{
    
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
    
    static func tabs(subModules : SubModules) -> Tabs{
        
        let bid = UIImage(named: "plusIcon")?.withRenderingMode(.alwaysTemplate)
        let ask = UIImage(named: "minusIcon")?.withRenderingMode(.alwaysTemplate)
        let details = UIImage(named: "infoIcon")?.withRenderingMode(.alwaysTemplate)
        
        let bidBarItem = UITabBarItem(title: "Info: Bid", image: bid, tag: 11)
        let askBarItem = UITabBarItem(title: "Info: Ask", image: ask, tag: 12)
        let detailsBarItem = UITabBarItem(title: "Details", image: details, tag: 13)
        
        subModules.bid.tabBarItem = bidBarItem
        subModules.ask.tabBarItem = askBarItem
        subModules.details.tabBarItem = detailsBarItem
        
        return (bid : subModules.bid, ask : subModules.ask, details : subModules.details)
    }
}
