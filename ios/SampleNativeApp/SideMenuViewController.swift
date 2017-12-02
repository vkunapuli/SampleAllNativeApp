//
//  SideMenuViewController.swift
//  MyLife
//
//  Created by Venkata ramana Kunapuli on 11/6/17.
//  Copyright © 2017 Venkata ramana Kunapuli. All rights reserved.
//

import Foundation
import UIKit
import os.log

class SideMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var menuItemLabel: UILabel!
    @IBOutlet weak var menuItemImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

class SideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileEmail: UILabel!
    @IBOutlet weak var logoutIcon: UIImageView!
    @IBOutlet weak var logoutLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    //var profileImg:ProfileImageViewButton!
    
    var menu = [[
        "title":NSLocalizedString("My Actitvites", comment: "MyActitvites"),
        "image": nil],
        [
        "title":NSLocalizedString("My Contacts", comment: "MyContacts"),
        "image":nil
        ],
        [
            "title":NSLocalizedString("My Money", comment: "MyMoney"),
            "image":nil],
        [
        "title":NSLocalizedString("My Places", comment: "MyPlaces"),
        "image":nil
        ],
        ["title":NSLocalizedString("My Memories", comment: "MyMemories"),
         "image":nil],
        ["title":NSLocalizedString("My Profile", comment: "MyProfile"),
         "image":nil]
    ]
    var user: Dictionary<String, Any>?
    
    // MARK: Custom Methods
    
    
    @IBAction func logoutButtonHandler(_ sender: UIButton) {
        //sideMenuClickDelegate?.logout_clicked!()
    }
    
    //    MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutLabel.text = ""//NSLocalizedString("Logout", comment: "Logout")
        //TODO: need to remove the hardcoded login later
        profileName.text = NSLocalizedString("Menu", comment: "Venkat Kunapuli")
        /*
        if let image = ImageManager.getSavedImage(imageName: "fileName") {
            profileImage.image = image
        }
 */
        profileImage.backgroundColor = UIColor.white
        profileImage.contentMode = .scaleAspectFill
        let radius = profileImage.frame.width / 2
        profileImage.layer.cornerRadius = radius
        profileImage.layer.masksToBounds = true
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //TODO : need add this back on when login enabled.
        /*
        user = UserService.getUser()!
        
        if let email = user?[AccountFields.emailAddr] as? String {
            profileEmail.text = email
        } else {
            profileEmail.text = ""
        }
        */
        //profileName.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    MARK: TableView Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath) as! SideMenuTableViewCell
        
        if let title = menu[indexPath.row]["title"] as? String {
            cell.menuItemLabel.text = title
        }
        
        if let image = menu[indexPath.row]["image"] as? UIImage {
            cell.menuItemImage.image = image
        }
        
        cell.backgroundColor = UIColor.clear
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        sideMenuClickDelegate?.side_menu_clicked!(row: indexPath.row)
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
