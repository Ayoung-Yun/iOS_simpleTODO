//
//  MemoDetailViewController.swift
//  simpleTODO
//
//  Created by 윤아영(Yun, AYoung) on 2020/01/23.
//  Copyright © 2020 ayoung. All rights reserved.
//

import UIKit

class MemoDetailViewController: UIViewController {
    
    enum CellType: Int {
        case content,
        date
    }
    
    @IBOutlet weak var detailTableView: UITableView!
    
    var memo: Memo?
    var indexPath: IndexPath?
    var deleteHandler: ((IndexPath) -> Void)?
    var editHandler: ((Memo, IndexPath) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    private func setUpUI() {
        detailTableView.delegate = self
        detailTableView.dataSource = self
    }
    
    func configure(with memo: Memo, indexPath: IndexPath) {
        self.memo = memo
        self.indexPath = indexPath
    }
    
    private func popDetailVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backList(_ sender: UIBarButtonItem) {
        popDetailVC()
    }
    
    @IBAction func deleteMemo(_ sender: UIBarButtonItem) {
        guard let delIndex = indexPath else { return }
        deleteHandler?(delIndex)
        popDetailVC()
    }
    
    @IBAction func editMemo(_ sender: UIBarButtonItem) {
        if let naviVC = storyboard?.instantiateViewController(withIdentifier: MemoComposeViewController.reuseIdentifier) as? UINavigationController,
            let composeVC = naviVC.viewControllers.first as? MemoComposeViewController {
            guard let editMemo = memo else { return }
            composeVC.configure(with: editMemo)
            composeVC.addHandler = { editMemo in
                self.memo = editMemo
                self.detailTableView.reloadData()
            }
            present(naviVC, animated: true, completion: nil)
        }
    }
}

extension MemoDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch CellType(rawValue: indexPath.row) {
        case .content:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentCell.reuseIdentifier, for: indexPath) as? ContentCell else {
                return UITableViewCell()
            }
            cell.configure(with: self.memo?.content ?? "")
            return cell
        case .date:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DateCell.reuseIdentifier, for: indexPath) as? DateCell else {
                return UITableViewCell()
            }
            cell.configure(with: self.memo?.date ?? Date())
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension MemoDetailViewController: UITableViewDelegate {
    
}
