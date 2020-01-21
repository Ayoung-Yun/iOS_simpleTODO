//
//  MemoComposeViewController.swift
//  simpleTODO
//
//  Created by 윤아영(Yun, AYoung) on 2020/01/20.
//  Copyright © 2020 ayoung. All rights reserved.
//

import UIKit

class MemoComposeViewController: UIViewController {
    
    @IBOutlet weak var contentView: UITextView!
    
    // 클로저 (반대로 넘길 때)
    var addHandler: ((Memo) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func dismissModal() {
        dismiss(animated: true, completion: nil)
    }
    
    private func failAdd() {
        let controller = UIAlertController(title: "알림", message: "메모를 입력해주세요.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        dismissModal()
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        guard let content = contentView.text, content.count > 0 else {
            failAdd()
            return
        }
        
        let memo = Memo(content: content, date: Date())
        addHandler?(memo)
        dismissModal()
    }
}
