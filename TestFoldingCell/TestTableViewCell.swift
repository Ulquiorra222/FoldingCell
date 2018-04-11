//
//  TestTableViewCell.swift
//  TestFoldingCell
//
//  Created by dong po luo on 2018/3/20.
//  Copyright © 2018年 dong po luo. All rights reserved.
//

import UIKit

class TestTableViewCell: UITableViewCell, CAAnimationDelegate{

    @IBOutlet weak var forgroundView: UIView!
    @IBOutlet weak var constrainView: UIView!
    
    @IBOutlet weak var openNumber: UILabel!
    @IBOutlet weak var closeNumber: UILabel!
    
   
    @IBOutlet weak var foreguoundTop: NSLayoutConstraint!
    @IBOutlet weak var constrainTop: NSLayoutConstraint!
    
    @IBInspectable open var itemCount: NSInteger = 2
    @IBInspectable open var backViewColor: UIColor = UIColor.groupTableViewBackground
    
    
    
    var number: Int = 0 {
        didSet{
            openNumber.text = String(number)
            closeNumber.text = String(number)
        }
    }
    
    
    
    var animationViews = UIView()
    var firstImageView = UIImageView()
    var secondImageView = UIImageView()
    var secondImagebgView = UIImageView()
    var thirdImageView: [UIImageView] = []
    var fourthImageView = UIImageView()
    var firstViewBg = UIImageView()
    var thirdViewBg: [UIImageView] = []
    var thirdViewNumber = 0
    
    
    
    var animation1 = CABasicAnimation()
    var animation2 = CABasicAnimation()
    var animation3 = CABasicAnimation()
    var backAnimation = CABasicAnimation()
    var backAnimation1 = CABasicAnimation()
    var backAnimation2 = CABasicAnimation()
    
    
    var imageView1 = UIImageView()
    
    var animationTransform = CATransform3DIdentity
    

    public func startAnimation() {
        creatAnimationView()
        forgroundView.alpha = 0
        animationViews.alpha = 1
        firstViewBg.alpha = 1
        firstImageView.alpha = 1
        firstViewBg.layer.shouldRasterize = true
        if itemCount > 1 {
            firstImageView.layer.add(animation1, forKey: "firstImageView")
        } else {
            animationViews.alpha = 0
            constrainView.alpha = 1
        }
        
    }
    
    public func endAnimation() {
        constrainView.alpha = 0
        animationViews.alpha = 1
        forgroundView.alpha = 1
        if itemCount > 1 {
            fourthImageView.layer.add(backAnimation, forKey: "backAnimation")
        } else {
            animationViews.alpha = 0
            forgroundView.alpha = 1
        }
        
    }
    
    public func hiddenView() {
        
        firstImageView.layer.removeAllAnimations()
        secondImageView.layer.removeAllAnimations()
        secondImagebgView.layer.removeAllAnimations()
        for i in 0..<thirdImageView.count {
            thirdImageView[i].layer.removeAllAnimations()
        }
        fourthImageView.layer.removeAllAnimations()

        constrainView.alpha = 0
        forgroundView.alpha = 1
        animationViews.alpha = 0
        firstImageView.alpha = 0
        secondImageView.alpha = 0
        secondImagebgView.alpha = 0
        for i in 0..<thirdViewBg.count {
            thirdViewBg[i].alpha = 0

        }
        fourthImageView.alpha = 0
        thirdViewNumber = 0
        animationViews.removeFromSuperview()

        
    }
    
//    func animationDidStart(_ anim: CAAnimation) {
//      if anim == firstImageView.layer.animation(forKey: "firstImageView") {
//        firstImageView.layer.shouldRasterize = true
//        }
//    }
    
    
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        
        //start animation
        if anim == firstImageView.layer.animation(forKey: "firstImageView") {
            firstImageView.alpha = 0
            secondImageView.alpha = 1
            secondImagebgView.alpha = 1
            firstViewBg.layer.masksToBounds = false
            secondImageView.layer.add(animation2, forKey: "secondImageView")
        }
        if anim == secondImageView.layer.animation(forKey: "secondImageView") {
            if itemCount > 2 {
                secondImageView.alpha = 1
                if thirdImageView.count > 0 {
                    secondImagebgView.alpha = 0
                    thirdImageView[0].alpha = 1
                    thirdImageView[0].frame = CGRect(x: 0, y: forgroundView.frame.height * 2 - secondImagebgView.frame.height, width: constrainView.frame.width, height: secondImagebgView.frame.height)
                    thirdImageView[0].layer.add(animation3, forKey: "animation")
                } else if itemCount == 3 {
                    secondImagebgView.layer.add(animation1, forKey: "secondImagebgView")
                }
            } else if itemCount == 2 {
                constrainView.alpha = 1
                animationViews.alpha = 0
            }
            

        }
        if thirdImageView.count > 0 {
            if anim == thirdImageView[thirdViewNumber].layer.animation(forKey: "animation") {
                thirdViewBg[thirdViewNumber].alpha = 1
                thirdImageView[thirdViewNumber].frame = thirdViewBg[thirdViewNumber].frame
                if thirdViewNumber == thirdViewBg.count - 1 {
                    thirdImageView[thirdViewNumber].layer.add(animation1, forKey: "thirdImageView")
                } else {
                    thirdViewNumber += 1
                    thirdImageView[thirdViewNumber].layer.add(animation3, forKey: "animation")
                }
            }
            
            
            if anim == thirdImageView[thirdImageView.count - 1].layer.animation(forKey: "thirdImageView") {
                fourthImageView.alpha = 1
                thirdImageView[thirdImageView.count - 1].alpha = 0
                fourthImageView.layer.add(animation2, forKey: "fourthImageView")
                
            }
        }
        
        if anim == secondImagebgView.layer.animation(forKey: "secondImagebgView") {
            secondImagebgView.alpha = 0
            fourthImageView.alpha = 1
            fourthImageView.layer.add(animation2, forKey: "fourthImageView")
        }
        
        
        
        if anim == fourthImageView.layer.animation(forKey: "fourthImageView") {
            fourthImageView.alpha = 1
            constrainView.alpha = 1
            animationViews.alpha = 0
            
        }
        
        
        
        //end animation
        
        if anim == fourthImageView.layer.animation(forKey: "backAnimation") {
            if itemCount > 2 {
                fourthImageView.alpha = 0
                if thirdImageView.count > 0 {
                    thirdImageView[thirdViewNumber].frame = thirdViewBg[thirdViewNumber].frame
                    thirdImageView[thirdViewNumber].alpha = 1
                    thirdImageView[thirdViewNumber].layer.add(backAnimation1, forKey: "backAnimation1")
                } else if itemCount == 3 {
                    secondImagebgView.alpha = 1
                    secondImagebgView.layer.add(backAnimation1, forKey: "backAnimation1")
                }
            }else if itemCount == 2 {
                secondImageView.layer.add(backAnimation, forKey: "backAnimation")
            }
        }


        if thirdImageView.count > 0 {
            if anim == thirdImageView[thirdViewNumber].layer.animation(forKey: "backAnimation1") {
                thirdViewBg[thirdViewNumber].alpha = 0
                if thirdViewNumber != 0 {
                    thirdViewNumber -= 1
                    thirdImageView[thirdViewNumber].frame = thirdViewBg[thirdViewNumber].frame
                    thirdImageView[thirdViewNumber].layer.add(backAnimation2, forKey: "backAnimation1")
                } else  {
                    thirdImageView[thirdViewNumber].frame = CGRect(x: 0, y: forgroundView.frame.height * 2 - secondImagebgView.frame.height, width: constrainView.frame.width, height: secondImagebgView.frame.height)
                    thirdImageView[thirdViewNumber].layer.add(backAnimation2, forKey: "backAnimation2")
                }
                
            }
            
            
            if anim == thirdImageView[0].layer.animation(forKey: "backAnimation2") {
                thirdImageView[0].alpha = 0
                secondImagebgView.alpha = 1
                secondImageView.layer.add(backAnimation, forKey: "backAnimation")
            }
        }
        
        if anim == secondImagebgView.layer.animation(forKey: "backAnimation1") {
            secondImageView.layer.add(backAnimation, forKey: "backAnimation")
        }
        
        
        if anim == secondImageView.layer.animation(forKey: "backAnimation"){
            secondImageView.alpha = 0
            firstImageView.alpha = 1
            firstViewBg.layer.masksToBounds = true
            firstImageView.layer.add(backAnimation1, forKey: "backAnimation1")
        }
        if anim == firstImageView.layer.animation(forKey: "backAnimation1"){
            firstViewBg.alpha = 0
            hiddenView()

        }
        
        
        
    }
    
    override func draw(_ rect: CGRect) {
   
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }
    
    func setup() {
        guard let foreguoundTop = self.foreguoundTop, let constrainTop = self.constrainTop else {
            fatalError("set constrans outlets")
        }
        
        constrainTop.constant = foreguoundTop.constant
        animationTransform.m34 = -2.5 / 2000
        
        setAnimation()
        
        forgroundView.layer.cornerRadius = 10
        forgroundView.layer.masksToBounds = true
        constrainView.layer.cornerRadius = 10
        constrainView.layer.masksToBounds = true
        
        hiddenView()
        
    }
    
    func creatAnimationView() {
        
        constrainView.alpha = 1
        
        if itemCount > 3 {
            thirdViewBg = [UIImageView](repeatElement(UIImageView(), count: itemCount - 3))
            thirdImageView = [UIImageView](repeatElement(UIImageView(), count: itemCount - 3))
            
        }
       
        animationViews = UIView(frame: CGRect(x: forgroundView.frame.minX, y: forgroundView.frame.minY, width: constrainView.frame.width, height: constrainView.frame.height
        ))
        
        let firstImage = constrainView.setSampleView(frame: CGRect(x: constrainView.bounds.minX, y: constrainView.bounds.minY, width: forgroundView.frame.width, height: forgroundView.frame.height))
        firstViewBg = UIImageView(image: firstImage)
        firstViewBg.frame = CGRect(x: constrainView.bounds.minX, y: constrainView.bounds.minY, width: forgroundView.frame.width, height: forgroundView.frame.height)
        firstViewBg.alpha = 0
        firstViewBg.layer.cornerRadius = 10
        firstViewBg.layer.masksToBounds = true
        animationViews.addSubview(firstViewBg)
        
        
        let forgroundViewImage = forgroundView.setSampleView(frame: forgroundView.bounds)
        firstImageView = UIImageView(image: forgroundViewImage)
        firstImageView.frame = forgroundView.bounds
        firstImageView.layer.cornerRadius = 10
        firstImageView.layer.masksToBounds = true
        firstImageView.layer.transform = animationTransform
        
        animationViews.addSubview(firstImageView)
        
        var imageFrame = firstImageView.frame
        firstImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        firstImageView.frame = imageFrame
        
        
        let secondImage = constrainView.setSampleView(frame: CGRect(x: 0, y: forgroundView.bounds.height, width: forgroundView.frame.width, height: forgroundView.frame.height))
        secondImageView = UIImageView(image: secondImage)
        secondImageView.frame = CGRect(x: 0, y: forgroundView.bounds.height, width: forgroundView.frame.width, height: forgroundView.frame.height)
        secondImageView.layer.transform = animationTransform
        animationViews.addSubview(secondImageView)
        firstImageView.alpha = 0
        
        imageFrame = secondImageView.frame
        secondImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        secondImageView.frame = imageFrame
        secondImageView.alpha = 0
        
        let itemHeight = (constrainView.frame.height - forgroundView.frame.height * 2) / CGFloat(itemCount - 2)
        
        
        if itemHeight > 0 && itemCount > 2 {

            for i in 0..<thirdViewBg.count {
                let thirdImage = constrainView.setSampleView(frame: CGRect(x: 0, y: forgroundView.bounds.height * 2.0 + CGFloat(i) * itemHeight, width: forgroundView.frame.width, height: itemHeight))
                thirdViewBg[i] = UIImageView(image: thirdImage)
                thirdViewBg[i].frame = CGRect(x: 0, y: forgroundView.bounds.height * 2.0 + CGFloat(i) * itemHeight, width: forgroundView.frame.width, height: itemHeight)
                thirdViewBg[i].alpha = 0
                animationViews.addSubview(thirdViewBg[i])
                
                thirdImageView[i].backgroundColor = backViewColor
                thirdImageView[i].frame = thirdViewBg[i].frame
                thirdImageView[i].layer.transform = animationTransform
                animationViews.addSubview(thirdImageView[i])
                
                imageFrame = thirdViewBg[i].frame
                thirdImageView[i].layer.anchorPoint = CGPoint(x: 0.5, y: 1)
                thirdImageView[i].frame = imageFrame
                thirdImageView[i].alpha = 0
            }
            
            secondImagebgView.backgroundColor = backViewColor
            secondImagebgView.frame = CGRect(x: 0, y: secondImageView.frame.height - itemHeight , width: constrainView.frame.width, height: itemHeight)
            
            imageFrame = secondImagebgView.frame
            secondImagebgView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
            secondImagebgView.frame = imageFrame
            secondImagebgView.layer.transform = animationTransform
            secondImageView.addSubview(secondImagebgView)
            
            
            
            
            let fifthImage = constrainView.setSampleView(frame: CGRect(x: 0, y: constrainView.bounds.height - itemHeight, width: forgroundView.frame.width, height: itemHeight))
            fourthImageView = UIImageView(image: fifthImage)
            fourthImageView.frame = CGRect(x: 0, y: constrainView.bounds.height - itemHeight, width: forgroundView.frame.width, height: itemHeight)
            fourthImageView.layer.transform = animationTransform
            fourthImageView.layer.cornerRadius = 10
            animationViews.addSubview(fourthImageView)
            
            imageFrame = fourthImageView.frame
            fourthImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
            fourthImageView.frame = imageFrame
            fourthImageView.alpha = 0
            fourthImageView.layer.transform = animationTransform
            
        }
        
        self.contentView.addSubview(animationViews)
        self.contentView.bringSubview(toFront: animationViews)
        constrainView.alpha = 0
        
    }
    
    func setAnimation() {
        
        let duration = 0.2
        
        animation1 = CABasicAnimation(keyPath: "transform.rotation.x")
        animation1.fromValue = 0
        animation1.toValue = -CGFloat.pi / 2.0
        animation1.duration = 0.13
        animation1.isRemovedOnCompletion = false
        animation1.fillMode = kCAFillModeForwards
        animation1.delegate = self
        
        animation2 = CABasicAnimation(keyPath: "transform.rotation.x")
        animation2.fromValue = CGFloat.pi / 2.0
        animation2.toValue = 0
        animation2.duration = 0.13
        animation2.isRemovedOnCompletion = false
        animation2.fillMode = kCAFillModeForwards
        animation2.delegate = self
        
        animation3 = CABasicAnimation(keyPath: "transform.rotation.x")
        animation3.fromValue = 0
        animation3.toValue = -CGFloat.pi
        animation3.duration = duration
        animation3.isRemovedOnCompletion = false
        animation3.fillMode = kCAFillModeForwards
        animation3.delegate = self

        
        backAnimation = CABasicAnimation(keyPath: "transform.rotation.x")
        backAnimation.fromValue = 0
        backAnimation.toValue = CGFloat.pi / 2.0
        backAnimation.duration = duration / 2.0
        backAnimation.isRemovedOnCompletion = false
        backAnimation.fillMode = kCAFillModeForwards
        backAnimation.delegate = self
        
        
        backAnimation1 = CABasicAnimation(keyPath: "transform.rotation.x")
        backAnimation1.fromValue = CGFloat.pi / 2.0 * 3.0
        backAnimation1.toValue = CGFloat.pi * 2.0
        backAnimation1.duration = duration / 2.0
        backAnimation1.isRemovedOnCompletion = false
        backAnimation1.fillMode = kCAFillModeForwards
        backAnimation1.delegate = self
        
        backAnimation2 = CABasicAnimation(keyPath: "transform.rotation.x")
        backAnimation2.fromValue = -CGFloat.pi
        backAnimation2.toValue = 0
        backAnimation2.duration = duration
        backAnimation2.isRemovedOnCompletion = false
        backAnimation2.fillMode = kCAFillModeForwards
        backAnimation2.delegate = self
        

    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
//open class animationView: UIView {
//    
//}

public extension UIView {
    func setSampleView(frame: CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            print("fail")
            return nil

        }
        context.translateBy(x: frame.origin.x * -1   , y: frame.origin.y * -1 )
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    
}


    






