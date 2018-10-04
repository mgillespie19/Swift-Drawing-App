//
//  ViewController.swift
//  Lab3-MaxGillespie
//
//  Created by Max Gillespie on 9/25/18.
//  Copyright © 2018 Max Gillespie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentLine: Line?
    var LineCanvas: LineView!
    var currentColor: UIColor?
    var lineRadius: CGFloat?
    
    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var radiusSliderValue: UISlider!
    
    
    @IBAction func radiusSliderDidChange(_ sender: Any) {
        if radiusSliderValue != nil {
            lineRadius = CGFloat(radiusSliderValue.value*50)
        }
    }
    @IBAction func sliderValueDidChange(_ sender: Any) {
        lineRadius = CGFloat(radiusSliderValue.value * 30)
    }
    @IBAction func clearBtnPress(_ sender: Any) {
        LineCanvas.theLine = nil
        LineCanvas.lines = []
    }
    @IBAction func undoBtnPress(_ sender: Any) {
        LineCanvas.theLine = nil
        if LineCanvas.lines.count > 0 {
            LineCanvas.lines.removeLast()
        }
    }
    @IBAction func redColorSelected(_ sender: Any) {
        currentColor = UIColor.red
    }
    @IBAction func orangeSelected(_ sender: Any) {
        currentColor = UIColor.orange
    }
    @IBAction func yellowSelected(_ sender: Any) {
        currentColor = UIColor.yellow
    }
    @IBAction func greenSelected(_ sender: Any) {
        currentColor = UIColor(displayP3Red: 0.19, green: 0.83, blue: 0.22, alpha: 1)
    }
    @IBAction func blueSelected(_ sender: Any) {
        currentColor = UIColor(displayP3Red: 0.42, green: 0.70, blue: 0.86, alpha: 1)
    }
    @IBAction func purpleSelected(_ sender: Any) {
        currentColor = UIColor(displayP3Red: 0.49, green: 0.25, blue: 0.83, alpha: 1)
    }
    @IBAction func violetSelected(_ sender: Any) {
        currentColor = UIColor(displayP3Red: 0.85, green: 0.66, blue: 1, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LineCanvas = LineView(frame: testView.frame)
        view.addSubview(LineCanvas)
        currentColor = UIColor.red
        lineRadius = 15
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touchPoint = (touches.first)!.location(in: view) as CGPoint
        touchPoint.y -= 50
        
        currentLine = Line(color: currentColor!, radius: lineRadius!, points: [])
        LineCanvas.lines.append(currentLine!)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touchPoint = (touches.first)!.location(in: view) as CGPoint
        touchPoint.y -= 50
        
        if currentLine != nil {
            currentLine!.points.append(touchPoint)
            LineCanvas.lines.removeLast()
            LineCanvas.lines.append(currentLine!)
        }
    }
}

