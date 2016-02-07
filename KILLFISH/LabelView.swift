//
//  LabelView.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 06.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

@IBDesignable
class LabelView: UIView {
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var textView: UITextField!
    
    @IBInspectable var label: String = "" {
        didSet {
            labelView.text = label
        }
    }
    
    @IBInspectable var text: String = "" {
        didSet {
            textView.text = text
        }
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
        let nib = UINib(nibName: "LabelView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    
    
    
}
