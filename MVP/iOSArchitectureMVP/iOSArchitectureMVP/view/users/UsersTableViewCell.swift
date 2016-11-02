/*
 * Copyright (C) 2016 Aptyr (github.com/aptyr)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import UIKit
import Kingfisher

class UsersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var login: UILabel!
    @IBOutlet weak var longName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var since: UILabel!
    
    func setUser(_ user: User?) {
        
        if let url = user?.avatar_url {
            avatar.kf.setImage(with: URL(string: url), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        }
        
        login.text = user?.login
        
        if let userName = user?.name {
            longName.text = userName
        } else {
            longName.text = "No name"
        }
        
        if let userEmail = user?.email {
            email.text = userEmail
        } else {
            email.text =  "No email"
        }
        
        if let userRegisterDate = user?.since {
            since.text = JsonDateFormatter.dateFormatter2.string(from: userRegisterDate)
        } else {
            since.text = "No register date"
        }
    }
}
