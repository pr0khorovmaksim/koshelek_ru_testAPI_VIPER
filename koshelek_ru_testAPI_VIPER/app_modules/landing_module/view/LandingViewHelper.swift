//
//  LandingViewHelper.swift
//  koshelek_ru_testAPI_VIPER
//
//  Created by maksim on 06.11.2020.
//

import Foundation
import UIKit

extension LandingViewController{
    
    func setUpModule(){
        
        let att = NSMutableAttributedString(string: (selectWord)!)
        att.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range:  NSRange(location: 3, length: selectWord!.count - 3))
        dropdownOut.setAttributedTitle(att, for: .normal)
        //MARK: - view
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //MARK: - tableView
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.tableHeaderView = headerView
        
        //MARK: - headerView
        headerView.widthAnchor.constraint(equalTo: tableView.widthAnchor, multiplier: 1).isActive = true
        headerView.heightAnchor.constraint(equalTo: tableView.heightAnchor, multiplier: 0.2).isActive = true
        
        tableView.tableHeaderView?.layoutIfNeeded()
        
        // MARK: - dropdownOut
        headerView.addSubview(dropdownOut)
        
        dropdownOut.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.5).isActive = true
        dropdownOut.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.3).isActive = true
        
        dropdownOut.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        dropdownOut.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10).isActive = true
        
        //MARK: - stackView
        headerView.addSubview(stackView)
        stackView.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 1).isActive = true
        stackView.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.3).isActive = true
        
        stackView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0).isActive = true
        
        //MARK: - amountLabel & priceLabel & totalLabel
        stackView.addArrangedSubview(amountLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(totalLabel)
    }
    
}
