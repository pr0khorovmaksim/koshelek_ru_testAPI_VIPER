//
//  TabBarController.swift
//  koshelek_ru_testAPI_VIPER
//
//  Created by maksim on 06.11.2020.
//

import Foundation
import UIKit

typealias Tabs = (
    bid : UIViewController,
    ask : UIViewController,
    details : UIViewController
)

final class TabBarController: UITabBarController {
    
    init(tabs : Tabs) {
        super.init(nibName: nil, bundle: nil)
        viewControllers = [tabs.bid, tabs.ask, tabs.details]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        tabBar.barTintColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.title = "Test Application"
        tabBar.isTranslucent = false
    }
}
