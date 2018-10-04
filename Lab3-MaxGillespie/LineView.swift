//
//  lineView.swift
//  Lab3-MaxGillespie
//
//  Created by Max Gillespie on 10/1/18.
//  Copyright © 2018 Max Gillespie. All rights reserved.
//

import Foundation
import UIKit

class LineView:UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var theLine:Line? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var lines: [Line] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    func drawLine(_ line: Line) {
        line.color.setFill()
        let path = UIBezierPath()
        
        path.lineWidth = line.radius * 2
        
        for point in line.points {
            path.addArc(withCenter: point, radius: line.radius, startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true)
            
            path.move(to: point)
            path.addLine(to: point)
            
            path.fill()
        }
    }
    
    private func midpoint(first: CGPoint, second: CGPoint) -> CGPoint {
        let midPt = CGPoint(x: CGFloat((second.x + first.x)/2), y: CGFloat((first.y + second.y)/2))
        // print ("midPt: \(midPt)")
        return midPt
    }
    
    func createQuadPath(points: [CGPoint], radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        if points.count < 2 { return path }
        let firstPoint = points[0]
        let secondPoint = points[1]
        let firstMidpoint = midpoint(first: firstPoint, second: secondPoint)
        path.move(to: firstPoint)
        
        // ADDED:
        path.addArc(withCenter: firstMidpoint, radius: radius, startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true)
        // print (secondPoint, firstMidpoint)
        
        path.addLine(to: firstMidpoint)
        for index in 1 ..< points.count-1 {
            let currentPoint = points[index]
            let nextPoint = points[index + 1]
            let midPoint = midpoint(first: currentPoint, second: nextPoint)
            
            //ADDED:
            // print (currentPoint, midpoint)
            path.addArc(withCenter: midPoint, radius: radius, startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true)
        }
        guard let lastLocation = points.last else { return path }
        path.addArc(withCenter: lastLocation, radius: radius, startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true)
        return path
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        for line in lines {
            drawLine(line)
        
            let fillPath = createQuadPath(points: line.points, radius: line.radius)
            line.color.setStroke()
            fillPath.lineWidth = 8
            fillPath.stroke()
            //CGContextSetLineWidth(context, 20)
        }
        if (theLine != nil) {
            drawLine(theLine!)
        }
    }
}
