//
//  AboutMeViewController.swift
//  mlexp
//
//  Created by zxj on 2019/1/11.
//  Copyright © 2019 Yamin Wei. All rights reserved.
//

import UIKit

class AboutMeViewController: BaseViewController {
    @IBOutlet weak var descLabel1: UILabel!
    @IBOutlet weak var descLabel2: UILabel!
    @IBOutlet weak var descLabel3: UILabel!
    @IBOutlet weak var descLabel4: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.descLabel1.textAlignment = .center
        self.descLabel1.textColor = UIColor.brown
        self.descLabel1.font = UIFont.titleFont
        self.descLabel1.text = "THANK YOU FOR USING\nDOGAPOO!"
        
        self.descLabel2.textAlignment = .center
        self.descLabel2.textColor = UIColor.brown
        self.descLabel2.font = UIFont.titleFont
        self.descLabel2.text = "WE ARE TRYING TO\nMAKE IT BETTER!"
        
        self.descLabel3.textAlignment = .center
        self.descLabel3.textColor = UIColor.brown
        self.descLabel3.font = UIFont.titleFont
        self.descLabel3.text = "LET US KNOW OUR THOUGHTS\nBY LEAVING A FEEDBACK!"
        
        self.descLabel4.textAlignment = .center
        self.descLabel4.textColor = UIColor.brown
        self.descLabel4.font = UIFont.titleFont
        self.descLabel4.text = "FEED US A BONE\n BY CLICKING THE AD!"
    }
    
    @IBAction func actionGoBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
