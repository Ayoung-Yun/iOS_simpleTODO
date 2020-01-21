//
//  Memo.swift
//  simpleTODO
//
//  Created by 윤아영(Yun, AYoung) on 2020/01/21.
//  Copyright © 2020 ayoung. All rights reserved.
//

import Foundation

// 외부에서 값을 바꿔도 바뀌지 않음
struct Memo {
    
    var content: String
    var date: Date
    
    init(content: String, date: Date) {
        self.content = content
        self.date = date
    }
}
