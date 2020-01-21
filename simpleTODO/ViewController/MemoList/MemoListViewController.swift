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
    
    var memos: [Memo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        memoTableView.dataSource = self
        memoTableView.delegate = self
    }
    
    @IBAction func addMemo(_ sender: UIBarButtonItem) {
        if let naviVC = storyboard?.instantiateViewController(withIdentifier: MemoComposeViewController.reuseIdentifier) as? UINavigationController, let composeVC = naviVC.viewControllers.first as? MemoComposeViewController {
            composeVC.addHandler = { memo in
                // 클로저 안에서는 self로 접근해야 함
                self.memos.insert(memo, at: 0)
                // TableView에 변화가 생기면 꼭!! reloadData()를 해줘야 함
                self.memoTableView.reloadData()
            }
            present(naviVC, animated: true, completion: nil)
        }
    }
}

extension MemoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoCell.reuseIdentifier, for: indexPath) as? MemoCell else {
            return UITableViewCell()
        }

        cell.configure(with: memos[indexPath.row].content)
        return cell
    }
}

extension MemoListViewController: UITableViewDelegate {
    
}
