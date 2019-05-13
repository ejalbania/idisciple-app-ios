//
//  SocialViewController.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 28/04/2019.
//

import UIKit

class AboutViewController: UIViewController {

  @IBOutlet private weak  var lblAbout_title: UILabel!
  @IBOutlet private weak var lblAbout_body: UILabel!
  @IBOutlet private weak var lblAbout_footer: UILabel!
  
  fileprivate(set) var about:
    (title: String,  body: String, footer: String) = ("title","body","footer") {
    didSet {
      self.lblAbout_title.text = about.title
      self.lblAbout_body.text = about.body
      self.lblAbout_footer.text = about.footer
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setAbout(title: "Who We Are")
    self.setAbout(body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris mattis pharetra risus, eu dapibus lectus elementum vel. Sed varius, erat quis rhoncus aliquam, neque nunc commodo ligula, sed ultricies magna sapien facilisis ligula. Morbi eu lacus et ligula auctor pellentesque. Donec varius velit sed nisi tristique faucibus. Suspendisse arcu ipsum, pellentesque vel egestas a, porttitor at magna. \nCurabitur condimentum tellus sapien, quis varius mi auctor in. Integer finibus urna magna, quis lacinia magna eleifend eu. Proin et orci felis.  Donec ac tellus maximus, laoreet neque ut, porttitor mauris. Curabitur fermentum dolor non tempor porttitor. Curabitur in augue felis. Donec a turpis ut tortor bibendum vestibulum. Duis vitae vehicula odio. Quisque varius est tortor. Vivamus ultrices facilisis nisl, a tempor lectus tempor ac. Aenean at convallis est. Vivamus eu nisl diam. Maecenas mattis lorem a magna condimentum interdum.")
    self.setAbout(footer: "©Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris mattis pharetra risus, eu dapibus lectus elementum vel.")
  }
}

extension AboutViewController {
  @discardableResult
  func setAbout(title: String, body: String, footer: String) -> Self {
    self.about = (title: title, body: body, footer: footer)
    return self
  }
  
  @discardableResult
  func setAbout(title: String) -> Self {
    self.about.title = title
    return self
  }
  
  @discardableResult
  func setAbout(body: String) -> Self {
    self.about.body = body
    return self
  }
  
  @discardableResult
  func setAbout(footer: String) -> Self {
    self.about.footer = footer
    return self
  }
}
