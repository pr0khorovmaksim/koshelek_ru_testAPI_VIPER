//
//  LandingViewController.swift
//  koshelek_ru_testAPI_VIPER
//
//  Created by maksim on 06.11.2020.
//

import UIKit
import Starscream

final class LandingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var presenter : ViewToLandingPresenterProtocol?
    
    fileprivate static let constants : Constants = Constants()
    fileprivate var response : LandingResponse? = nil
    fileprivate var from : From?
    fileprivate var toolBar : UIToolbar = UIToolbar()
    fileprivate var picker : UIPickerView = UIPickerView()
    fileprivate var selectArray : [String]? = []
    fileprivate var selectWord : String? = constants.selectWord
    
    //MARK: - tableView
    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(LandingTableViewCell.self, forCellReuseIdentifier: constants.cellValue)
        tableView.register(LandingTableViewCell2.self, forCellReuseIdentifier: constants.cellSecondValue)
        tableView.backgroundColor = .white
        return tableView
    }()
    
    //MARK: - headerView
    let headerView : UIView = {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .white
        return headerView
    }()
    
    //MARK: - dropdownOut
    let dropdownOut : UIButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isSelected = false
        button.addTarget(self, action: #selector(dropdown), for: .touchUpInside)
        let img = UIImage(named: constants.dropdownOutIcon)?.withRenderingMode(.alwaysTemplate)
        button.setImage(img, for: .normal )
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.tintColor = .lightGray
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        return button
    }()
    
    //MARK: - amountLabel
    let amountLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.text = constants.amountValue
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - priceLabel
    let priceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.text = constants.priceValue
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - totalLabel
    let totalLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.text = constants.totalValue
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - stackView
    let stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis  = .horizontal
        stackView.distribution  = .fillEqually
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpModule()
        setDropdownColorAttribute()
        addSwipes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.preparingData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        dropdownOut.layer.cornerRadius = dropdownOut.bounds.size.height / 5
        dropdownOut.layer.masksToBounds = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter?.stop()
        response = nil
        self.tableView.reloadData()
        if dropdownOut.isSelected == true{
            onDoneButtonTapped()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            switch from {
            case .bid:
                if response?.b?.count == nil{
                    return 0
                }else{
                    return response?.b?.count ?? 0
                }
            case .ask:
                if response?.a?.count == nil{
                    return 0
                }else{
                    return response?.a?.count ?? 0
                }
            default:
                return 0
            }
        case 1:
            switch from {
            case .bid:
                if response?.b?.count == nil || response?.b?.count == 0{
                    return 1
                    
                }else{
                    return 0
                }
            case .ask:
                if response?.a?.count == nil || response?.a?.count == 0{
                    return 1
                    
                }else{
                    return 0
                }
            default:
                return 0
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .none
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: LandingViewController.constants.cellValue, for: indexPath) as! LandingTableViewCell
            
            cell.selectedBackgroundView = backgroundView
            
            switch from {
            case .bid:
                cell.priceLabel.textColor = #colorLiteral(red: 0.1921568627, green: 0.7843137255, blue: 0.1921568627, alpha: 1)
            case .ask:
                cell.priceLabel.textColor = #colorLiteral(red: 0.7843137255, green: 0.1921568627, blue: 0.1921568627, alpha: 1)
            default:
                return UITableViewCell()
            }
            
            if indexPath.row % 2 == 0{
                cell.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else{
                cell.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
            }
            
            configureCell(cell: cell, for: indexPath)
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: LandingViewController.constants.cellSecondValue, for: indexPath) as! LandingTableViewCell2
            
            cell.selectedBackgroundView = backgroundView
            cell.backgroundColor = .white
            
            configureCell(cell: cell, for : indexPath)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    private func configureCell(cell: LandingTableViewCell, for indexPath: IndexPath) {
        
        switch from {
        case .bid:
            cell.priceLabel.text = String(response?.b?[indexPath.row][0] ?? 0)  // Price
            cell.amountLabel.text = String(response?.b?[indexPath.row][1] ?? 0) // Quantity (Amount)
            cell.totalLabel.text = String(response?.b?[indexPath.row][2] ?? 0)  // Total
        case .ask:
            cell.priceLabel.text = String(response?.a?[indexPath.row][0] ?? 0)  // Price
            cell.amountLabel.text = String(response?.a?[indexPath.row][1] ?? 0) // Quantity (Amount)
            cell.totalLabel.text = String(response?.a?[indexPath.row][2] ?? 0)  // Total
        default:
            return
        }
    }
    
    private func configureCell(cell: LandingTableViewCell2, for indexPath: IndexPath) {
        
        cell.activityIndicator.startAnimating()
        cell.activityIndicator.alpha = 1
        
        switch from {
        case .bid:
            if response?.b?.count == nil{
                cell.activityIndicator.startAnimating()
                cell.activityIndicator.alpha = 1
            }else{
                cell.activityIndicator.stopAnimating()
                cell.activityIndicator.alpha = 0
            }
        case .ask:
            if response?.a?.count == nil{
                cell.activityIndicator.startAnimating()
                cell.activityIndicator.alpha = 1
            }else{
                cell.activityIndicator.stopAnimating()
                cell.activityIndicator.alpha = 0
            }
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        let heightRatio = UIScreen.main.bounds.height / 800
        return 80 * heightRatio
    }
    
    @objc private func dropdown(){
        
        dropdownOut.isEnabled = false
        dropdownOut.isSelected = true
        picker = UIPickerView.init()
        picker.delegate = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        view.addSubview(picker)
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barTintColor = #colorLiteral(red: 0.8078431373, green: 0.8078431373, blue: 0.8078431373, alpha: 1)
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
        
        let item = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))
        toolBar.items = [item]
        view.addSubview(toolBar)
    }
    
    @objc private func onDoneButtonTapped() {
        
        dropdownOut.isEnabled = true
        dropdownOut.isSelected = false
        dismiss(animated: true, completion: nil)
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
    private func setDropdownColorAttribute(){
        
        let att = NSMutableAttributedString(string: (selectWord)!)
        att.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range:  NSRange(location: 3, length: selectWord!.count - 3))
        dropdownOut.setAttributedTitle(att, for: .normal)
    }
    
    private func addSwipes(){
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        rightSwipe.direction = .right
        leftSwipe.direction = .left
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(leftSwipe)
    }
    
    @objc private func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        
        if sender.direction == .left {
            tabBarController!.selectedIndex += 1
        }
        if sender.direction == .right {
            tabBarController!.selectedIndex -= 1
        }
    }
    
}

extension LandingViewController : PresenterToLandingViewProtocol{
    
    func fromTabBar(from : From?, selectArray : [String]?){
        
        self.selectArray = selectArray
        
        switch from {
        case .bid:
            self.from = .bid
            tabBarController?.tabBar.tintColor =  #colorLiteral(red: 0.1921568627, green: 0.7843137255, blue: 0.1921568627, alpha: 1)
        case .ask:
            self.from = .ask
            tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.7843137255, green: 0.1921568627, blue: 0.1921568627, alpha: 1)
        default:
            return
        }
    }
    
    func viewData(response: LandingResponse?) {
        
        DispatchQueue.global().async {
            self.response = response
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension LandingViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return selectArray!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return selectArray?[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectWord = selectArray?[row]
        presenter?.selectQuotedCurrency(select : row)
        
        DispatchQueue.global().async { [self] in
            let str = selectWord
            let delimiter = " / "
            let newStr = str?.components(separatedBy: delimiter)
            let att = NSMutableAttributedString(string: (selectWord)!)
            att.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range:  NSRange(location: 3, length: selectWord!.count - 3))
            
            DispatchQueue.main.async {
                amountLabel.text = "Amount \(newStr![0])"
                priceLabel.text = "Price \(newStr![1])"
                dropdownOut.setAttributedTitle(att, for: .normal)
            }
        }
    }
}

final class CustomButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard imageView != nil else { return }
        
        let imageSize = imageView!.frame.height / 1.2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: (bounds.width - imageSize), bottom: 0, right: 10)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: -60, bottom: 0, right: -imageView!.frame.width + imageSize + 10)
        imageView!.contentMode = .scaleAspectFill
        imageView!.layer.cornerRadius = imageView!.bounds.size.height / 2.0
        imageView!.layer.masksToBounds = true
    }
}
