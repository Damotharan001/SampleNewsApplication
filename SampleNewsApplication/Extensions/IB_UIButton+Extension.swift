//
//  IB_UIButton+Extension.swift
//  SampleNewsApplication
//
//  Created by Damotharan KG on 10/02/25.
//


import Foundation
import UIKit

@IBDesignable
class UIButtonCustom : UIButton{
    
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
    
    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
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
