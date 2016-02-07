//
//  FlatSwitchView.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 06.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

@IBDesignable
class FlatSwitchView: UIView {
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var labelLeft: UILabel!
    @IBOutlet weak var labelRight: UILabel!
    
    var isRight: Bool {
        let ciL = CoreImage.CIColor(color: leftView.backgroundColor!)
        let ciR = CoreImage.CIColor(color: rightView.backgroundColor!)
        return ciL.alpha<ciR.alpha
    }
    
    var switched: (sender: AnyObject) -> () = {_ in }
    
    @IBInspectable var right: Bool = false {
        didSet {
            if right{
                leftView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
                rightView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
            }else{
                leftView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
                rightView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
            }
        }
    }
    
    @IBInspectable var textLeft: String = "" {
        didSet {
            labelLeft.text = textLeft
        }
    }
    
    @IBInspectable var textRight: String = "" {
        didSet {
            labelRight.text = textRight
        }
    }
    @IBAction func leftTapped(sender: AnyObject) {
        right = false
        switched(sender: self)
    }
    @IBAction func rightTapped(sender: AnyObject) {
        right = true
        switched(sender: self)
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        view.backgroundColor = UIColor.clearColor()
    }

    var view: UIView!
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        setup()
    }
    
    
    func setup()
    {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        addSubview(view)
    }
    
    
    func loadViewFromNib() -> UIView
    {
        let bundle = NSBundle(forClass:self.dynamicType)
        let nib = UINib(nibName: "FlatSwitchView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    


}
