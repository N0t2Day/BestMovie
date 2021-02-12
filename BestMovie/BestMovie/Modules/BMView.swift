//
//  BMView.swift
//  BestMovie
//
//  Created by Artem Kedrov on 12.02.2021.
//

import UIKit

private let cellSpacing: CGFloat = 0.0

class BMView: BaseViewController {
  override var step: Flow { .movieList }
  var presenter: BMPresenter?
  private var refresher: UIRefreshControl?
  
  @IBOutlet private var cvBMList: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.viewDidLoad()
  }
  
  override func setup() {
    cvBMList.delegate = self
    cvBMList.dataSource = self
    cvBMList.contentInsetAdjustmentBehavior = .always
    cvBMList.registerCellXib(type: PosterTableCell.self)
    cvBMList.alwaysBounceVertical = true
    createRefresher()
  }
  
  func performSetupCell(_ cell: PosterTableCell, at indexPath: IndexPath) -> UITableViewCell {
    presenter?.setupTable(cell, at: indexPath)
    return cell
  }
}

extension BMView: BaseView {
  func visibleIndexPaths() -> [IndexPath] {
    cvBMList.indexPathsForVisibleRows ?? []
  }
  
  func reload(at indexPath: [IndexPath]) {
    cvBMList.reloadRows(at: indexPath, with: .automatic)
  }
  
  func reloadList() {
    cvBMList.reloadData()
  }
  
  func isDragging() -> Bool {
    cvBMList.isDragging
  }
  
  func isDecelerating() -> Bool {
    cvBMList.isDecelerating
  }
}

extension BMView: UICollectionViewDelegate {

}

extension BMView {
  @objc func performUpdateData() {
    presenter?.reload()
  }
  
  func createRefresher() {
    refresher = UIRefreshControl()
    refresher?.tintColor = UIColor(named: "DeepGrayBlueItemColor")
    refresher?.addTarget(self, action: #selector(performUpdateData), for: .valueChanged)
    cvBMList.refreshControl = refresher
  }
}

extension BMView: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    (presenter?.sections()).zero
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    (presenter?.rows(in: section)).zero
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    performSetupCell(tableView.dequeCell(at: indexPath), at: indexPath)
  }
}

extension BMView: UITableViewDelegate {
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let cell = cell as? PosterTableCell else { return }
    presenter?.willDisplayTable(cell, at: indexPath)
  }
}
