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

import SwiftyJSON

protocol Observable : class {
    
    func userUpdated(_ user : User)
    
}

public class User {
    
    private class Observer: NSObject {
        weak var observer: Observable?
        
        init(observer: Observable) {
            self.observer = observer
        }
    }
    
    private var observers = [Observer]()
    
    public var login : String?
    public var id : Int?
    public var avatar_url : String?
    public var gravatar_id : String?
    public var url : String?
    public var html_url : String?
    public var followers_url : String?
    public var following_url : String?
    public var gists_url : String?
    public var starred_url : String?
    public var subscriptions_url : String?
    public var organizations_url : String?
    public var repos_url : String?
    public var events_url : String?
    public var received_events_url : String?
    public var type : String?
    public var site_admin : String?
    public var name : String?
    public var email : String?
    public var createdAt : Date?
    
    public var since : Date? {
        get {
            return createdAt
        }
    }
    
    required public init?(json:JSON) {
        
        login = json["login"].string
        id = json["id"].int
        avatar_url = json["avatar_url"].string
        gravatar_id = json["gravatar_id"].string
        url = json["url"].string
        html_url = json["html_url"].string
        followers_url = json["followers_url"].string
        following_url = json["following_url"].string
        gists_url = json["gists_url"].string
        starred_url = json["starred_url"].string
        subscriptions_url = json["subscriptions_url"].string
        organizations_url = json["organizations_url"].string
        repos_url = json["repos_url"].string
        events_url = json["events_url"].string
        received_events_url = json["received_events_url"].string
        type = json["type"].string
        site_admin = json["site_admin"].string
        name = json["name"].string
        email = json["email"].string
        createdAt = json["created_at"].date
    }
    
    func update(withUser user: User) {
        self.name = user.name
        self.email = user.email
        self.createdAt = user.createdAt
        notifyObservers()
    }
    
    
    func addObserver<T: Observable>(observer: T) {
        self.observers.append(Observer(observer: observer))
    }
    
    // TODO 
    func removeObserver<T: Observable>(observer: T) {
        
    }
    
    func notifyObservers() {
        self.observers.filter { $0.observer != nil }.forEach { $0.observer?.userUpdated(self) }
    }
    
}

extension User: Equatable, Hashable {
    public var hashValue: Int {
        return (login?.hashValue)!
    }
}

public func ==(lhs: User, rhs: User) -> Bool {
    return lhs.login == rhs.login
}
