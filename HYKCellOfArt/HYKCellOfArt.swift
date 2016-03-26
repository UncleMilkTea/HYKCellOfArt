//
//  CellOfArt.swift
//  CellOfArt
//
//  Created by 侯玉昆 on 16/3/26.
//  Copyright © 2016年 suger. All rights reserved.
//

import UIKit

private let  identifier = "CellOfArt"

//  设置初始下标为了从第一个cell开始翻转
private var  index :NSInteger = -1

class HYKCellOfArt: UITableView {

    /// cell的个数(如果自定义cell个数过多超过控件高度程序奔溃)
    var hyk_cellNumber: NSInteger!
    
    /// cell的内容
    var hyk_content : String?
    
    /// cell的颜色
    var hyk_color : UIColor?
    
    /// cell的动画时长
    var hyk_duration : NSTimeInterval?
    
    /// 每个cell的动画间隔时间
    var hyk_timeInterval : NSTimeInterval?
    
    /// cell的动画类型
    var hyk_transitionType : String?
    
    /// 随机色
    private let RADOMCOLOR = UIColor(red:CGFloat(arc4random_uniform(256)) / 255, green: CGFloat(arc4random_uniform(256)) / 255, blue: CGFloat(arc4random_uniform(256)) / 255, alpha: 1.0)
    
    override init(frame: CGRect, style: UITableViewStyle) {
        
        super.init(frame: frame, style: style); setupUI()
        
        /// 这里根据传入的Frame自动计算cell的个数,如果自定义cell个数过多程序奔溃
        hyk_cellNumber = NSInteger(frame.size.height / 44)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        self.registerClass(UITableViewCell.self, forCellReuseIdentifier:identifier)
        
        self.userInteractionEnabled = false
        
        self.dataSource = self;
        
        self.delegate = self;
        
        addTimer()
    }
    
    private func addTimer(){
        
        let timer = NSTimer.scheduledTimerWithTimeInterval( hyk_timeInterval ?? 2.5, target: self, selector:"animationStart", userInfo: nil, repeats: true)
        
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
 @objc private func animationStart(){
    
        index += 1
        
        var row = index
        
        if row > hyk_cellNumber - 1 {
            
            row = index % hyk_cellNumber
        }
        
        let indexPath = NSIndexPath.init(forRow: row, inSection: 0)
    
        tableView(self, didSelectRowAtIndexPath: indexPath)
        
    }
}

extension HYKCellOfArt: UITableViewDataSource,UITableViewDelegate{
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hyk_cellNumber
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        
        cell.hidden = true
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        
        cell.backgroundColor = hyk_color ?? RADOMCOLOR
        
        cell.textLabel?.text = hyk_content ?? "https://github.com/houyukun"
        
        cell.textLabel?.textAlignment = .Center
        
        // 设置动画
        let transition = CATransition()
    
        transition.type = hyk_transitionType ?? "cube"
      
        transition.duration = hyk_duration ?? 0.8
        
        cell.layer.addAnimation(transition, forKey: nil)
       
        cell.hidden = false
    }
}