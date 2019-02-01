//
//  TraceViewController.swift
//  mlexp
//
//  Created by zxj on 2019/1/11.
//  Copyright © 2019 Yamin Wei. All rights reserved.
//

import UIKit

struct TraceData {
    var imgPath: String = ""
    var date: NSDate = NSDate()
    var name: String = ""
    var desc: String = ""
    var type: String = ""
    
    init() {
       
    }
    
    init(history: HistoryEntity) {
        self.imgPath = history.imgPath ?? ""
        self.name = history.name ?? ""
        self.desc = history.desc ?? ""
        self.type = history.type ?? ""
        self.date = history.date ?? NSDate()
    }
}

class TraceViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var thisArray: [TraceData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.saveTest()
        
        self.thisArray = HistoryApi.shared.loadTraces()
        self.tableView.reloadData()
    }
    
    func saveTest() {
        var trace = TraceData()
        trace.name = "testName"
        trace.desc = "testDesc"
        trace.type = "testType"
        
        HistoryApi.shared.save(trace: trace)
    }
    
    @IBAction func actionGoBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //tableView delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.thisArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TraceCell")
        if let data = self.thisArray?[indexPath.row], let traceCell = cell as? TraceCell {
            traceCell.setup(data: data)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
        }
    }
}
