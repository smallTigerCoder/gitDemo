//
//  UserListViewModel.swift
//  GitDemo
//
//  Created by echo on 2025/5/14.
//

import Foundation

// Represents the state when the list is refreshed.
enum RefreshType {
    case normal       // Initial load or direct refresh
    case pullDown     // Pull-down refresh
    case pullUp       // Pull-up load more
    case noMoreData   // No more data available
}

class UserListViewModel {
    private var users: [UserModel] = []
    
    // Closure to be called when the user data is updated.
    var didUpdate: ((_ refreshType: RefreshType) -> Void)?
    
    var since = 0
    private let perPage = 15
    
    // Fetches users from the data source.
    func fetchUsers(type: RefreshType) {
        let request = FetchUserListRequest(since: since, perpage: perPage)
        NetWorkManager.shared.send(request) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let users):
                if self.since == 1 {
                    self.users = users
                } else {
                    self.users.append(contentsOf: users)
                }
                
                users.count < self.perPage ? self.didUpdate?(.noMoreData) : self.didUpdate?(type)
                
            case .failure(let error):
                // When the request fails, decrement 'since' to prevent an infinite loop.
                self.since -= 1
                print("Failed to fetch users: \(error)")
                self.didUpdate?(type)
            }
        }
    }
    
    // Returns the user at the specified index.
    func user(at index: Int) -> UserModel {
        return users[index]
    }
    
    // Returns the number of users.
    var count: Int {
        return users.count
    }
}
