//
//  SpeakersBioView.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 24/01/2019.
//

import UIKit
import PureLayout

class SpeakersBioView: UIView {

  var shouldSetupConstraints = true
  let screenSize = UIScreen.main.bounds
  let imageDimension = CGFloat(150)
  var adjustTextView = false

  lazy var overlayBackgroundView: UIView = {
    let view = UIView.newAutoLayout()
    view.backgroundColor = UIColor.withAlphaComponent(.black)(0.6)
    //view.backgroundColor = .white

    return view
  }()

  lazy var mainView: UIView = {
    let view = UIView.newAutoLayout()
    view.backgroundColor = UIColor.white

    view.autoSetDimensions(to: CGSize(width: screenSize.width - 70, height: screenSize.height - (screenSize.height/3)))

    view.layer.cornerRadius = 20.0

    return view
  }()

  lazy var speakersBioLabel: UILabel = {
    let label = UILabel.newAutoLayout()

    label.text = "SPEAKER'S BIO"
    label.textColor = .darkGray
    label.textAlignment = .center
    label.font = UIFont(name: "Montserrat-Bold", size: 14)
    label.numberOfLines = 1

    return label
  }()

  lazy var speakerImageView : UIImageView = {

    var image = UIImageView(image: UIImage(named: "courier"))
    image.autoSetDimensions(to: CGSize(width: imageDimension, height: imageDimension))
    image.backgroundColor = .darkGray

    image.layer.masksToBounds = false
    image.layer.cornerRadius = imageDimension/2
    image.clipsToBounds = true

    return image
  }()

  lazy var speakerNameLabel: UILabel = {
    let label = UILabel.newAutoLayout()
    //label.backgroundColor = .yellow
    label.text = "Speaker's Name Here"
    label.textColor = .black
    label.textAlignment = .center
    label.font = UIFont(name: "Montserrat-Bold", size: 22)
    label.numberOfLines = 2
    return label
  }()

  lazy var socialLabel: UILabel = {
    let label = UILabel.newAutoLayout()
    //label.backgroundColor = .yellow
    label.text = "socialmedia.com"
    label.textColor = .lightGray
    label.textAlignment = .center
    label.font = UIFont(name: "Montserrat-Bold", size: 16)
    label.numberOfLines = 1
    return label
  }()

  lazy var speakerDescriptionTextView: UITextView = {
    let textView = UITextView.newAutoLayout()
    textView.isEditable = false
    textView.textAlignment = NSTextAlignment.center
    textView.textColor = UIColor.black
    textView.backgroundColor = .white
    textView.font = UIFont(name: "Montserrat-Regular", size: 16)
    textView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

    //textView.backgroundColor = .gray

    return textView
  }()




  lazy var dismissButton : UIButton = {
    let button = UIButton.newAutoLayout()

    let attributedString = NSMutableAttributedString(string: "Dismiss")
    attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))

    button.setAttributedTitle(attributedString, for: .normal)
    button.titleLabel?.textColor = UIColor(red: 64/255, green: 142/255, blue: 192/255, alpha: 1)
    button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 22)

    return button
  }()

  /*
   // Only override draw() if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   override func draw(_ rect: CGRect) {
   // Drawing code
   }
   */

  var textViewWidthConstraint: NSLayoutConstraint?
  var textViewHeightConstraint: NSLayoutConstraint?


  override init(frame: CGRect) {
    super.init(frame: frame)

    self.addSubview(overlayBackgroundView)
    overlayBackgroundView.addSubview(mainView)

    mainView.addSubview(speakersBioLabel)
    mainView.addSubview(speakerImageView)
    mainView.addSubview(speakerNameLabel)
    mainView.addSubview(socialLabel)
    mainView.addSubview(speakerDescriptionTextView)

    mainView.addSubview(dismissButton)

    setAdjustTextView()

  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func updateConstraints() {
    if(shouldSetupConstraints) {

      // AutoLayout constraints
      //backgroundView.autoCenterInSuperview()

      overlayBackgroundView.autoPinEdge(toSuperviewEdge: .top)
      overlayBackgroundView.autoPinEdge(toSuperviewEdge: .left)
      overlayBackgroundView.autoPinEdge(toSuperviewEdge: .right)
      overlayBackgroundView.autoPinEdge(toSuperviewEdge: .bottom)

      mainView.autoAlignAxis(toSuperviewAxis: .vertical)
      mainView.autoAlignAxis(toSuperviewAxis: .horizontal)

      speakersBioLabel.autoPinEdge(.bottom, to: .top, of: mainView, withOffset:30)
      speakersBioLabel.autoAlignAxis(toSuperviewAxis: .vertical)

      speakerImageView.autoAlignAxis(toSuperviewAxis: .vertical)
      speakerImageView.autoPinEdge(.top, to: .bottom, of: speakersBioLabel, withOffset: imageDimension/3 - 20)

      speakerNameLabel.autoPinEdge(.top, to: .bottom, of: speakerImageView, withOffset:imageDimension/4 - 20)
      speakerNameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
      speakerNameLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
      //speakerNameLabel.autoAlignAxis(toSuperviewAxis: .vertical)

      socialLabel.autoPinEdge(.top, to: .bottom, of: speakerNameLabel, withOffset:5)
      socialLabel.autoAlignAxis(toSuperviewAxis: .vertical)

      dismissButton.autoPinEdge(.top, to: .bottom, of: mainView, withOffset: -50)
      dismissButton.autoAlignAxis(toSuperviewAxis: .vertical)

      speakerDescriptionTextView.autoPinEdge(.top, to: .bottom, of: socialLabel, withOffset:5)
      textViewWidthConstraint = speakerDescriptionTextView.autoSetDimension(.width, toSize: 50)
      textViewHeightConstraint = speakerDescriptionTextView.autoSetDimension(.height, toSize: 50)
      speakerDescriptionTextView.autoAlignAxis(toSuperviewAxis: .vertical)

      shouldSetupConstraints = false
    }

    //Update frame of textView
    if (adjustTextView){
      debugPrint("Adjust")
      textViewHeightConstraint?.constant = (dismissButton.frame.origin.y - socialLabel.frame.origin.y) - 55
      textViewWidthConstraint?.constant = mainView.frame.size.width - 60

      adjustTextView = false
    }


    super.updateConstraints()
  }

  func setAdjustTextView(){
    self.needsUpdateConstraints()
    self.updateConstraintsIfNeeded()
    self.layoutIfNeeded()

    adjustTextView = true

  }

}
