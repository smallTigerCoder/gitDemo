//
//  UserRepoModel.swift
//  GitDemo
//
//  Created by echo on 2025/5/15.
//

import Foundation

struct UserRepoModel: Codable {
    let id: Int
    let nodeID: String
    let name: String
    let fullName: String
    let isPrivate: Bool
    let owner: Owner
    let htmlURL: String
    let description: String?
    let fork: Bool
    let url: String
    let createdAt: String
    let updatedAt: String
    let pushedAt: String
    let gitURL: String
    let sshURL: String
    let cloneURL: String
    let svnURL: String
    let homepage: String?
    let size: Int
    let stargazersCount: Int
    let watchersCount: Int
    let language: String?
    let hasIssues: Bool
    let hasProjects: Bool
    let hasDownloads: Bool
    let hasWiki: Bool
    let hasPages: Bool
    let hasDiscussions: Bool
    let forksCount: Int
    let archived: Bool
    let disabled: Bool
    let openIssuesCount: Int
    let license: License?
    let allowForking: Bool
    let isTemplate: Bool
    let webCommitSignoffRequired: Bool
    let topics: [String]
    let visibility: String
    let forks: Int
    let openIssues: Int
    let watchers: Int
    let defaultBranch: String

    enum CodingKeys: String, CodingKey {
        case id, name, fork, url, size, license, topics, forks, watchers, description, homepage, language
        case nodeID = "node_id"
        case fullName = "full_name"
        case isPrivate = "private"
        case owner
        case htmlURL = "html_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case gitURL = "git_url"
        case sshURL = "ssh_url"
        case cloneURL = "clone_url"
        case svnURL = "svn_url"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case hasIssues = "has_issues"
        case hasProjects = "has_projects"
        case hasDownloads = "has_downloads"
        case hasWiki = "has_wiki"
        case hasPages = "has_pages"
        case hasDiscussions = "has_discussions"
        case forksCount = "forks_count"
        case archived, disabled
        case openIssuesCount = "open_issues_count"
        case allowForking = "allow_forking"
        case isTemplate = "is_template"
        case webCommitSignoffRequired = "web_commit_signoff_required"
        case visibility
        case openIssues = "open_issues"
        case defaultBranch = "default_branch"
    }
}

struct Owner: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let gravatarID: String
    let url: String
    let htmlURL: String
    let followersURL: String
    let followingURL: String
    let gistsURL: String
    let starredURL: String
    let subscriptionsURL: String
    let organizationsURL: String
    let reposURL: String
    let eventsURL: String
    let receivedEventsURL: String
    let type: String
    let userViewType: String?
    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login, id, url, type
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case userViewType = "user_view_type"
        case siteAdmin = "site_admin"
    }
}

struct License: Codable {
    let key: String
    let name: String
    let spdxID: String
    let url: String?
    let nodeID: String

    enum CodingKeys: String, CodingKey {
        case key, name, url
        case spdxID = "spdx_id"
        case nodeID = "node_id"
    }
}
