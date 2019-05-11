//
//  MapView.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 08/05/2019.
//

import UIKit

class MapView: UIView, UIScrollViewDelegate {

    var shouldSetupConstraints = true
    let screenSize = UIScreen.main.bounds
    let imageDimension = CGFloat(100)
    
    var gestureRecognizer: UITapGestureRecognizer!
    
    lazy var backgroundView: UIView = {
        let view = UIView.newAutoLayout()
        //view.backgroundColor = UIColor.withAlphaComponent(.black)(0.6)
        view.backgroundColor = .white
        
        return view
    }()
    
    lazy var scrollView : UIScrollView = {
        let view = UIScrollView.newAutoLayout()
        view.autoSetDimensions(to: CGSize(width: self.screenSize.width, height: self.screenSize.height - 60))
        //view.contentSize = (CGSize(width: 375, height: 667))
        //view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var mapImageView : UIImageView = {
        let imageView = UIImageView.newAutoLayout()
        imageView.autoSetDimensions(to: CGSize(width: self.screenSize.width, height: self.screenSize.height - 70))
        imageView.image = UIImage(named: "pbts_map_320")
        
        return imageView
    }()
    
    lazy var bottomView : UIView = {
        let view = UIView.newAutoLayout()
        view.autoSetDimensions(to: CGSize(width: self.screenSize.width, height: 50))
        view.backgroundColor = .black
        return view
    }()
    
    lazy var backButton : UIButton = {
        let button = UIButton(type: .custom)
        button.autoSetDimensions(to: CGSize(width: self.screenSize.width/4, height: 50))
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 20)
        //button.backgroundColor = UIColor(red: 118/255, green: 173/255, blue: 92/255, alpha: 1)
        button.setImage(UIImage(named: "icon_back"), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        button.setTitle("BACK", for: .normal)
        //button.titleLabel?.textColor = .white
        button.setTitleColor(.lightGray, for: .normal)

        //button.layer.borderColor = (UIColor.white).cgColor
        //button.layer.borderWidth = 1.0
        
        return button
    }()
    
    lazy var legendButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: "icon_menu2"), for: .normal)
        
        return button
    }()
    
    lazy var mapLegendTableView : UITableView = {
        let tableView = UITableView.newAutoLayout()
        tableView.backgroundColor = .white
        tableView.autoSetDimensions(to: CGSize(width: screenSize.width, height: screenSize.height - 50))
        tableView.separatorStyle = .none
        
        tableView.rowHeight = 60
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(backgroundView)
        
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        scrollView.zoomScale = 1.0
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        backgroundView.addSubview(scrollView)
        
        //mapImageView.frame = scrollView.frame
        mapImageView.contentMode = .scaleAspectFit
        scrollView.addSubview(mapImageView)
        
        backgroundView.addSubview(legendButton)
        backgroundView.addSubview(mapLegendTableView)
        
        backgroundView.addSubview(bottomView)
        bottomView.addSubview(backButton)
        
        setupGestureRecognizer()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        if(shouldSetupConstraints) {
            
            // AutoLayout constraints
            //backgroundView.autoCenterInSuperview()
            
            backgroundView.autoPinEdge(toSuperviewEdge: .top)
            backgroundView.autoPinEdge(toSuperviewEdge: .left)
            backgroundView.autoPinEdge(toSuperviewEdge: .right)
            backgroundView.autoPinEdge(toSuperviewEdge: .bottom)
            
            scrollView.autoAlignAxis(toSuperviewAxis: .vertical)
            scrollView.autoAlignAxis(toSuperviewAxis: .horizontal)
            
            //bottomView.autoAlignAxis(toSuperviewAxis: .horizontal)
            //bottomView.autoPinEdge(.bottom, to: .top, of: backgroundView, withOffset: 0)
            bottomView.autoPinEdge(toSuperviewEdge: .left)
            bottomView.autoPinEdge(toSuperviewEdge: .right)
            bottomView.autoPinEdge(toSuperviewEdge: .bottom)
            
            backButton.autoAlignAxis(toSuperviewAxis: .horizontal)
            backButton.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
            
            legendButton.autoPinEdge(.bottom, to: .top, of: backgroundView, withOffset: self.screenSize.height/5)
            legendButton.autoPinEdge(.right, to: .left, of: backgroundView, withOffset: self.screenSize.width/5)
            
            //mapLegendTableView.autoPinEdge(.bottom, to: .top, of: backgroundView, withOffset: self.screenSize.height - 50)
            
            //mapImageView.autoAlignAxis(toSuperviewAxis: .vertical)
            //mapImageView.autoAlignAxis(toSuperviewAxis: .horizontal)
            
            shouldSetupConstraints = false
        }
        
        super.updateConstraints()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mapImageView
    }
    
    func setupGestureRecognizer() {
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        gestureRecognizer.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(gestureRecognizer)
    }
    
    @IBAction func handleDoubleTap() {
        if scrollView.zoomScale == 1 {
            scrollView.zoom(to: zoomRectForScale(2, center: gestureRecognizer.location(in: gestureRecognizer.view)), animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }
    
    // Calculates the zoom rectangle for the scale
    func zoomRectForScale(_ scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = mapImageView.frame.size.height / scale
        zoomRect.size.width = mapImageView.frame.size.width / scale
        let newCenter = convert(center, from: mapImageView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }


}
