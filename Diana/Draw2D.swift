//
//  Draw2D.swift
//  Diana
//
//  Created by Ricardo Riosalido on 26/2/17.
//  Copyright © 2017 Ricardo Riosalido. All rights reserved.
//

import UIKit
import AVFoundation


let userDefaults = UserDefaults.standard

class Draw2D: UIView {
    
    

    var limitRadios = [Double]()
    var puntos = [0,1,2,3,4,5,6,7,8,9,10,10]
    var numberShots = 0
    var shots = [CGPoint()]
    var centro = CGPoint()
    var total = 0
    var mypuntos = [0]
    var media = 0.0
    var Radio = CGFloat()
    let systemSoundID: SystemSoundID = 1105
    
    let tipoDiana = userDefaults.string(forKey: "Diana")!
    var escala = 0
    
    
 

//let escala = 10   //Fita
    //let escala = 6  //Fita reducida al 5
    //let escala = 5    // Fita reducida al 6
        
    
    @IBOutlet weak var puntuacion: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var mediaLabel: UILabel!
    @IBOutlet weak var tirosLabel: UILabel!
    
    @IBOutlet weak var clearButton: UIButton!
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        switch tipoDiana   {
        case "Fita":
            escala = 10
            break;
        case "Fita-6":
            escala = 6
            break;
        case "Fita-5":
            escala = 5
            break;
        default:
            escala = 10
            break
        }
        
        Radio = min( bounds.size.width/2, bounds.size.height/2)
        centro = calcCenter()
        print ("Centro:",centro)
        let color:UIColor = UIColor.white
        let drect = CGRect(x: CGFloat(0.0) ,y: (centro.y-Radio) ,width: Radio*2 ,height: Radio*2)
        let bpath:UIBezierPath = UIBezierPath(rect: drect)
        color.set()
        //let fill: UIColor = UIColor.white
        bpath.fill()
        bpath.stroke()
        
        var fillColor : [UIColor] = [.white,.white,.black,.black,.blue,.blue,.red,.red,.yellow,.yellow]
        fillColor = fillColor.reversed()
        
        for i in (1...escala).reversed() {
            let radio = (Radio / CGFloat(escala)) * CGFloat(i)
            limitRadios.append(Double(radio))

            if i == 7 {
                circulo(centro: centro, radio: radio, color: .white, fill: fillColor[i-1])
            } else {
                circulo(centro:centro, radio: radio, color: .black, fill: fillColor[i-1])
            }
        }
        let radioInt = limitRadios[escala-1] / 2
        circulo(centro:centro, radio: CGFloat(radioInt), color: .gray, fill: .yellow)
        
        clearButton.isEnabled = false
        print("Radios:",limitRadios)
    }
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self)
            if (position.y >= (centro.y-Radio) && position.y <= (centro.y+Radio)) {
                let myRadio = calcRadio(position: position)
                //let radioN = (myRadio*10)/Radio
                let radioN = (myRadio * CGFloat(escala)) / Radio
                var myp = 11 - radioN
                if myp < CGFloat(11 - escala) {myp = 0}
                puntuacion.text = "Hit: " + String(Int(myp))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self)
            if (position.y >= (centro.y-Radio) && position.y <= (centro.y+Radio)) {
                let myRadio = calcRadio(position: position)
                let radioN = (myRadio * CGFloat(escala)) / Radio
                //let radioN = (myRadio*10)/Radio
                var myp = 11 - radioN
                if myp < CGFloat(11 - escala) {myp = 0}
                puntuacion.text = "Hit: " + String(Int(myp))
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self)
            if (position.y >= (centro.y-Radio) && position.y <= (centro.y+Radio)) {
                AudioServicesPlaySystemSound (systemSoundID)
                let myRadio = calcRadio(position: position)
                print ("myradio:",myRadio)
                shots.append(position)
                numberShots += 1
                let radioN = (myRadio * CGFloat(escala)) / Radio
                var myp = 11 - radioN
                
                
                print ("x,y:",position.x,position.y)
                
                print ("Radio Norm",radioN,myp)
                if myp < CGFloat(11 - escala) {myp = 0}
                
                
                mypuntos.append(Int(myp))
                puntuacion.text = "Hit: " + String(Int(myp))
                circulo(centro: position, radio: 5, color: .black, fill:.green)
                total = total + Int(myp)
                totalLabel.text = "Total:" + String(total)
                media = Double(total)/Double(numberShots)
                media = Double(round(10*media)/10)
                mediaLabel.text = "Media:" + String(media)
                tirosLabel.text = "Tiros:" + String(numberShots)
                print (shots,mypuntos)
                if numberShots > 0 {
                    clearButton.isEnabled = true
                } else {
                    clearButton.isEnabled = false
                }
                
            }
        }
    }
    
    internal func circulo (centro: CGPoint,radio:CGFloat,color:UIColor,fill:UIColor) {
 
        let desiredLineWidth:CGFloat = 1
        let circlePath = UIBezierPath(
            arcCenter: centro,
            radius: radio,
            startAngle: CGFloat(0),
            endAngle:CGFloat(M_PI * 2),
            clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = fill.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = desiredLineWidth
        layer.addSublayer(shapeLayer)
    }
    
    
    func calcCenter() -> CGPoint{
        let width = frame.size.width
        let height = frame.size.height
        print ("Tamaño:",width,height)
        return CGPoint(x:width/2,y: height/2)
    }
    
    func calcRadio (position: CGPoint) -> CGFloat {
        //let centro = calcCenter()
        let x = position.x - centro.x
        let y = position.y - centro.y
        let r = sqrt(x*x + y*y)
        //print ("radio:",r)
        return r
    }
    
    
    @IBAction func clear(_ sender: UIButton) {
        AudioServicesPlaySystemSound (systemSoundID)
        puntuacion.text = "Hit:"
        total = total - mypuntos[numberShots]
        mypuntos.remove(at: (mypuntos.count) - 1)
        circulo(centro: shots[numberShots], radio: 5, color: .black, fill:.purple)
        shots.remove(at: (shots.count) - 1)
        numberShots = numberShots - 1
        media = Double(total)/Double(numberShots)
        media = Double(round(10*media)/10)
        mediaLabel.text = "Media:" + String(media)
        totalLabel.text = "Total:" + String(total)
        tirosLabel.text = "Tiros:" + String(numberShots)
        if numberShots == 0 {clearButton.isEnabled=false}
        print (shots,mypuntos)
    }
}

