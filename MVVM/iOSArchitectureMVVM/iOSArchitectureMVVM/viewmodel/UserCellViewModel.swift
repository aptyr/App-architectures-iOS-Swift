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

struct UserCellViewModel {
    
    private var user : User?
    
    var login : String? {
        get {
            return user?.login
        }
    }
    
    var name : String {
        get {
            guard let userName = user?.name else {
                return "No name"
            }
            
            return userName
        }
    }
    
    var email : String {
        get {
            guard let userEmail = user?.email else {
                return  "No email"
            }
            
            return userEmail
        }
    }
    
    var registerDate : String {
        get {
            guard let userRegisterDate = user?.since else {
                return "No register date"
            }
            
            return JsonDateFormatter.dateFormatter2.string(from: userRegisterDate)
        }
    }
    
    init(withUser user: User) {
        self.user = user
    }
    
    func showAvatar(imageView view: UIImageView){
        if let url = user?.avatar_url {
                view.kf.setImage(with: URL(string: url), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        }

    }
    
}
