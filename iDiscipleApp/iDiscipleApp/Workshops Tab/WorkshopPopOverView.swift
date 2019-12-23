//
//  WorkshopPopOverView.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 09/02/2019.
//

import UIKit

@objc protocol WorkshopPopOverViewDelegate {
    @objc optional func workshopPopOverViewDescriptionPressed() -> Void
    @objc optional func workshopPopOverViewOutlinePressed() -> Void
    //func customAlertDidPressDismiss(_ customAlert: CustomAlertController) -> Void
    //@objc optional func customAlertDidPressOk(_ customAlert: CustomAlertController) -> Void
}

class WorkshopPopOverView: UIView {
    
    var delegate : WorkshopPopOverViewDelegate?

    lazy var viewDescriptionBtn: UIButton = {
        
        let button = UIButton.newAutoLayout()
        button.setTitle("View Description", for: .normal)
        //button.layer.borderWidth = 1;
        button.setTitleColor(.black, for: .normal)
        button.autoSetDimensions(to: CGSize(width: 210, height: 40))
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 20)
        button.titleLabel?.textAlignment = .left
        
        return button
    }()
    
    lazy var viewOutlineBtn: UIButton = {
        
        let button = UIButton.newAutoLayout()
        button.setTitle("View Outline", for: .normal)
        //button.layer.borderWidth = 1
        button.setTitleColor(.black, for: .normal)
        button.autoSetDimensions(to: CGSize(width: 210, height: 40))
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 20)
        button.titleLabel?.textAlignment = .left
        
        return button
    }()
    
    
    var shouldSetupConstraints = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //self.appHelper.dropShadow1()
        //self.layer.borderWidth = 1
        //self.layer.borderColor = UIColor.lightGray.cgColor
        
        viewDescriptionBtn.addTarget(self, action: #selector(viewDescriptionPressed), for: .touchUpInside)
        viewOutlineBtn.addTarget(self, action: #selector(viewOutlinePressed), for: .touchUpInside)

        
        self.addSubview(viewDescriptionBtn)
        self.addSubview(viewOutlineBtn)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        if(shouldSetupConstraints) {
            
            // AutoLayout constraints
            viewDescriptionBtn.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
            viewDescriptionBtn.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
            
            viewOutlineBtn.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
            viewDescriptionBtn.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
            
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }
    
    @IBAction func viewDescriptionPressed(sender: UIButton!){
        delegate?.workshopPopOverViewDescriptionPressed!()
    }
    
    @IBAction func viewOutlinePressed(sender: UIButton!){
        delegate?.workshopPopOverViewOutlinePressed!()
    }

}
