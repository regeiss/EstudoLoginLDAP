//
//  Extensoes.swift
//  EstudoLoginLDAP
//
//  Created by Roberto Edgar Geiss on 20/12/19.
//  Copyright © 2019 Roberto Edgar Geiss. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
import QuartzCore

extension UIViewController
{
   func showIndicator(withTitle title: String, and Description:String) {
      let Indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
      Indicator.label.text = title
      Indicator.isUserInteractionEnabled = false
      Indicator.detailsLabel.text = Description
      Indicator.show(animated: true)
   }
    
   func hideIndicator()
   {
      MBProgressHUD.hide(for: self.view, animated: true)
   }
}
