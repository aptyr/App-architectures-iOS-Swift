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

class UsersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var login: UILabel!
    @IBOutlet weak var longName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var since: UILabel!
    
    private var viewModel : UserCellViewModel?
    
    func invalidate(withViewModel viewModel: UserCellViewModel){
        self.viewModel = viewModel
        invalidate()
    }
    
    private func invalidate(){        
        login.text = viewModel?.login
        longName.text = viewModel?.name
        email.text = viewModel?.email
        since.text = viewModel?.registerDate
        viewModel?.showAvatar(imageView: avatar)
    }
}
