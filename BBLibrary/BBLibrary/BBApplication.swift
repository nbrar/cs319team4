//
//  AppDelegateSub.swift
//  Banking With Biometrics
//
//  Created by Jun on 2016-03-03.
//  Copyright © 2016 319ProjectTeam4. All rights reserved.
//

import UIKit

public class BBApplication: UIApplication {
    internal var library: BBLibrary
    
    //let serverIP = "ws://echo.websocket.org"
    let serverIP = "ws://btdemo.plurilock.com:8095"
    //let serverIP = "http://localhost:8080"
    let nc = NSNotificationCenter.defaultCenter()
    
    override init() {
        let configuration = BBConfiguration(serverIP: serverIP, domainID: "testDomainT4", cacheSize: 1024, sendRate: 10, enabledComponents: [.TouchEvents,.PhoneData], callback: {_ in})
        self.library = BBLibrary(args: configuration)
        self.library.setUserID("testUserT4")
//        self.delegate?.window = AppUiWin()
        super.init()
        nc.addObserver(self, selector: "launched", name: "UIApplicationDidFinishLaunchingNotification", object: nil)
        print("init")
    }
    
    func tap() {
        print("tap")
    }
    
    func launched() {
        let aSelector : Selector = "tap"
        let tapGesture = UITapGestureRecognizer(target: self, action: aSelector)
        tapGesture.numberOfTapsRequired = 1
        self.windows[0].rootViewController?.view.addGestureRecognizer(tapGesture)
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.windows[0].rootViewController?.view.addGestureRecognizer(swipeRight)
        
        var swipeDown = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.windows[0].rootViewController?.view.addGestureRecognizer(swipeDown)
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.Down:
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.Left:
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.Up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    override public func sendEvent(event: UIEvent) {
        print(self.applicationState.rawValue)
        super.sendEvent(event)
//        print(self.windows[0].rootViewController?.view, "UIWindow view")
        if event.type == UIEventType.Touches {
            BBApplication.sharedApplication().delegate?.performSelector("processEvent:",withObject: event)
        } else {
            print("notTouchEvent:", event)
        }
    }
    
}