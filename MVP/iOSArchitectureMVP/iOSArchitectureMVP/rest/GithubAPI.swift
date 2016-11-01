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


import Alamofire
import SwiftyJSON

protocol FetchUsersProtocol {
    func usersFetched(_ users: [User]?)
}

class GithubAPI : GithubService {
    
    
    internal static let SERVICE_ENDPOINT = "https://api.github.com/users?since=0";
    
    func getUsers(_ since: Int, callback: FetchUsersProtocol) {
    
        Alamofire.request(GithubAPI.SERVICE_ENDPOINT).responseJSON { response in
            if let jsonValue = response.result.value {
                var result = [User]()
                JSON(jsonValue).arrayValue.forEach { result.append(User(json: $0)!) }
                callback.usersFetched(result)
            }
        }
    };
}
