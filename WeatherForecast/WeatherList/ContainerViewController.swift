//
//  ContainerViewController.swift
//  WeatherForecast
//
//  Created by 小苹果 on 2023/10/19.
//

import UIKit
import WForecastUI
import WForecastComponents
import WForecastAPIClient
import ReactiveSwift
import Anchorage

class ContainerViewController: NiblessViewController {

    private struct Constants {
        static let navigationBarHeight: CGFloat = 100
        static let spacing: CGFloat = 16
        static let searchFieldHeight: CGFloat = 44
        static let vSpacing: CGFloat = 12
    }
    
    private var viewModel: ContainerViewModelType
    private var disposables = CompositeDisposable()
    
    private var dataSource = [WeatherInfoCellViewModel]()

    init(viewModel: ContainerViewModelType) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureViewModel()
    }
    
    func configureViews() {
        title = "Weather Forecast"
        view.backgroundColor = .white
        view.addSubview(searchField)
        view.addSubview(tableView)
        
        searchField.topAnchor == view.topAnchor + Constants.navigationBarHeight
        searchField.horizontalAnchors == view.horizontalAnchors + Constants.spacing
        searchField.heightAnchor == Constants.searchFieldHeight
        
        tableView.topAnchor == searchField.bottomAnchor + Constants.vSpacing
        tableView.horizontalAnchors == view.horizontalAnchors + Constants.spacing
        tableView.bottomAnchor == view.bottomAnchor
    }
    
    func configureViewModel() {
        disposables += viewModel.output.datasourceSignal
            .observe(on: UIScheduler())
            .observeValues { [weak self] data in
                self?.dataSource = data
                self?.tableView.reloadData()
            }
    }
    
    // MARK: - View
    
    lazy var searchField: UITextField = {
        let searchField = UITextField()
        searchField.delegate = self
        searchField.placeholder = " e.g Beijing"
        searchField.layer.borderColor = UIColor.lightGray.cgColor
        searchField.layer.borderWidth = 0.5
        searchField.layer.cornerRadius = 10
        return searchField
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WeatherThumbInfoCell.self)
        tableView.rowHeight = 120
        return tableView
    }()

}

extension ContainerViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
}

extension ContainerViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: WeatherThumbInfoCell.self, for: indexPath)
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        let cellViewModel = dataSource[indexPath.row]
        cell.configure(cellViewModel)
        return cell
    }
}

extension ContainerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellViewModel = dataSource[indexPath.row]
        viewModel.input.didSelect(cellViewModel)
    }
}
