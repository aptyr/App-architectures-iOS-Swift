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

class JsonDateFormatter {
    
    private static var jsonDateFormatter: DateFormatter?
    private static var stringDateFormatter: DateFormatter?
    
    static var dateFormatter: DateFormatter {
        guard let formatter = jsonDateFormatter else {
            jsonDateFormatter = DateFormatter()
            jsonDateFormatter!.dateFormat = "yyyy-MM-dd'T'hh:mm:ssZ"
            return jsonDateFormatter!
        }
        
        return formatter
    }
    
    static var dateFormatter2: DateFormatter {
        guard let formatter = stringDateFormatter else {
            stringDateFormatter = DateFormatter()
            stringDateFormatter!.dateFormat = "yyyy MMM dd"
            return stringDateFormatter!
        }
        
        return formatter
    }
}
