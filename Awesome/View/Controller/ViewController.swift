//
//  ViewController.swift
//  Awesome
//
//  Created by colt on 2019/11/29.
//  Copyright © 2019 colt. All rights reserved.
//

import UIKit

class ViewController: BaseTableViewController {

    private let accessViewModel:AccessViewModel = AccessViewModel()
    private var uiListData:[UIListModel]? = []
    private let limitDataCount = 100
    private var dataCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViewComponent()
        
        fectchData()
    }

    // MARK - TableView's delegate & data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uiListData?.count ?? 0;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        
        if let avatarUrl = uiListData?[indexPath.row].avatar_url {
            
            tableViewCell.avatarUrl = avatarUrl
        }

        if let name = uiListData?[indexPath.row].login {
            
            tableViewCell.name = name
        }

        if let isAdmin = uiListData?[indexPath.row].site_admin {
            
            tableViewCell.isAdmin = isAdmin
        }

        return tableViewCell;
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
           // print("this is the last cell")
            let spinner = UIActivityIndicatorView(style: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

            self.tableView?.tableFooterView = spinner
            self.tableView?.tableFooterView?.isHidden = false
            
            fectchData()
        }
    }
    
    // MARK: - Private Methods
    func setupViewComponent() {
        
        let tableViewCellNib = UINib.init(nibName: TableViewCell.identifier, bundle: nil);
        self.tableView?.register(tableViewCellNib, forCellReuseIdentifier: TableViewCell.identifier);
    }
    
    func fectchData() {
        
        if let count = self.uiListData?.count, count < limitDataCount {
            
            accessViewModel.fectchUIList(since:self.uiListData?.count ?? 0) {
                [weak self] (listData) in
                
                self?.uiListData?.append(contentsOf: listData)
                self?.tableView?.reloadData()
            }
        }
        else {
            
            self.tableView?.tableFooterView = nil
            self.tableView?.tableFooterView?.isHidden = true
        }
    }
}
