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

import Foundation

class UsersPresenter : UsersPresenterProtocol, FetchUsersProtocol, FetchUserProtocol {
    
    private var dataSource: [User] = [User]()
    private var indexPathCellToExpand: IndexPath?
    
    var view : UsersController?
    
    let api : GithubAPI = GithubAPI()
    
    func start() {
        getUsers(since: 0)
    }
    
   
    func setView(view: UsersController) {
       self.view = view
    }
    
    internal func getUsers(since: Int) {
        api.getUsers(since, callback: self)
    }
    
    func usersFetched(_ users: [User]?) {
        if let data = users {
            dataSource += data
        }
        
        view?.invalidateView(data())
    }
    
    func userFetched(_ user: User?) {
        if let indexPath = indexPathCellToExpand {
            data().filter { $0.login == user?.login }.forEach {
                $0.email = user?.email
                $0.name = user?.name
                $0.createdAt = user?.createdAt
            }
            view?.expandCell(indexPath)
        }
    }
    
    func tableViewItemClicked(_ indexPath: IndexPath) {
        indexPathCellToExpand = indexPath
        
        if let login = data()[indexPath.item].login {
            api.getUser(login, callback: self)
        }
    }
    
    func data() -> [User] {
        return dataSource
    }
}
