//
//  ViewController.swift
//  SampleNativeApp
//
//  Created by Venkata ramana Kunapuli on 12/1/17.
//  Copyright © 2017 Venkata ramana Kunapuli. All rights reserved.
//

import UIKit
import os.log

//MARK: Enums
enum SideMenuState {
    case Opened
    case Closed
}
class ViewController: UIViewController, SideMenuDelegate, SideMenuClickDelegate {
    
    
    //    MARK: Properties
    var centerNavigationController: UINavigationController!
    
    var myActivitesViewController: PageViewController!
    var myWorldViewController: PageViewController!
    var myPlacesViewController: PageViewController!
    var myMoneyViewController: PageViewController!
    var myPreferencesViewController: PageViewController!
    var myProfileViewController: PageViewController!
    
    var allowedMenuGesture: Bool = false
    
    
    var sideMenuState: SideMenuState = .Closed {
        didSet {
            let showShadow = sideMenuState != .Closed
            showShadowForCenterViewController(shouldShowShadow: showShadow)
        }
    }
    
    var sideMenuController: SideMenuViewController!
    let sideMenuWidth: CGFloat = 250
    
    let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    //    MARK: Custom Methods
    
    func togglePanel() {
        let notAlreadyExpanded = (sideMenuState != .Opened)
        if notAlreadyExpanded {
            addPanelViewController()
            animateLeftPanel(shouldExpand: true)
            
        }
        else {
            animateLeftPanel(shouldExpand: false)
        }
    }
    
    func collapseSidePanels() {
        switch sideMenuState {
        case .Opened:
            togglePanel()
        default:
            break
        }
    }
    
    private func addPanelViewController() {
        if(sideMenuController == nil) {
            
            sideMenuController = mainStoryboard.instantiateViewController(withIdentifier: "SideMenu") as? SideMenuViewController
            
            addChildSidePanelController(menu: sideMenuController)
        }
    }
    
    private func addChildSidePanelController(menu: SideMenuViewController) {
        view.insertSubview(menu.view, at: 0)
        addChildViewController(menu)
        menu.didMove(toParentViewController: self)
    }
    
    private func animateRightPanel(shouldExpand: Bool) {
        if shouldExpand {
            sideMenuState = .Opened
            animateCenterPanelXPosition(targetPosition: -sideMenuWidth)
        }
        else {
            animateCenterPanelXPosition(targetPosition: 0) {
                // Completion anonymous function
                _ in
                self.sideMenuState = .Closed
                self.sideMenuController!.view.removeFromSuperview()
                self.sideMenuController = nil
            }
        }
    }
    
    private func animateLeftPanel(shouldExpand: Bool) {
        if shouldExpand {
            sideMenuState = .Opened
            animateCenterPanelXPosition(targetPosition: sideMenuWidth)
        }
        else {
            animateCenterPanelXPosition(targetPosition: 0) {
                // Completion anonymous function
                _ in
                self.sideMenuState = .Closed
                
                if let sideMenuControllerView = self.sideMenuController?.view {
                    sideMenuControllerView.removeFromSuperview()
                }
                
                self.sideMenuController = nil
            }
        }
    }
    
    private func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.curveEaseInOut], animations: {
            self.centerNavigationController?.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
    private func showShadowForCenterViewController(shouldShowShadow: Bool) {
        if shouldShowShadow {
            centerNavigationController?.view.layer.shadowOpacity = 0.8
            centerNavigationController?.view.layer.shadowRadius = 20
        }
        else {
            centerNavigationController?.view.layer.shadowOpacity = 0
        }
    }
    
    private func createCenterNavigationController(viewController: UIViewController) {
        if centerNavigationController == nil {
            centerNavigationController = UINavigationController(rootViewController: viewController)
            view.addSubview(centerNavigationController.view)
            centerNavigationController.didMove(toParentViewController: self)
            
            let panGentureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(recognizer:)))
            panGentureRecognizer.cancelsTouchesInView = false
            centerNavigationController.view.addGestureRecognizer(panGentureRecognizer)
        }
    }
    
    private func setActivitesView() {
        
        myActivitesViewController = mainStoryboard.instantiateViewController(withIdentifier: "PageView") as? PageViewController
        myActivitesViewController.title = "My Activities"
        if centerNavigationController == nil {
            createCenterNavigationController(viewController: myActivitesViewController)
        }
        else {
            centerNavigationController.setViewControllers([myActivitesViewController], animated: false)
        }
        
        
    }
    
    private func setMyWorldView() {
        
        myWorldViewController = mainStoryboard.instantiateViewController(withIdentifier: "PageView") as! PageViewController
        myWorldViewController.title = "My Contacts"
        if centerNavigationController == nil {
            createCenterNavigationController(viewController: myWorldViewController)
        }
        else {
            centerNavigationController.setViewControllers([myWorldViewController], animated: false)
        }
    }
    
    
    private func setMyPlacesView() {
        myPlacesViewController = mainStoryboard.instantiateViewController(withIdentifier: "PageView") as? PageViewController
        myPlacesViewController.title = "My Places"
        
        if centerNavigationController == nil {
            createCenterNavigationController(viewController: myPlacesViewController)
        }
        else {
            centerNavigationController.setViewControllers([myPlacesViewController], animated: false)
        }
    }
    
    private func setMyMoneyView() {
        
        myMoneyViewController = mainStoryboard.instantiateViewController(withIdentifier: "PageView") as? PageViewController
        myMoneyViewController.title = "My Money"
        if centerNavigationController == nil {
            createCenterNavigationController(viewController: myMoneyViewController)
        }
        else {
            centerNavigationController.setViewControllers([myMoneyViewController], animated: false)
        }
    }
    
    private func setMyMemoriesView() {
        
        myPreferencesViewController = mainStoryboard.instantiateViewController(withIdentifier: "PageView") as? PageViewController
        myPreferencesViewController.title = "My Memories"
        if centerNavigationController == nil {
            createCenterNavigationController(viewController: myPreferencesViewController)
        }
        else {
            centerNavigationController.setViewControllers([myPreferencesViewController], animated: false)
        }
    }
    private func setMyProfileView() {
        
        myProfileViewController = mainStoryboard.instantiateViewController(withIdentifier: "PageView") as? PageViewController
        myProfileViewController.title = "My Profile"
        if centerNavigationController == nil {
            createCenterNavigationController(viewController: myProfileViewController)
        }
        else {
            centerNavigationController.setViewControllers([myProfileViewController], animated: false)
        }
    }
    /*
    private func logOutButtonTapped() {
        if #available(iOS 10.0, *) {
            os_log("logout button handler", type:.debug)
        } else {
            // Fallback on earlier versions
        }
        
        guard (UIApplication.shared.delegate as? AppDelegate) != nil else {
            fatalError("Unable to get AppDelegate")
        }
        
        //Delete the app cookies
        //HttpHelper.deleteCookies()
        //appD.loggedIn = false
        //appD.showLogin()
        if let logInVC = storyboard?.instantiateViewController(withIdentifier: "LoginTableView") {
            DispatchQueue.main.async() { () -> Void in
                self.present(logInVC, animated: true, completion: nil)
            }
        }
    }
    */
    
    
    //    MARK: SideMenu Delegate
    
    internal func open_side_menu() {
        togglePanel()
    }
    
    internal func closeSideMenu() {
        collapseSidePanels()
    }
    
    internal func switchMenuGestureTo(sideMenuGestureOn: Bool){
        allowedMenuGesture = sideMenuGestureOn
    }
    
    //    MARK: SideMenu Click Delegate
    
    internal func side_menu_clicked(row: Int) {
        
        switch row {
        case 0:
            setActivitesView()
            break
        case 1:
            setMyWorldView()
            break
        case 2:
            setMyMoneyView()
            break
        case 3:
            setMyPlacesView()
            break
        case 4:
            setMyMemoriesView()
            break
        case 5:
            setMyProfileView()
            break
            
        default:
            setActivitesView()
            break
        }
        
        togglePanel()
    }
    /*
    internal func logout_clicked() {
        logOutButtonTapped()
    }
    */
    //    MARK: Gesture Recognizers
    @objc func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        //        let gestureIsDraggingFromLeftToRight = (recognizer.velocity(in: view).x > 0)
        
        
        if !allowedMenuGesture {
            return
        }
        
        
        let gestureIsDraggingFromRightToLeft = (recognizer.velocity(in: view).x < 0)
        
        switch recognizer.state {
        case .began:
            if sideMenuState == .Closed {
                if(gestureIsDraggingFromRightToLeft == false) {
                    addPanelViewController()
                }
            }
        case .changed:
            let screenCenter = recognizer.view!.frame.width/2
            let newCenter = recognizer.view!.center.x + recognizer.translation(in: view).x
            if screenCenter <= newCenter {
                // prevents dragging to the left
                recognizer.view!.center.x = newCenter
                recognizer.setTranslation(.zero, in: view)
            }
        case .ended:
            if sideMenuController != nil {
                let recCenter = recognizer.view!.center.x
                let screenCenter = recognizer.view!.frame.width / 2
                
                if abs(recCenter - screenCenter) > 20 {
                    let direction = recognizer.velocity(in: view).x > 10
                    animateLeftPanel(shouldExpand: direction)
                }
                else {
                    let open = abs(recCenter - screenCenter) > 40
                    animateLeftPanel(shouldExpand: open)
                }
            }
            
        default:
            break
        }
    }
    
    //    MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let userLocation = UserLocation()
        //userLocation.requestLocation()
        UIApplication.shared.statusBarStyle = .default
        
        sideMenuDelegate = self
        sideMenuClickDelegate = self
        
        setActivitesView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

