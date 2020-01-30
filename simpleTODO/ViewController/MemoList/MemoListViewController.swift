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
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        print("viewWillAppear")
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        print("viewDidAppear")
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        print("viewWillDisappear")
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        print("viewDidDisappear")
//    }
    
    private func setUpUI() {
        // extension tableView
        memoTableView.dataSource = self
        memoTableView.delegate = self
    }
    
    // update memo list at userDefaults
    private func saveAll() {
        let data = memos.map { memo in [
            "content": memo.content,
            "insertDate": memo.date
        ]}
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: UserDefaultKey.memoList)
        userDefaults.synchronize()
    }
    
    // load memo list
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
    
    private func applyAll() {
        self.saveAll()
        // TableView에 변화가 생기면 꼭!! reloadData()를 해줘야 함
        self.memoTableView.reloadData()
    }
    
    @IBAction func addMemo(_ sender: UIBarButtonItem) {
        if let naviVC = storyboard?.instantiateViewController(withIdentifier: MemoComposeViewController.reuseIdentifier) as? UINavigationController,
            let composeVC = naviVC.viewControllers.first as? MemoComposeViewController {
            composeVC.addHandler = { memo in
                // 클로저 안에서는 self로 접근해야 함
                self.memos.insert(memo, at: 0)
                self.applyAll()
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
            self.memos.remove(at: indexPath.row)
            self.applyAll()
        }
        
        detailVC.editHandler = { editMemo, editIndex in
            print(editMemo)
            print(editIndex)
        }
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
