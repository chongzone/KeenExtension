//
//  ViewController.swift
//  KeenExtension
//
//  Created by chongzone on 06/15/2020.
//  Copyright (c) 2020 chongzone. All rights reserved.
//

import UIKit
import KeenExtension

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "KeenExtension"
        
        view.backColor(.colorRandom)
        
        test_snap()
    }
    
    func test_snap() {
        
        let backView = UIView()
            .backColor(.colorRandom)
            .addViewTo(view)
        
        backView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(300)
        }
        var items = [UIView]()
        for _ in 0 ..< 2 {
            let subView = UIView()
                .backColor(.colorRandom)
                .addViewTo(backView)
            items.append(subView)
        }
        items.snp.distributeViewsAlongAxis(
            .horizontal,
            fixedSpacing: 20,
            leadSpacing: 10,
            tailSpacing: 10
        )
        items.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(280)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

