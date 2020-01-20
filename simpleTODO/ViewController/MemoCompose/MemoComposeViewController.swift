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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dissmiss(_ sender: UIBarButtonItem) {
        contentView.text = ""
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
    }
}
