//
//  ResultViewController.swift
//  mlexp
//
//  Created by zxj on 2019/1/10.
//  Copyright © 2019 Yamin Wei. All rights reserved.
//

import UIKit

class ResultViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func actionGoBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
