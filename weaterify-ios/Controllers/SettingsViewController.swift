//
//  SettingsViewController.swift
//  weaterify-ios
//
//  Created by Mirellys Arteta Davila on 30/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

final class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var versionLabel: UILabel!
    
    let disposeBag = DisposeBag()
    var items: [SettingsViewModel]?
    var pickerData = ["Farenheit", "Celcius"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            versionLabel.attributedText = version.styled(with: .lineHeightMultiple(1), .font(UIFont(name: "HelveticaNeue", size: CGFloat(16))!), .color(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)))
        }
        observeData()
        setupNavigation()
        setupTableView()
        setupData()
    }
    
    func setupNavigation() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9724436402, green: 0.972609818, blue: 0.9724331498, alpha: 1)
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icn-back"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(SettingsViewController.showSettingsViewController))
        navigationItem.title = "Settings"
    }
    
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundView = nil
        tableView.backgroundColor = UIColor.clear
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "SettingsCell")
        tableView.tableFooterView = UIView()
    }
    
    func setupData() {
        let location = SettingsViewModel(titleLabel: "Location", valueLabel: "")
        let temperature = SettingsViewModel(titleLabel: "Temperature", valueLabel: "")
        let forecastDays = SettingsViewModel(titleLabel: "Forecast Days", valueLabel: "")
        
        items = [location, temperature, forecastDays]
    }
    
    @objc func showSettingsViewController() {
        mainStore.dispatch(App.Actions.changeRoute(.dashboard))
    }
    
    func observeData() {
        mainStore.observable
            .asObservable()
            .map({ $0.location })
            .subscribe(onNext: { [unowned self] location in
                guard let location = location else { return }
                self.items?[0] = SettingsViewModel(titleLabel: "Location", valueLabel: location)
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        mainStore.observable
            .asObservable()
            .map({ $0.unitTemperature })
            .subscribe(onNext: { [unowned self] unit in
                self.items?[1] = SettingsViewModel(titleLabel: "Temperature", valueLabel: unit)
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        mainStore.observable
            .asObservable()
            .map({ $0.numberOfDaysForecast })
            .subscribe(onNext: { [unowned self] days in
                self.items?[2] = SettingsViewModel(titleLabel: "Forecast Days", valueLabel: "\(days)")
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        mainStore.dispatch(App.Actions.updateUnitTemperature(pickerData[row]))
        self.dismiss(animated: false, completion: nil)
    }
}

extension SettingsViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let elements = items else { return }
        (cell as? SettingsTableViewCell)?.configure(with: elements[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            mainStore.dispatch(App.Actions.insertCity(self))
        case 1:
            mainStore.dispatch(App.Actions.insertUnit(self))
        default:
            mainStore.dispatch(App.Actions.insertNumberDays(self))
        }
    }
}

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "SettingsCell")!
    }

}

