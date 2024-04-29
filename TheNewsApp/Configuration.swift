//
//  Configuration.swift
//  TheNewsApp
//
//  Created by Neetha on 25/04/2024.
//

import Foundation

struct Configuration {
    var apiKey: String = getApiKey()
}

func getApiKey(from provider: (String) -> Any? = { Bundle.main.object(forInfoDictionaryKey: $0)}) -> String {
    guard let object = provider("API_KEY"),
          let string = object as? String,
          !string.isEmpty else {
        print("Please add an api key in Config.xcconfig available at https://newsapi.org")
        return ""
    }
    return string
}
