//
//  ViewController.swift
//  Flip
//
//  Created by Seimith on 5/16/17.
//  Copyright © 2017 Seimith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var frontCoin: UIImageView!
    var backCoin: UIImageView!
    var scrimView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        frontCoin = UIImageView(frame: CGRect(x: (self.view.frame.size.width / 2) - 50, y: (self.view.frame.size.height / 2) - 50, width: 100, height: 100));
        let image = UIImage(named: "front");
        frontCoin.image = image;
        self.view.addSubview(frontCoin);
        view.addSubview(frontCoin)
        
        backCoin = UIImageView(frame: CGRect(x: (self.view.frame.size.width / 2) - 50, y: (self.view.frame.size.height / 2) - 50, width: 100, height: 100));
        let image2 = UIImage(named: "back");
        backCoin.image = image2;
        self.view.addSubview(backCoin);
        view.addSubview(backCoin)
        
        backCoin.isHidden = true
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUp)
        
        
        NSLayoutConstraint(item: frontCoin, attribute: .centerX, relatedBy: .equal, toItem: backCoin, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: backCoin, attribute: .centerY, relatedBy: .equal, toItem: frontCoin, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
                perform(#selector(flip), with: nil, afterDelay: 0);
                
                scrimView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height));
                scrimView.backgroundColor = UIColor.clear
                view.addSubview(scrimView);
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(stop))
                scrimView.addGestureRecognizer(tap)
            default:
                break
            }
        }
    }
    
    func stop() {
        print("STOP")
        self.frontCoin.layer.removeAllAnimations()
        self.backCoin.layer.removeAllAnimations()
    }

    func flip() {
        
        print("FLIP")
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromBottom, .showHideTransitionViews, .repeat]
        
        UIView.transition(with: frontCoin, duration: 0.25, options: transitionOptions, animations: {
            self.frontCoin.isHidden = !self.frontCoin.isHidden
        })
        
        UIView.transition(with: backCoin, duration: 0.25, options: transitionOptions, animations: {
            self.backCoin.isHidden = !self.backCoin.isHidden
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

