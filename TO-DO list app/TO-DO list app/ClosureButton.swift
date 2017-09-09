//
//  ClosureButton.swift
//  TO-DO list app
//
//  Created by NSMohamedElalfy on 9/8/17.
//  Copyright © 2017 NSMohamedElalfy. All rights reserved.
//

import Foundation


import UIKit

class UIClosureButton: UIButton {
    
    typealias DidTapButton = (UIClosureButton) -> ()
    
    var didTouchUpInside: DidTapButton? {
        didSet {
            if didTouchUpInside != nil {
                addTarget(self, action: #selector(didTouchUpInside(_:)), for: .touchUpInside)
            } else {
                removeTarget(self, action: #selector(didTouchUpInside(_:)), for: .touchUpInside)
            }
        }
    }
    
    // MARK: - Actions
    @objc private func didTouchUpInside(_ sender: UIButton) {
        if let handler = didTouchUpInside {
            handler(self)
        }
    }
    
}


class UIClosureBarButton: UIBarButtonItem {
  
  typealias DidTapButton = (UIClosureBarButton) -> ()
  
  var didTouchUpInside: DidTapButton? {
    didSet {
      if didTouchUpInside != nil {
        action = #selector(didTouchUpInside(_:))
        target = self
      } else {
        action = nil
        target = nil
      }
    }
  }
  
  convenience init(image: UIImage?, style: UIBarButtonItemStyle) {
    self.init(image:image,style:style,target:nil,action:nil)
  }
  
  convenience init(image: UIImage?, landscapeImagePhone: UIImage?, style: UIBarButtonItemStyle){
    self.init(image: image, landscapeImagePhone: landscapeImagePhone, style: style, target: nil, action: nil)
  }
  
  convenience init(title: String?, style: UIBarButtonItemStyle){
    self.init(title: title, style: style, target: nil, action: nil)
  }
  
  convenience init(barButtonSystemItem : UIBarButtonSystemItem){
    self.init(barButtonSystemItem : barButtonSystemItem, target: nil, action: nil)
  }
  
  // MARK: - Actions
  @objc private func didTouchUpInside(_ sender: UIBarButtonItem) {
    if let handler = didTouchUpInside {
      handler(self)
    }
  }
  
}
