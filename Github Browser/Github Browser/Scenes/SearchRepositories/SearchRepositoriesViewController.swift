//
//  SearchRepositoriesViewController.swift
//  Github Browser
//
//  Created by Gustavo Severo on 12/10/18.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//

import UIKit

protocol SearchRepositoriesDisplayLogic: class {
    func displayFetchedRepositories(viewModel: SearchRepositories.FetchRepositories.ViewModel)
    func displayFetchedRepositoriesError(viewModel: SearchRepositories.FetchRepositories.ViewModel, isEmpty: Bool)
    func showLoadingView()
    func hideLoadingView()
}

class SearchRepositoriesViewController: UITableViewController, SearchRepositoriesDisplayLogic {
    var interactor: SearchRepositoriesBusinessLogic?
    var router: (NSObjectProtocol & SearchRepositoriesRoutingLogic & SearchRepositoriesDataPassing)?
    
    // MARK: Nib Identifiers
    
    let searchRepositoriesCell = UINib(nibName: "SearchRepositoriesTableViewCell", bundle: nil)
    let emptyCell = UINib(nibName: "EmptyTableViewCell", bundle: nil)
    
    // MARK: Data variables
    
    var displayedRepositories: [SearchRepositories.FetchRepositories.ViewModel.DisplayedRepository] = []
    
    // MARK: Infinite Fetch Variables
    
    var currentSearchText = ""
    var currentPage: Int = 1
    var isFetching = false
    
    // MARK: Search Bar
    
    var searchBar: UISearchBar!
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = SearchRepositoriesInteractor()
        let presenter = SearchRepositoriesPresenter()
        let router = SearchRepositoriesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetupOnLoad()
        registerNibsOnLoad()
        setupSearchBar()
    }
    
    // MARK: Display Methods
    
    func displayFetchedRepositories(viewModel: SearchRepositories.FetchRepositories.ViewModel){
        isFetching = false
        displayedRepositories = viewModel.displayedRepositories
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    func displayFetchedRepositoriesError(viewModel: SearchRepositories.FetchRepositories.ViewModel, isEmpty: Bool){
        isFetching = false
        displayedRepositories = []
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        
        if !isEmpty {
            let alertController = UIAlertController(title: viewModel.displayedError?.title, message: viewModel.displayedError?.message, buttonText: viewModel.displayedError?.buttonText ?? "OK".localized)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: Fetch Methods
    
    func fetchRepositoriesOnLoad(){
        isFetching = true
        let request = SearchRepositories.FetchRepositories.Request(language: currentSearchText, page: currentPage)
        interactor?.fetchRepositories(request: request, shouldRefresh: false)
    }
    
    func fetchRepositoriesOnScroll(){
        isFetching = true
        currentPage += 1
        let request = SearchRepositories.FetchRepositories.Request(language: currentSearchText, page: currentPage)
        interactor?.fetchRepositories(request: request, shouldRefresh: false)
    }
    
    func fetchRepositoriesOnSearch(){
        isFetching = true
        currentPage = 1
        let request = SearchRepositories.FetchRepositories.Request(language: currentSearchText, page: currentPage)
        interactor?.fetchRepositories(request: request, shouldRefresh: true)
    }
}

// MARK: Table View Setup

extension SearchRepositoriesViewController {
    
    func tableViewSetupOnLoad(){
        tableView.tableFooterView = UIView()
    }
    
    func registerNibsOnLoad(){
        tableView.register(searchRepositoriesCell, forCellReuseIdentifier: "SearchRepositoriesTableViewCell")
        tableView.register(emptyCell, forCellReuseIdentifier: "EmptyTableViewCell")
    }
}

// MARK: Table View Delegate and Data Source

extension SearchRepositoriesViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (displayedRepositories.count == 0) ? 1 : displayedRepositories.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return searchBar
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if displayedRepositories.count > 0 {
            let displayedRepository = displayedRepositories[indexPath.row]
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchRepositoriesTableViewCell") as? SearchRepositoriesTableViewCell {
                cell.titleLabel.text = displayedRepository.title
                cell.descriptionLabel.text = displayedRepository.description
                cell.starCountLabel.text = displayedRepository.starsCount
                cell.forkCountLabel.text = displayedRepository.forksCount
                cell.setTitleLabel(str: displayedRepository.authorName)
                cell.setImage(with: displayedRepository.authorImageURL)
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell") as? EmptyTableViewCell {
                cell.titleLabel.text = "😔"
                cell.messageLabel.text = "We could not found any repository for the selected language.".localized
                return cell
            }
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == displayedRepositories.count - 1 {
            if !isFetching {
                fetchRepositoriesOnScroll()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToDetailRepository()
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

extension SearchRepositoriesViewController: UISearchBarDelegate {
    
    func setupSearchBar(){
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.barStyle = .blackTranslucent
        searchBar.searchBarStyle = .prominent
        searchBar.barTintColor = .black
        searchBar.placeholder = "Language".localized
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        currentSearchText = searchBar.text ?? ""
        searchBar.resignFirstResponder()
        fetchRepositoriesOnSearch()
    }
}
