//
//  AppDelegate.swift
//  MenuBar
//
//  Created by Luka Kerr on 27/3/17.
//  Copyright © 2017 Luka Kerr. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  
  @IBOutlet weak var window: NSWindow!
  
  let popover = NSPopover()
  let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
  
  func showPopover(sender: AnyObject?) {
    if let button = statusItem.button {
      popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
    }
  }
  
  func closePopover(sender: AnyObject?) {
    popover.performClose(sender)
  }
  
  func togglePopover(sender: AnyObject?) {
    if popover.isShown {
      closePopover(sender: sender)
    } else {
      showPopover(sender: sender)
    }
  }
  
  func applicationDidFinishLaunching(_ notification: Notification) {
    if let button = statusItem.button {
      button.image = NSImage(named: "icon")
      button.target = self
      button.action = #selector(self.togglePopover(sender:))
    }
    popover.contentViewController = MenuViewController(nibName: "MenuViewController", bundle: nil)
  }
  
  
}
