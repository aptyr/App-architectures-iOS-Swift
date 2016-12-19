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

class UsersController: UIViewController, UsersViewProtocol {
        
    @IBOutlet weak var tableView: UITableView!
    
    var presenter : UsersPresenter!
    
    var selectedCell: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: "usersTableViewCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60

        getPresenter().start()
    }

    func getPresenter() -> UsersPresenter {
        if presenter == nil {
            presenter = UsersPresenter()
            presenter.setView(view: self)
        }
        return presenter
    }
    
    func invalidateView() {
        tableView.reloadData()
    }
    
    func expandCell(_ indexPath: IndexPath) {
        selectedCell = indexPath
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
        
    }
    
    
}

