//
//  ViewController.swift
//  CellOfArt
//
//  Created by 侯玉昆 on 16/3/26.
//  Copyright © 2016年 suger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
     let tableView = HYKCellOfArt.init(frame: CGRectMake(0, 100, UIScreen.mainScreen().bounds.width, 300), style: UITableViewStyle.Plain)
        
        view .addSubview(tableView)
        
    }
    

}

