//
//  AppDelegate.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 28.01.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit
import HockeySDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SSASideMenuDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        let settings = UIApplication.sharedApplication().currentUserNotificationSettings()
        
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("error \(error)")
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let token = "\(deviceToken)"
        print(token)
        var str = deviceToken.description.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "<>"))
        str = str.stringByReplacingOccurrencesOfString(" ", withString: "")
        App.iostoken = str
    }
    
    func setupNotifications(){
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil))
        
        UIApplication.sharedApplication().registerForRemoteNotifications()
    }
    
    func setupToast(){
        JLToastView.setDefaultValue(
            UIColor.blackColor().colorWithAlphaComponent(0.7),
            forAttributeName: JLToastViewBackgroundColorAttributeName,
            userInterfaceIdiom: .Phone
        )
        
        JLToastView.setDefaultValue(
            UIColor.whiteColor().colorWithAlphaComponent(1),
            forAttributeName: JLToastViewTextColorAttributeName,
            userInterfaceIdiom: .Phone
        )
        
        JLToastView.setDefaultValue(
            UIFont(name: "Roboto-Light", size: 15)!,
            forAttributeName: JLToastViewFontAttributeName,
            userInterfaceIdiom: .Phone
        )
        
        JLToastView.setDefaultValue(
            NSNumber(float: 110),
            forAttributeName: JLToastViewPortraitOffsetYAttributeName,
            userInterfaceIdiom: .Phone
        )
        
        JLToastView.setDefaultValue(
            NSNumber(float: 0),
            forAttributeName: JLToastViewCornerRadiusAttributeName,
            userInterfaceIdiom: .Phone
        )
    }
    
    func setupToolbar()
    {
        let bgColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
        UIToolbar.appearance().setBackgroundImage(UIImage.initFromColor(bgColor),
            forToolbarPosition: UIBarPosition.Any,
            barMetrics: UIBarMetrics.Default)
        UIToolbar.appearance().setShadowImage(UIImage(),forToolbarPosition: UIBarPosition.Any)
        UIToolbar.appearance().translucent = true
    }
    
    func setupNavBar()
    {
        //NSUserDefaults.standardUserDefaults().setBool(false, forKey: "UIViewShowAlignmentRects")

        
        /*let verticalOffset: CGFloat = -4;
        UINavigationBar.appearance().setTitleVerticalPositionAdjustment(verticalOffset,forBarMetrics: UIBarMetrics.Default)*/
        //UINavigationBar.appearance().barTintColor = UIColor(red: 20, green: 20, blue: 20, alpha: 0.0)
        
        //UINavigationBar.appearance().alpha = 0.2;
        UINavigationBar.appearance().tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        //UINavigationBar.appearance().barTintColor = UIColor(red: 0, green: 0.4, blue: 0, alpha: 1)
        /*UINavigationBar.appearance().translucent = true
        
        let bounds = UINavigationBar.appearance().bounds as CGRect!
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
        visualEffectView.frame = bounds
        visualEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        UINavigationBar.appearance().addSubview(visualEffectView);
        UINavigationBar.appearance().backgroundColor = UIColor.clearColor();
        UINavigationBar.appearance().sendSubviewToBack(visualEffectView);*/
        
        let bgColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
        UINavigationBar.appearance().setBackgroundImage(UIImage.initFromColor(bgColor), forBarMetrics: UIBarMetrics.Default)
        
        //UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().translucent = true
        
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor(),NSFontAttributeName: UIFont(name: "Roboto-Light", size: 15)!];
        //UILabel.appearance().font = UIFont(name: "Roboto-Light", size: 15)
        
        UIBarButtonItem.appearance().setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Roboto-Light", size: 15)!], forState: UIControlState.Normal)
        
        /*let bgColorT = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        var backImg: UIImage = UIImage(named: "Cancel")!
        backImg = backImg.cropToBounds(15, height: 15)
        UIBarButtonItem.appearance().setBackButtonBackgroundImage(backImg, forState: .Normal, barMetrics: .Default)
        */
        
        let imgMenu = UIImage(named: "Back")!.alpha(0.5).cropImage(scaledToSize: CGSize(width: 20, height: 20)).imageWithAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: -3, right: 0))//.cropToBounds(15, height: 15).imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        //imgMenu.frame = CGRectMake(0, 0, 15,  15);
        
        /*let rectMenu = CGRect(x: 0, y: 0, width: 15, height: 15)
        let butMenu = UIButton(frame: rectMenu)
        butMenu.setBackgroundImage(imgMenu, forState: .Normal)
        butMenu.addTarget(self, action: "backButtonPressed:", forControlEvents: .TouchUpInside)
        navigationItem.backBarButtonItem = UIBarButtonItem(customView: butMenu);*/
        //navigationItem.backBarButtonItem?.setBackgroundImage(imgMenu, forState: .Normal, barMetrics: .Default)
        
        UINavigationBar.appearance().backIndicatorImage = imgMenu
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = imgMenu
        //UINavigationBar.appearance().backItem?.backBarButtonItem?.title = ""
        //UINavigationBar.appearance().backItem?.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
       
         //UINavigationBar.appearance().backItem?.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), forBarMetrics:UIBarMetrics.Default)
        
        
    }
    
    
    func setupSideMenu()
    {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        //MARK : Setup SSASideMenu
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("news")
        
        App.menu =  LeftMenuViewController()
        
        let sideMenu = SSASideMenu(contentViewController: UINavigationController(rootViewController: vc), leftMenuViewController: App.menu)
        sideMenu.backgroundImage = UIImage(named: "MainBackground.jpg")
        sideMenu.configure(SSASideMenu.MenuViewEffect(fade: true, scale: true, scaleBackground: false))
        sideMenu.configure(SSASideMenu.ContentViewEffect(alpha: 1.0, scale: 0.7))
        sideMenu.configure(SSASideMenu.ContentViewShadow(enabled: true, color: UIColor.blackColor(), opacity: 0.6, radius: 6.0))
        sideMenu.delegate = self
        
        window?.rootViewController = sideMenu
        window?.makeKeyAndVisible()
    }
    
    func setupHockeyApp(){
        BITHockeyManager.sharedHockeyManager().configureWithIdentifier("d876461354f84b50a2c0dc37740712c4")
        // Do some additional configuration if needed here
        BITHockeyManager.sharedHockeyManager().startManager()
        BITHockeyManager.sharedHockeyManager().authenticator.authenticateInstallation()
        
        //BITHockeyManager.sharedHockeyManager().testIdentifier()
    }


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        setupHockeyApp()
        setupToolbar()
        setupNavBar()
        setupSideMenu()
        setupToast()
        setupNotifications()
    
        
        return true
    }
    
    func sideMenuWillShowMenuViewController(sideMenu: SSASideMenu, menuViewController: UIViewController) {
        print("Will Show \(menuViewController)")
    }
    
    func sideMenuDidShowMenuViewController(sideMenu: SSASideMenu, menuViewController: UIViewController) {
        print("Did Show \(menuViewController)")
    }
    
    func sideMenuDidHideMenuViewController(sideMenu: SSASideMenu, menuViewController: UIViewController) {
        print("Did Hide \(menuViewController)")
    }
    
    func sideMenuWillHideMenuViewController(sideMenu: SSASideMenu, menuViewController: UIViewController) {
        print("Will Hide \(menuViewController)")
    }
    func sideMenuDidRecognizePanGesture(sideMenu: SSASideMenu, recongnizer: UIPanGestureRecognizer) {
        print("Did Recognize PanGesture \(recongnizer)")
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

