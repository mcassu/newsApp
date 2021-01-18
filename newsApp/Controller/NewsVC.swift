//
//  ViewController.swift
//  newsApp
//
//  Created by Cassu on 13/01/21.
//  Copyright © 2021 Cassu. All rights reserved.
//

import UIKit
import SafariServices

class NewsViewController: UIViewController {
    
   private var newListVM: NewListViewModel!
   private var countrySelected = "US"
    
   private let SegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(frame: .zero)
        sc.insertSegment(withTitle: "US", at: 0, animated: true)
        sc.insertSegment(withTitle: "BR", at: 1, animated: true)
        sc.insertSegment(withTitle: "AR", at: 2, animated: true)
        sc.selectedSegmentIndex = 0
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.backgroundColor = .systemBackground
        return sc
    }()
    
    private let tableView: UITableView = {
        let tb = UITableView(frame: .zero, style: .plain)
        tb.register(NewsTableViewCell.self, forCellReuseIdentifier: "cell")
        tb.rowHeight = UITableView.automaticDimension
        tb.estimatedRowHeight = 80
        tb.allowsSelection = false
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.tableFooterView = UIView(frame:.zero)
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension NewsViewController {
    
    private func setupUI(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(getNews))
        self.navigationItem.rightBarButtonItem  = refreshButton
        self.navigationItem.title = "Headlines"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(SegmentedControl)
        view.addSubview(tableView)
        
        let safeArea = view.layoutMarginsGuide
        
        SegmentedControl.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        SegmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        SegmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        SegmentedControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        tableView.topAnchor.constraint(equalTo: SegmentedControl.bottomAnchor, constant: 8).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        setupData()
    }
    
    private func setupData() {
        SegmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        segmentedValueChanged(SegmentedControl)
    }

    @objc private func segmentedValueChanged(_ sender:UISegmentedControl!){
        let title = sender.titleForSegment(at: sender.selectedSegmentIndex)
        guard let country = title else {
            return
        }
        countrySelected = country
        getNews()
    }
    
    @objc private func getNews() {
        
        Webservice().getHeadlinesNews(countrySelected) { news in
            if let news = news {
                self.newListVM = NewListViewModel(news: news)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.scrollToTop()
                }
            }
        }
    }

}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.newListVM == nil ? 0 : self.newListVM.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newListVM.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NewsTableViewCell else {
            fatalError("NewTableViewCell not found")
        }
        
        let newVM = self.newListVM.newAtIndex(indexPath.row)
        cell.setup(newVM: newVM, ctx: self)
        
        return cell
    }

    
    func scrollToTop() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

