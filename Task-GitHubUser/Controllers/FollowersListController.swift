//
//  FollowersListController.swift
//  Task-GitHubUser
//
//  Created by Rahul Nimje on 25/10/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import UIKit

class FollowersListController: UIViewController {

    @IBOutlet weak var tableFollowersList: UITableView!
    var users = UserList()
    var followersListURL: String!
    let imageProvider = ImageProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableFollowersList.estimatedRowHeight = 121.0
        tableFollowersList.rowHeight = UITableView.automaticDimension
        
        guard let path = URL(string: followersListURL) else {
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
                    self?.tableFollowersList.reloadData()
                }
        }
        task.resume()
    }

}

extension FollowersListController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FollowersListCell") as? FollowersListCell else {
            fatalError("Cell not found!")
        }
        let model = users[indexPath.row]
        cell.labelUserName.text = model.login
        cell.labelUserID.text = model.nodeID
        guard let userProfileURL = URL(string: model.avatarURL) else {
            return cell
        }
        let image = imageProvider.cache.object(forKey: userProfileURL as NSURL)
        cell.imageUser.image = image
        if image == nil {
            imageProvider.loadImages(from :userProfileURL, completion: { (image) -> Void in
                let indexPath_ = self.tableFollowersList.indexPath(for: cell)
                if indexPath == indexPath_ {
                    cell.imageUser.image = image
                }
            })
        }
        return cell
    }
    
}

