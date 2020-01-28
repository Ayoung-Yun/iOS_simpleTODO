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
        loadAll()
    }
    
    private func setUpUI() {
        memoTableView.dataSource = self
        memoTableView.delegate = self
    }
    
    private func saveAll() {
        let data = memos.map { memo in [
            "content": memo.content,
            "insertDate": memo.date
        ]}
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: UserDefaultKey.memoList)
        userDefaults.synchronize()
    }
    
    private func loadAll() {
        let userDefaults = UserDefaults.standard
        // Array<Dictionary<String, Any> 로 다운캐스팅
        guard let data = userDefaults.object(forKey: UserDefaultKey.memoList) as? [[String: Any]] else { return }
        
        memos = data.map { memo in
            let content = memo["content"] as? String ?? ""
            let date = memo["insertDate"] as? Date ?? Date()
            return Memo(content: content, date: date)
        }
    }
    
    @IBAction func addMemo(_ sender: UIBarButtonItem) {
        if let naviVC = storyboard?.instantiateViewController(withIdentifier: MemoComposeViewController.reuseIdentifier) as? UINavigationController,
            let composeVC = naviVC.viewControllers.first as? MemoComposeViewController {
            composeVC.addHandler = { memo in
                // 클로저 안에서는 self로 접근해야 함
                self.memos.insert(memo, at: 0)
                self.saveAll()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: MemoDetailViewController.reuseIdentifier) as? MemoDetailViewController else { return }
        
        detailVC.configure(with: self.memos[indexPath.row], indexPath: indexPath)
        
        detailVC.deleteHandler = { indexPath in
            print(indexPath)
        }
        
        detailVC.editHandler = { memo in
            print(memo)
        }
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
