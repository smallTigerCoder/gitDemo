//
//  UserListViewController.swift
//  GitDemo
//
//  Created by echo on 2025/5/14.
//

import Foundation
import UIKit
import MJRefresh

class UserListViewController: UIViewController {
    
    // Lazy load the tableView
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.register(UserCell.self, forCellReuseIdentifier: "UserCell")
        return tableView
    }()
    
    private let viewModel = UserListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchUsers(type: .normal)
    }
    
    private func setupUI() {
        title = "GitHub Users"
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        // Pull up to load more users. If there is no more data, it will show "No Data"
        tableView.mj_footer = MJRefreshAutoNormalFooter(
            refreshingBlock: { [weak self] in
//                self?.viewModel.since += 1
                self?.viewModel.fetchUsers(type: .pullUp)
            }
        )
        // Pull down to refresh and get the first page of data
        tableView.mj_header = MJRefreshNormalHeader(
            refreshingBlock: { [weak self] in
                self?.viewModel.since = 0
                self?.viewModel.fetchUsers(type: .pullDown)
            }
        )
    }

    private func bindViewModel() {
        viewModel.didUpdate = { [weak self] type in
            DispatchQueue.main.async {
                if type == .pullUp {
                    self?.tableView.mj_footer?.endRefreshing()
                } else if type == .pullDown {
                    self?.tableView.mj_header?.endRefreshing()
                    self?.tableView.mj_footer?.resetNoMoreData()
                } else if type == .noMoreData {
                    self?.tableView.mj_footer?.endRefreshingWithNoMoreData()
                } else if type == .failure {
                    // Only end the refresh controls without reloading the data
                    self?.tableView.mj_footer?.endRefreshing()
                    self?.tableView.mj_header?.endRefreshing()
                    return
                }
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension UserListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = viewModel.user(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        cell.configure(with: user)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewModel.user(at: indexPath.row)
        UserListRouter.pushUserDetail(from: self, userName: user.login ?? "")
    }
}
