//
//  DifferenceViewController.swift
//  koshelek_ru_testAPI_VIPER
//
//  Created by maksim on 07.11.2020.
//

import UIKit

final class DifferenceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - tableView
    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DifferenceTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(DifferenceTableViewCell2.self, forCellReuseIdentifier: "Cell2")
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
        let img = UIImage(named: "arrowIcon")?.withRenderingMode(.alwaysTemplate)
        button.setImage(img, for: .normal )
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.tintColor = .lightGray
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        return button
    }()
    
    //MARK: - bidPriceLabel
    let bidPriceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.text = "Bid price"
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - diffBidLabel
    let diffBidLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.text = "DIFF"
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - askPriceLabel
    let askPriceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.text = "Ask price"
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - diffAskLabel
    let diffAskLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.text = "DIFF"
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - timeLabel
    let timeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 1
        label.font = UIFont(name: "Futura", size: 14)
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
    
    var presenter : ViewToDifferencePresenterProtocol?
    fileprivate var response: DifferenceResponse?
    fileprivate var toolBar = UIToolbar()
    fileprivate var picker  = UIPickerView()
    fileprivate var selectArray : [String]? = []
    var selectWord : String? = "BTC / USDT"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.startTimer()
        setUpModule()
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
    }
    
    @objc private func handleSwipes(_ sender : UISwipeGestureRecognizer) {
        if sender.direction == .right {
            tabBarController!.selectedIndex -= 1
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.preparingData()
        tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.1921568627, green: 0.1921568627, blue: 0.7843137255, alpha: 1)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter?.stop()
        response = nil
        tableView.reloadData()
        if dropdownOut.isSelected == true{
            onDoneButtonTapped()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.layoutIfNeeded()
        
        dropdownOut.layer.cornerRadius = dropdownOut.bounds.size.height / 5
        dropdownOut.layer.masksToBounds = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            if response?.a?.count == nil && response?.b?.count == nil{
                return 0
            }else{
                if response?.a?.count ?? 0 > response?.b?.count ?? 0{
                    return response?.a?.count ?? 0
                }else{
                    return response?.b?.count ?? 0
                }
            }
        case 1:
            if response?.a?.count == nil || response?.a?.count == 0
                || response?.b?.count == nil || response?.b?.count == 0{
                return 1
            }else{
                return 0
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DifferenceTableViewCell
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .none
            cell.selectedBackgroundView = backgroundView
            
            cell.bidPriceLabel.textColor = #colorLiteral(red: 0.1921568627, green: 0.7843137255, blue: 0.1921568627, alpha: 1)
            cell.askPriceLabel.textColor = #colorLiteral(red: 0.7843137255, green: 0.1921568627, blue: 0.1921568627, alpha: 1)
            
            if indexPath.row % 2 == 0{
                cell.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else{
                cell.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
            }
            configureCell(cell: cell, for: indexPath)
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! DifferenceTableViewCell2
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .none
            cell.selectedBackgroundView = backgroundView
            
            cell.backgroundColor = .white
            configureCell(cell: cell, for : indexPath)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    private func configureCell(cell: DifferenceTableViewCell, for indexPath: IndexPath) {
        
        if response?.b?.count ?? 0 > indexPath.row{
            cell.bidPriceLabel.text = String(response?.b?[indexPath.row][0] ?? 0)
            cell.diffBidLabel.text = String(response?.b?[indexPath.row][1] ?? 0)
        }else{
            cell.bidPriceLabel.text = ""
            cell.diffBidLabel.text = ""
        }
        
        if response?.a?.count ?? 0 > indexPath.row{
            cell.askPriceLabel.text = String(response?.a?[indexPath.row][0] ?? 0)
            cell.diffAskLabel.text = String(response?.a?[indexPath.row][1] ?? 0)
        }else{
            cell.askPriceLabel.text = ""
            cell.diffAskLabel.text = ""
        }
    }
    
    private func configureCell(cell: DifferenceTableViewCell2, for indexPath: IndexPath) {
        cell.activityIndicator.startAnimating()
        cell.activityIndicator.alpha = 1
        
        if response?.a?.count == nil || response?.a?.count == 0
            || response?.b?.count == nil || response?.b?.count == 0{
            cell.activityIndicator.startAnimating()
            cell.activityIndicator.alpha = 1
        }else{
            cell.activityIndicator.stopAnimating()
            cell.activityIndicator.alpha = 0
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
}

extension DifferenceViewController : PresenterToDifferenceViewProtocol{
    
    func viewDataForButton(selectArray : [String]?){
        self.selectArray = selectArray
    }
    
    func viewData(response: DifferenceResponse?) {
        
        DispatchQueue.global().async {
            self.response = response
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func viewTimer(timer : String?){
        
        let attTime = NSMutableAttributedString(string: (timer)!)
        attTime.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range:  NSRange(location: 16, length: timer!.count - 16))
        timeLabel.attributedText = attTime
    }
}

extension DifferenceViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
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
        let att = NSMutableAttributedString(string: (selectWord)!)
        att.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range:  NSRange(location: 3, length: selectWord!.count - 3))
        dropdownOut.setAttributedTitle(att, for: .normal)
    }
}
