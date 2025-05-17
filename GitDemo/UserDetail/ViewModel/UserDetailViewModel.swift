//
//  UserDetailViewModel.swift
//  GitDemo
//
//  Created by echo on 2025/5/15.
//

import Foundation

class UserDetailViewModel {
    var userDetail: UserDetailModel?
    var repos: [UserRepoModel]?
    var didUpdateDetail: (() -> Void)?
    var didUpdateRepos: (() -> Void)?
    
    // Fetches the user's detailed information.
    func fetchUserDetails(with userName: String) {
        let request = FetchUserDetailRequest(userName: userName)
        NetWorkManager.shared.send(request) { [weak self] result in
            switch result {
            case .success(let user):
                self?.userDetail = user
                self?.didUpdateDetail?()
            case .failure(let error):
                AlertManager.shared.showToast(message: "Failed to fetch user details: \(error)")
            }
        }
    }
    
    // Fetches the user's repositories.
    func fetchUserRepos(with userName: String) {
        let request = FetchUserReposRequest(userName: userName)
        NetWorkManager.shared.send(request) { [weak self] result in
            switch result {
            case .success(let repos):
                self?.repos = repos
                self?.didUpdateRepos?()
            case .failure(let error):
                AlertManager.shared.showToast(message: "Failed to fetch repositories: \(error)")
            }
        }
    }
    
    // Returns the user's repository URL at the specified index.
    func repo(at index: Int) -> String {
        guard let repo = repos?[index] else {
            AlertManager.shared.showToast(message: "Invalid repository URL")
            return ""
        }
        return repo.url
    }
}

