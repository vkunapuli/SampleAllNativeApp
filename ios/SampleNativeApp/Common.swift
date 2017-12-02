//
//  Common.swift
//  MyLife
//
//  Created by Venkata ramana Kunapuli on 11/6/17.
//  Copyright © 2017 Venkata ramana Kunapuli. All rights reserved.
//

import Foundation
import UIKit
import os.log

@objc
protocol SideMenuDelegate {
    @objc optional func open_side_menu()
    @objc optional func closeSideMenu()
    @objc optional func switchMenuGestureTo(sideMenuGestureOn: Bool)
}

@objc
protocol SideMenuClickDelegate {
    @objc optional func side_menu_clicked(row:Int)
    @objc optional func logout_clicked()
}

var sideMenuClickDelegate:SideMenuClickDelegate?
var sideMenuDelegate:SideMenuDelegate?
