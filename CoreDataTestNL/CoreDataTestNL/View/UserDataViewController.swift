//
//  ViewController.swift
//  CoreDataTestNL
//
//  Created by Nevil Lad on 25/09/19.
//  Copyright © 2019 Nevil Lad. All rights reserved.
//

import UIKit

class UserDataViewController: UIViewController {
    private var viewModel: UserDataListViewModel?
    @IBOutlet weak var userDataTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.viewModel = UserDataListViewModel(delegate: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    //MARK :: Class Methods
    func setupView(){
        //setup Navigation Bar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
    }

    @objc func addTapped(){
        self.viewModel?.addDataRecord()
    }
    
    @objc func refreshTapped(){
        print("Refresh")
    }
}

extension UserDataViewController: UserDataListViewModelDelegate {
    func reloadData() {
        self.userDataTableView.reloadData()
    }
}

extension UserDataViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfUserData() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserDataTableViewCell", for: indexPath) as! UserDataTableViewCell
        if let userDataViewModel = viewModel?.userInfoViewModelForIndex(index: indexPath.row) {
            cell.setViewModel(viewModel: userDataViewModel)
        }
        return cell
    }
}
