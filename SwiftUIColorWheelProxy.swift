//
//  SwiftUIColorWheelProxy.swift
//  lava
//
//  Created by Ryan Sam on 11/27/20.
//

import SwiftUI

@objcMembers class SwiftUIColorWheelProxy: NSObject {
  private var vc = UIHostingController(rootView: ColorWheelView())
  var view: UIView {
    return vc.view
  }
}
