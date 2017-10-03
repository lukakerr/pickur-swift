//
//  MenuViewController.swift
//  MenuBar
//
//  Created by Luka Kerr on 27/3/17.
//  Copyright © 2017 Luka Kerr. All rights reserved.
//

import Cocoa

class MenuViewController: NSViewController {
  
  let fieldBackgroundColor = NSColor(red:0.15, green:0.15, blue:0.15, alpha:1.0)
  let fieldBorderColor = NSColor(red:0.15, green:0.15, blue:0.15, alpha:1.0)
  let fieldTextColor = NSColor(red:0.43, green:0.43, blue:0.43, alpha:1.0)
  
  @IBOutlet weak var hex: NSTextField!
  @IBOutlet weak var red: NSTextField!
  @IBOutlet weak var green: NSTextField!
  @IBOutlet weak var blue: NSTextField!
  @IBOutlet weak var hexOutput: NSTextField!
  @IBOutlet weak var rgbOutput: NSTextField!
  @IBOutlet weak var UIColorLabel: NSTextField!
  @IBOutlet weak var NSColorLabel: NSTextField!
  
  func setTextDesign(textField: NSTextField) {
    textField.wantsLayer = true
    let textFieldLayer = CALayer()
    textField.layer = textFieldLayer
    textField.backgroundColor = fieldBackgroundColor
    textField.layer?.backgroundColor = fieldBackgroundColor.cgColor
    textField.layer?.borderColor = fieldBorderColor.cgColor
    textField.layer?.borderWidth = 1
    textField.layer?.cornerRadius = 5
    textField.textColor = fieldTextColor
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setTextDesign(textField: hex)
    setTextDesign(textField: red)
    setTextDesign(textField: green)
    setTextDesign(textField: blue)
  }
  
  override func viewWillAppear() {
    self.view.window?.appearance = NSAppearance(named: NSAppearanceNameVibrantDark)
  }
  
  // HEX to RGB
  func hexToRgb(hex: String) -> (String, String, String) {
    if hex != "" {
      if hex.characters.count == 6 {
        let bigint = Int(hex, radix: 16)
        if bigint != nil {
          let r = (bigint! >> 16) & 255
          let g = (bigint! >> 8) & 255
          let b = bigint! & 255
          let hexUIColor = "UIColor(red: " + String(format: "%.2f", Double(r)/255) + ", green: " + String(format: "%.2f", Double(g)/255) + ", blue: " + String(format: "%.2f", Double(b)/255) + ", alpha: 1)"
          let hexNSColor = "NSColor(red: " + String(format: "%.2f", Double(r)/255) + ", green: " + String(format: "%.2f", Double(g)/255) + ", blue: " + String(format: "%.2f", Double(b)/255) + ", alpha: 1)"
          let rgbResult = "rgb(" + String(r) + ", " + String(g) + ", " + String(b) + ")"
          return(hexUIColor, hexNSColor, rgbResult)
        }
      }
    }
    return("", "", "")
  }
  
  // RGB to HEX
  func rgbToHex(r: String, g: String, b: String) -> (String, String, String) {
    if let r = Int(r), let g = Int(g), let b = Int(b) {
      if (0 ... 255 ~= r) && (0 ... 255 ~= g) && (0 ... 255 ~= b) {
        var result = String(((1 << 24) + (r << 16) + (g << 8) + b), radix: 16)
        result.remove(at: result.startIndex)
        let hexResult = "#" + result
        let rgbUIColor = "UIColor(red: " + String(format: "%.2f", Double(r)/255) + ", green: " + String(format: "%.2f", Double(g)/255) + ", blue: " + String(format: "%.2f", Double(b)/255) + ", alpha: 1)"
        let rgbNSColor = "NSColor(red: " + String(format: "%.2f", Double(r)/255) + ", green: " + String(format: "%.2f", Double(g)/255) + ", blue: " + String(format: "%.2f", Double(b)/255) + ", alpha: 1)"
        return(hexResult, rgbUIColor, rgbNSColor)
      }
    }
    return ("", "", "")
  }
  
  override func keyUp(with event: NSEvent) {
    let r = red.stringValue
    let g = green.stringValue
    let b = blue.stringValue
    
    let (hexUIColor, hexNSColor, rgbResult) = hexToRgb(hex: hex.stringValue)
    let (hexResult, rgbUIColor, rgbNSColor) = rgbToHex(r: r, g: g, b: b)
    
    // Show hexUIColor if rgbUIColor doesnt exists
    if rgbUIColor == "" {
      UIColorLabel.stringValue = hexUIColor
    } else {
      UIColorLabel.stringValue = rgbUIColor
    }
    
    // Show hexNSColor if rgbNSColor doesnt exist
    if rgbNSColor == "" {
      NSColorLabel.stringValue = hexNSColor
    } else {
      NSColorLabel.stringValue = rgbNSColor
    }
    
    // Show rgb input value if converted hex value doesnt exists
    if (r.characters.count > 0 && r.characters.count < 4) && (g.characters.count > 0 && g.characters.count < 4) && (b.characters.count > 0 && b.characters.count < 4) {
      rgbOutput.stringValue = "rgb(" + red.stringValue + ", " + green.stringValue + ", " + blue.stringValue + ")"
    } else {
      rgbOutput.stringValue = rgbResult
    }
    
    // Show hex input value if converted rgb value doesnt exists
    if hexResult == "" {
      if hex.stringValue.characters.count == 6 {
        hexOutput.stringValue = "#" + hex.stringValue.uppercased()
      } else {
        hexOutput.stringValue = ""
      }
    } else {
      hexOutput.stringValue = hexResult.uppercased()
    }
    
  }
  
  @IBAction func quit(_ sender: NSButton) {
    NSApplication.shared().terminate(self)
  }
  
  // Clear all input and labels when button pressed
  @IBAction func clear(_ sender: NSButton) {
    hex.stringValue = ""
    red.stringValue = ""
    green.stringValue = ""
    blue.stringValue = ""
    hexOutput.stringValue = ""
    rgbOutput.stringValue = ""
    UIColorLabel.stringValue = ""
    NSColorLabel.stringValue = ""
  }
}
