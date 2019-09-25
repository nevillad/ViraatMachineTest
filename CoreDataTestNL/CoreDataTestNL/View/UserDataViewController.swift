//
//  ViewController.swift
//  CoreDataTestNL
//
//  Created by Nevil Lad on 25/09/19.
//  Copyright © 2019 Nevil Lad. All rights reserved.
//

import UIKit

class UserDataViewController: UIViewController {
    
    @IBOutlet weak var userDataTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }

    //MARK :: Class Methods
    func setupView(){
        //setup Navigation Bar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
    }

    @objc func addTapped(){
        print("Add")
    }
    
    @objc func refreshTapped(){
          print("refresh")
      }
    
}

extension UserDataViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserDataTableViewCell", for: indexPath) as! UserDataTableViewCell
        
        return cell
    }
}
