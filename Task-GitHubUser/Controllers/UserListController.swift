//
//  UserListController.swift
//  Task-GitHubUser
//
//  Created by Rahul Nimje on 25/10/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import UIKit

class UserListController: UIViewController {

    @IBOutlet weak var tableUserList: UITableView!
    var users = UserList()
    let userListURLPath = "https://api.github.com/users"
    let imageProvider = ImageProvider()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableUserList.estimatedRowHeight = 121.0
        tableUserList.rowHeight = UITableView.automaticDimension
        
        guard let path = URL(string: userListURLPath) else {
            return
        }
        fetchUserList(urlPath: path)
    }
    
    func fetchUserList(urlPath: URL){
       let task =  URLSession
                        .shared
                        .userListTask(with: urlPath) {[weak self] userList, response, error in
                            DispatchQueue.main.async {
                                self?.users = userList ?? []
                                self?.tableUserList.reloadData()
                            }
                    }
        task.resume()
    }
    
    //MARK :- Navigation
    @IBAction func actionSeeFollowersList(_ sender: UIButton) {
        guard let followersList = storyboard?.instantiateViewController(withIdentifier: "FollowersListController") as? FollowersListController else {
            fatalError("FollowersListController not found!")
        }
        followersList.followersListURL = users[sender.tag].followersURL
        navigationController?.pushViewController(followersList, animated: true)
    }
}

extension UserListController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return users.count
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserListCell") as? UserListCell else {
            fatalError("Cell not found!")
        }
        let model = users[indexPath.row]
        cell.labelUserName.text = model.login
        cell.labelUserID.text = model.nodeID
        cell.buttonFollowersList.tag = indexPath.row
        guard let userProfileURL = URL(string: model.avatarURL) else {
            return cell
        }
        let image = imageProvider.cache.object(forKey: userProfileURL as NSURL)
        cell.imageUser.image = image
        if image == nil {
            imageProvider.loadImages(from :userProfileURL, completion: { (image) -> Void in
                let indexPath_ = self.tableUserList.indexPath(for: cell)
                if indexPath == indexPath_ {
                    cell.imageUser.image = image
                }
            })
        }
        return cell
    }

}

