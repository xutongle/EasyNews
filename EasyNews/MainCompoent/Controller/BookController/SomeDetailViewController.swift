//
//  SomeDetailViewController.swift
//  EasyNews
//
//  Created by mac_zly on 2017/3/24.
//  Copyright © 2017年 zly. All rights reserved.
//

import UIKit

class SomeDetailViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func CloseAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
