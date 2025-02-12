//
//  IB_UIView+Extension.swift
//  SampleNewsApplication
//
//  Created by Damotharan KG on 10/02/25.
//


import Foundation
import UIKit


@IBDesignable
class UIViewCustom : UIView{
    
    @IBInspectable var cornerRadius : CGFloat = 0.0{
        didSet{
            setCorner()
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = 0.0{
        didSet{
            setCorner()
        }
    }
    
    @IBInspectable var shadowRadius : CGFloat = 0.5 {
        didSet{
            dropShadow()
        }
    }
    
    @IBInspectable var borderColor : UIColor = UIColor.gray{
        didSet{
            setCorner()
        }
    }
    
    @IBInspectable var addShadow : Bool = false{
        didSet{
            dropShadow()
        }
    }
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0){
        didSet{
            dropShadow()
        }
    }
    @IBInspectable var shadowOpacity: Float = 0.0{
        didSet{
            dropShadow()
        }
    }
    @IBInspectable var shadowColor : UIColor = UIColor.gray{
        didSet{
            dropShadow()
        }
    }
   
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
//        layer.shouldRasterize = true
    }
    func setCorner(){
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

@IBDesignable
class UIStackViewCustom : UIStackView{
    
    @IBInspectable var cornerRadius : CGFloat = 0.0{
        didSet{
            setCorner()
        }
    }
    
    func setCorner(){
        self.layer.cornerRadius = cornerRadius
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}




