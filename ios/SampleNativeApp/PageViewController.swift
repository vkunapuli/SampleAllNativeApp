//
//  PageViewController.swift
//  SampleNativeApp
//
//  Created by Venkata ramana Kunapuli on 12/1/17.
//  Copyright © 2017 Venkata ramana Kunapuli. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {

    @IBAction func open(_ sender: Any) {
        sideMenuDelegate?.open_side_menu!()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultViewSettings()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //checkCalendarAuthorizationStatus()
        //self.showAction5()
        
        sideMenuDelegate?.switchMenuGestureTo!(sideMenuGestureOn: true)
        /*
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
 */
        
        //refreshView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        
        
        sideMenuDelegate?.switchMenuGestureTo!(sideMenuGestureOn: false)
        sideMenuDelegate?.closeSideMenu!()
        /*
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 26/255.0, green: 96/255.0, blue: 172/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = true
 */

    }
    private func setDefaultViewSettings() {
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        let menuButton = UIButton.init(type: .custom)
        menuButton.setImage(UIImage(named: "hamburger_white_sml" ), for: .normal)
        menuButton.tintColor = UIColor.black
        menuButton.addTarget(self, action: #selector(open(_:)), for: .touchUpInside)
        menuButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        let menuBarButton = UIBarButtonItem(customView: menuButton)
        self.navigationItem.leftBarButtonItem = menuBarButton
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
