//
//  ViewController.swift
//  ScaleLayer
//
//  Created by 这个夏天有点冷 on 2017/4/13.
//  Copyright © 2017年 YLT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "刻度练习"
        
        createScale()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController {
    
    fileprivate func createScale() {
        //  1.创建内层弧线
        createCicrle()
        
        //  2.创建刻度
        createPlate()
        
        //  3.创建刻度label
        createPlateLabel()
        
        //  4.创建进度曲线并添加动画
        createProgressCurve()
    }
    
    //  MARK:- 创建内层弧线
    private func createCicrle(){
        let cicrlePath = UIBezierPath.init(arcCenter: view.center, radius: 100, startAngle: -(CGFloat(Double.pi * 9) / 8), endAngle: (CGFloat(Double.pi)/8), clockwise: true)
        let shapeLayer = CAShapeLayer.init()
        shapeLayer.lineWidth = 10.0
        shapeLayer.lineCap = "round"
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = UIColor.init(red: 185/255.0, green: 243/255.0, blue: 110/255.0, alpha: 1.0).cgColor
        shapeLayer.path = cicrlePath.cgPath
        
        view.layer.addSublayer(shapeLayer)
    }
    
    //  MARK:- 创建刻度
    private func createPlate() {
        //  弧度
        let perAngle = CGFloat(Double.pi * 5) / 4 / 50
        
        for i in 0...50 {
            let startAngle = -(CGFloat(Double.pi * 9) / 8) + perAngle * CGFloat(i)
            let endAngle = startAngle + perAngle / 5
            
            let bezierPath = UIBezierPath.init(arcCenter: view.center, radius: 140, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            
            let shapeLayer = CAShapeLayer.init()
            if i % 5 == 0 {
                shapeLayer.lineWidth = 10.0
            } else {
                shapeLayer.lineWidth = 5.0
            }
            shapeLayer.strokeColor = UIColor.orange.cgColor
            shapeLayer.path = bezierPath.cgPath
            
            view.layer.addSublayer(shapeLayer)
        }
    }
    
    //  MARK:- 创建刻度label
    private func createPlateLabel()
    {
        let textAngle = Float(Double.pi * 5) / 4 / 10
        
        for i in 0...10 {
            let point = computeTextPosition(view.center, -Float(Double.pi) / 8 + textAngle * Float(i))
            let tickString = "\(labs(10 - i) * 10)"
            
            let label = UILabel.init(frame: CGRect.init(x: point.x - 8, y: point.y - 7, width: 23, height: 14))
            label.text = tickString
            label.font = UIFont.systemFont(ofSize: 10)
            label.textColor = UIColor.gray
            label.textAlignment = .center
            
            view.addSubview(label)
        }
    }
    
    //  MARK:- 计算文本的位置
    private func computeTextPosition(_ ArcCenter:CGPoint, _ angle:Float) -> CGPoint {
        let x = 155 * cosf(angle)
        let y = 155 * sinf(angle)
        
        let position : CGPoint = CGPoint.init(x: ArcCenter.x + CGFloat(x), y: ArcCenter.y - CGFloat(y))
        
        return position
    }
    
    //  MARK:- 创建进度曲线
    private func createProgressCurve() {
        let bizierPath = UIBezierPath.init(arcCenter: view.center, radius: 120, startAngle: -CGFloat(Double.pi * 9) / 8, endAngle: CGFloat(Double.pi) / 8, clockwise: true)
        
        let shapeLayer = CAShapeLayer.init()
        shapeLayer.lineWidth = 30.0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.cyan.cgColor
        shapeLayer.path = bizierPath.cgPath
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 0.8

        //  添加动画
        let basicAni = CABasicAnimation.init(keyPath: "strokeEnd")
        basicAni.duration = 3
        basicAni.fromValue = 0
        basicAni.toValue = 0.8
        shapeLayer.add(basicAni, forKey: "")
        
        view.layer.addSublayer(shapeLayer)
    }
}
