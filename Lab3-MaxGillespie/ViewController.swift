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
        currentColor = UIColor(displayP3Red: 1, green: 0, blue: 0, alpha: CGFloat(alphaSliderValue.value))
    }
    @IBAction func orangeSelected(_ sender: Any) {
        currentColor = UIColor(displayP3Red: 1, green: 0.5, blue: 0, alpha: CGFloat(alphaSliderValue.value))
    }
    @IBAction func yellowSelected(_ sender: Any) {
        currentColor = UIColor(displayP3Red: 1, green: 1, blue: 0, alpha: CGFloat(alphaSliderValue.value))

    }
    @IBAction func greenSelected(_ sender: Any) {
        currentColor = UIColor(displayP3Red: 0.19, green: 0.83, blue: 0.22, alpha: CGFloat(alphaSliderValue.value))
    }
    @IBAction func blueSelected(_ sender: Any) {
        currentColor = UIColor(displayP3Red: 0.42, green: 0.70, blue: 0.86, alpha: CGFloat(alphaSliderValue.value))
    }
    
    
    
    @IBOutlet weak var alphaSliderValue: UISlider!
    @IBAction func alphaSliderDidChange(_ sender: Any) {
        currentColor = currentColor?.withAlphaComponent(CGFloat(alphaSliderValue.value))
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
        touchPoint.y -= 60
        
        currentLine = Line(color: currentColor!, radius: lineRadius!, points: [])
        LineCanvas.lines.append(currentLine!)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touchPoint = (touches.first)!.location(in: view) as CGPoint
        touchPoint.y -= 60
        
        if currentLine != nil {
            currentLine!.points.append(touchPoint)
            LineCanvas.lines.removeLast()
            LineCanvas.lines.append(currentLine!)
        }
    }
}

