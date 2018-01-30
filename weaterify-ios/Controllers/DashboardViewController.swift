//
//  ViewController.swift
//  weaterify-ios
//
//  Created by Mirellys on 24/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import UIKit
import RxSwift

final class DashboardViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    var items: Forecast?
    var unit: String?
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigation()
        setupTableView()
        setupRefreshControl()
        observeData()
    }
    
    func setupNavigation() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1275623441, green: 0.5841561556, blue: 0.9495651126, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layer.zPosition = -1;
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icn-info"), style: .plain, target: self, action: #selector(DashboardViewController.showInformationDetails))
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icn-settings"), style: .plain, target: self, action: #selector(DashboardViewController.showSettings))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundView = nil
        tableView.backgroundColor = UIColor.clear
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.register(TodayForecastTableViewCell.self, forCellReuseIdentifier: "TodayItemCell")
        tableView.register(DailyForecastTableViewCell.self, forCellReuseIdentifier: "ItemCell")
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
    }
    
    func setupRefreshControl() {
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = #colorLiteral(red: 0.4352941176, green: 0.4431372549, blue: 0.4745098039, alpha: 1)
    }
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        mainStore.dispatch(App.Actions.reloadData)
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    @objc func showInformationDetails() {
        mainStore.dispatch(App.Actions.changeRoute(.information))
    }
    
    @objc func showSettings() {
        mainStore.dispatch(App.Actions.changeRoute(.settings))
    }
    
    func observeData() {
        mainStore.observable
            .asObservable()
            .map({ $0.forecast })
            .subscribe(onNext: { [unowned self] forecast in
                guard let forecast = forecast else { return }
                self.items = forecast
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        mainStore.observable
            .asObservable()
            .map({ $0.unitTemperature })
            .subscribe(onNext: { [unowned self] unitTemperature in
                self.unit = unitTemperature
            })
            .disposed(by: disposeBag)
    }

    
}

extension DashboardViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            if UIDevice.current.orientation.isPortrait {
                return view.bounds.height*0.4
            }
            else {
                return view.bounds.height*0.8
            }
        }
        else {
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = items else { return 0 }
        return items.cnt-1
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let elements = items else { return }
        if indexPath.row == 0 {
            let viewModel = TodayForecastViewModel(data: elements, unit: unit)
            (cell as? TodayForecastTableViewCell)?.configure(with: viewModel)
        }
        else {
            let viewModel = DailyForecastViewModel(forecast: elements.list[indexPath.row+1])
            (cell as? DailyForecastTableViewCell)?.configure(with: viewModel)
        }
    }
    
    
}

extension DashboardViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return tableView.dequeueReusableCell(withIdentifier: "TodayItemCell")!
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "ItemCell")!
        }
    }
    
    
}
