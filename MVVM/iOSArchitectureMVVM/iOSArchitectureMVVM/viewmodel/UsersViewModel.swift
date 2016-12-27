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

class UsersViewModel : UsersViewModelProtocol, FetchUsersProtocol, FetchUserProtocol, Observable {
    
    private var dataSource: [User] = [User]()
    private var dataSourceViewModel : [User : UserCellViewModel] = [:]
    
    private var view : UsersViewProtocol?
    private var lastIndexPath : IndexPath?
    
    private let api : GithubAPI = GithubAPI()
    
    var numberOfRows : Int {
        get {
            return dataSource.count
        }
    }
    
    var selectedIndexPath : IndexPath? {
        get {
            return lastIndexPath
        }
    }
    
    required init(view withView: UsersViewProtocol) {
        self.view = withView
        getUsers(since: 0)
    }
    
    
    private func getUsers(since: Int) {
        api.getUsers(since, callback: self)
    }
    
    func usersFetched(_ users: [User]?) {
        guard let data = users  else {
            return
        }
        
        data.forEach { $0.addObserver(observer: self) }
        
        dataSource += data
        view?.dataForTableView()
    }
    
    func userFetched(_ user: User?) {
        dataSource.filter { $0.login == user?.login }.forEach { $0.update(withUser: user!)}
    }
    
    func tableViewItemSelected(_ indexPath: IndexPath) {
        if let login = dataSource[indexPath.item].login {
            lastIndexPath = indexPath
            api.getUser(login, callback: self)
        }
    }
    
    func tableViewReachedBottom() {
        getUsers(since: dataSource.count - 1)
    }
    
    func userUpdated(_ user : User) {
        view?.expandCell(dataSource.index(of: user)!)
    }
    
    func viewModelForCell(at index: Int) -> UserCellViewModel {
        guard let vm = dataSourceViewModel[dataSource[index]] else {
            let vm = UserCellViewModel(withUser: dataSource[index])
            dataSourceViewModel[dataSource[index]] = vm
            return vm
        }
        return vm        
    }
}
