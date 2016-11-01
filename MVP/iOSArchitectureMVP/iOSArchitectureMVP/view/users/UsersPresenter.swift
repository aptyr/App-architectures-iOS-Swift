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

class UsersPresenter : UsersPresenterProtocol, FetchUsersProtocol {
    
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
        view?.invalidateView(users)
    }
}
