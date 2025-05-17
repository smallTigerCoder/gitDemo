//
//  RepoDetailViewController.swift
//  GitDemo
//
//  Created by echo on 2025/5/15.
//

import UIKit
import WebKit
import SnapKit

class RepoDetailViewController: UIViewController {

    private let webView = WKWebView()
    private let url: URL

    // Optional loading indicator
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return indicator
    }()

    // MARK: - Initialization

    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadWebView()
    }

    // MARK: - UI Setup

    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(webView)
        webView.navigationDelegate = self // Set delegate to monitor loading status
        view.addSubview(activityIndicator)

        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    // MARK: - Load Web View

    private func loadWebView() {
        let request = URLRequest(url: url)
        webView.load(request)
        activityIndicator.startAnimating()
    }

}

// MARK: - WKNavigationDelegate
extension RepoDetailViewController: WKNavigationDelegate {
    // Called when the webpage finishes loading
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        title = webView.title // Set the navigation bar title to the webpage title
    }

    // Called when the webpage fails to load
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        AlertManager.shared.showToast(message: "WebView failed to load with error: \(error)")
    }
}

