//
//  LandingTableViewCell2.swift
//  koshelek_ru_testAPI_VIPER
//
//  Created by maksim on 08.11.2020.
//

import UIKit

final class LandingTableViewCell2: UITableViewCell {
    
    //MARK: - activityIndicator
    let activityIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        activityIndicator.alpha = 1
        activityIndicator.style = .large
        activityIndicator.color = .lightGray
        return activityIndicator
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //MARK: - activityIndicator
        contentView.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
