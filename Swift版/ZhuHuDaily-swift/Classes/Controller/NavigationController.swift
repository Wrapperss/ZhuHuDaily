//
//  NavigationController.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/6.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationBar.barTintColor = ZHI_HU_COLOR
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
