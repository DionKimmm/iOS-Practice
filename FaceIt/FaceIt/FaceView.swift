//
//  FaceView.swift
//  FaceIt
//
//  Created by 김동욱 on 28/03/2020.
//  Copyright © 2020 dionkim. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView {
    
    @IBInspectable
    var scale: CGFloat = 0.90 { didSet { setNeedsDisplay() } }
    @IBInspectable
    var mouthCurvature: Double = 1.0 { didSet { setNeedsDisplay() } }
    @IBInspectable
    var eyesOpen: Bool = true { didSet { setNeedsDisplay() } }
    // 눈썹 기울기, -1 full furrow, 1 fully relaxed
    @IBInspectable
    var eyeBrowTilt: Double = 0.0 { didSet { setNeedsDisplay() } }
    @IBInspectable
    var color: UIColor = UIColor.blue { didSet { setNeedsDisplay() } }
    @IBInspectable
    var lineWidth: CGFloat = 5.0 { didSet { setNeedsDisplay() } }
    
    func changeScale(recognizer: UIPinchGestureRecognizer) {
        switch recognizer.state {
        case .changed, .ended:
            scale *= recognizer.scale
            recognizer.scale = 1.0
        default:
            break
        }
    }
    
    // 변수 프로퍼티에서 Set, Get 중 Get만 사용하면 Get을 생략하여 사용 가능
    private var skullRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 //두개골의 반경
    }
    private var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    private struct Ratios { //구조체는 대문자로 시작
        static let SkullRadiusToEyeOffset: CGFloat = 3 //상수도 대문자로 시작
        static let SkullRadiusToEyeRadius: CGFloat = 10
        static let SkullRadiusToMouthWidth: CGFloat = 1
        static let SkullRadiusToMouthHeight: CGFloat = 3
        static let SkullRadiusToMouthOffset: CGFloat = 3
        static let SkullRadiusToBrowOffset: CGFloat = 5
    }
    
    private enum Eye {
        case Left
        case Right
    }
    
    // 두개골 (동그라미)
    func pathForCircleCenteredAtPoint(midPoint: CGPoint, withRadius radius: CGFloat) -> UIBezierPath
    {
        let path = UIBezierPath(arcCenter: midPoint,
                                radius: radius, startAngle: 0.0,
                                endAngle: CGFloat(2*M_PI),
                                clockwise: false)
        path.lineWidth = lineWidth //선굵기
        return path
    }

    // 눈
    
    private func getEyeCenter(eye: Eye) -> CGPoint
    {
        let eyeOffset = skullRadius / Ratios.SkullRadiusToEyeOffset
        var eyeCenter = skullCenter
        eyeCenter.y -= eyeOffset
        switch eye {
        case .Left: eyeCenter.x -= eyeOffset
        case .Right: eyeCenter.x += eyeOffset
        }
        return eyeCenter
    }
    
    private func pathForEye(eye: Eye) -> UIBezierPath
    {
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let eyeCenter = getEyeCenter(eye: eye)
        if eyesOpen {
            return pathForCircleCenteredAtPoint(midPoint: eyeCenter, withRadius: eyeRadius)
        } else {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.lineWidth = lineWidth
            return path
            
        }
        
    }
    
    // 입
    
    private func pathForMouth() -> UIBezierPath
    {
        let mouthWidth = skullRadius / Ratios.SkullRadiusToMouthWidth
        let mouthHeight = skullRadius / Ratios.SkullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratios.SkullRadiusToMouthOffset
        
        let mouthRect = CGRect(x: skullCenter.x - mouthWidth/2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
        
        
        let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1))) * mouthRect.height
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.minY)
        let cp1 = CGPoint(x: mouthRect.minX + mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        let cp2 = CGPoint(x: mouthRect.maxX - mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        
        return path
    }
    
    // 눈썹
    private func pathForBrow(eye: Eye) -> UIBezierPath
    {
        var tilt = eyeBrowTilt
        switch eye {
        case .Left: tilt *= -1.0
        case .Right: break
        }
        var browCenter = getEyeCenter(eye: eye)
        browCenter.y -= skullRadius / Ratios.SkullRadiusToBrowOffset
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let tiltOffset = CGFloat(max(-1, min(tilt, 1))) * eyeRadius / 2
        let browStart = CGPoint(x: browCenter.x - eyeRadius, y: browCenter.y - tiltOffset)
        let browEnd = CGPoint(x: browCenter.x + eyeRadius, y: browCenter.y + tiltOffset)
        let path = UIBezierPath()
        path.move(to: browStart)
        path.addLine(to: browEnd)
        return path
    }
    
    override func draw(_ rect: CGRect) {
        
        color.set()
        pathForCircleCenteredAtPoint(midPoint: skullCenter, withRadius: skullRadius).stroke() //호를 따라 원을 그림
        pathForEye(eye: .Left).stroke()
        pathForEye(eye: .Right).stroke()
        pathForMouth().stroke()
        pathForBrow(eye: .Left).stroke()
        pathForBrow(eye: .Right).stroke()
    }
 

}
