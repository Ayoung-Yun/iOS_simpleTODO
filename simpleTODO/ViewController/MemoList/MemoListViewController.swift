//
//  MemoListViewController.swift
//  simpleTODO
//
//  Created by 윤아영(Yun, AYoung) on 2020/01/17.
//  Copyright © 2020 ayoung. All rights reserved.
//

import UIKit

class MemoListViewController: UIViewController {
    
    @IBOutlet weak var memoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        memoTableView.dataSource = self
        memoTableView.delegate = self
    }
    
    @IBAction func addMemo(_ sender: UIBarButtonItem) {
        if let naviVC = storyboard?.instantiateViewController(withIdentifier: "MemoComposeViewController") as? UINavigationController, let composeVC = naviVC.viewControllers.first as? MemoComposeViewController {
            present(naviVC, animated: true, completion: nil)
        }
    }
    
}

extension UIViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension UIViewController: UITableViewDelegate {
    
}
