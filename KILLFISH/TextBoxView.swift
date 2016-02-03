//
//  TextBoxView.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 30.01.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit

@IBDesignable
class TextBoxView: UIView {
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var img: UIImageView!
    
    @IBInspectable var text: String = "" {
        didSet {
            textBox.text=text
        }
    }
    
    @IBInspectable var placeHolder: String = "" {
        didSet {
            textBox.placeholder=placeHolder
        }
    }
    
    @IBInspectable var secureText: Bool = false {
        didSet {
            textBox.secureTextEntry=secureText
        }
    }
    
    @IBInspectable var editable: Bool = true {
        didSet {
            textBox.enabled = editable
        }
    }
    
    @IBInspectable var imageIco: UIImage = UIImage()  {
        didSet {
            img.image = imageIco
        }
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        view.backgroundColor = UIColor.clearColor()
        //text=""
    }
    
    
    /*@IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }*/

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    /*override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
        let view = NSBundle.mainBundle().loadNibNamed("TextBoxView", owner: self, options: nil)[0] as! UIView
        
        return view
    }*/
    
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
        let nib = UINib(nibName: "TextBoxView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    

}
