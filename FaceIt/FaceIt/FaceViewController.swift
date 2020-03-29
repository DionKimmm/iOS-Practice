//
//  ViewController.swift
//  FaceIt
//
//  Created by 김동욱 on 28/03/2020.
//  Copyright © 2020 dionkim. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
    
    var expression = FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smile) {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(
//                target: faceView, action: #selector(FaceView.changeScale(recognizer: ))
            ))
            let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.increaseHappiness)
            )
            happierSwipeGestureRecognizer.direction = .up
            faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
            
            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.decreaseHappiness)
            )
            sadderSwipeGestureRecognizer.direction = .down
            faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
            updateUI()
        }
    }
    
    @IBAction func toggleEyes(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            switch expression.eyes {
            case .Open: expression.eyes = .Closed
            case .Closed: expression.eyes = .Open
            case .Squinting: break
            }
        }
    }
    @objc func increaseHappiness()
    {
        expression.mouth = expression.mouth.happierMouth()
    }
    
    @objc func decreaseHappiness()
    {
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    //모델과 뷰 대응, 뷰를 위해 모델을 해석해주었음
    private var mouthCurvatures = [FacialExpression.Mouth.Frown:-1.0, .Grin:0.5, .Smile:1.0, .Smirk:-0.5, .Neutral:0.0]
    private var eyeBrowTilts = [FacialExpression.EyeBrows.Relaxed:0.5, .Furrowed:-0.5, .Normal:0.0]
    
    private func updateUI() {
        if faceView != nil {
            switch expression.eyes {
            case .Open: faceView.eyesOpen = true
            case .Closed: faceView.eyesOpen = false
            case .Squinting: faceView.eyesOpen = false
            }
            faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
            faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
        }
    }
}

