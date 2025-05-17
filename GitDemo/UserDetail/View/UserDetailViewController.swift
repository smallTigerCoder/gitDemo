//
//  UserDetailViewController.swift
//  GitDemo
//
//  Created by echo on 2025/5/14.
//

import UIKit
import SnapKit

class UserDetailViewController: UIViewController {
    
    var userName: String?
    private var tableView = UITableView(frame: .zero, style: .plain)
    private var tableHeader = UserDetailHeader()
    private var viewModel = UserDetailViewModel()
    
    convenience init(userName: String) {
        self.init()
        self.userName = userName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        setUpHeaderView()
        bindViewModel()
        requestData()
    }
    
    private func setUpUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UserRepoCell.self, forCellReuseIdentifier: "userRepo")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top) // Use safeAreaLayoutGuide
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setUpHeaderView() {
        tableView.tableHeaderView = tableHeader
        tableHeader.translatesAutoresizingMaskIntoConstraints = false
        // Set header constraints
        tableHeader.snp.makeConstraints { make in
            make.width.equalTo(tableView.snp.width) // Header width equals TableView width
            make.top.equalToSuperview()
        }
        tableHeader.layoutIfNeeded() // Force layout before setting as header
        tableView.tableHeaderView = tableHeader
    }
    
    private func bindViewModel() {
        viewModel.didUpdateDetail = { [weak self] in
            DispatchQueue.main.async {
                guard let userDetail = self?.viewModel.userDetail else {
                    AlertManager.shared.showToast(message: "Failed to retrieve user details. Please try again later.")
                    return
                }
                self?.tableHeader.configureUI(with: userDetail)
            }
        }
        
        viewModel.didUpdateRepos = { [weak self] in
            DispatchQueue.main.async {
                guard (self?.viewModel.repos) != nil else {
                    AlertManager.shared.showToast(message: "Failed to retrieve user repos. Please try again later.")
                    return
                }
                self?.tableView.reloadData()
            }
        }
    }
    
    private func requestData() {
        viewModel.fetchUserDetails(with: userName ?? "")
        viewModel.fetchUserRepos(with: userName ?? "")
    }
}

extension UserDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "userRepo",
            for: indexPath
        ) as! UserRepoCell
        if let repo = viewModel.repos?[indexPath.row] {
            cell.configure(with: repo)
        }
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true) // Deselect row
        
        if let repo = viewModel.repos?[indexPath.row], let url = URL(string: repo.htmlURL) {
            UserDetailRouter
                .pushUserStorage(with: url, from: self)
        } else {
            AlertManager.shared.showToast(message: "Invalid repository URL")
        }
    }
}
