//
//  Group.swift
//  breakpoint
//
//  Created by Robihamanto on 23/02/18.
//  Copyright © 2018 Robihamanto. All rights reserved.
//

import Foundation

class Group {
    private var _key: String
    private var _title: String
    private var _description: String
    private var _memberCount: Int
    private var _members: [String]
    
    init(forId key: String, forTitle title: String, forDescription desc: String, forMemberCount memberCount: Int, andMember member: [String]) {
        self._key = key
        self._title = title
        self._description = desc
        self._memberCount = memberCount
        self._members = member
    }
    
    var key: String {
        return _key
    }
    
    var title: String {
        return _title
    }
    
    var description: String {
        return _description
    }
    
    var memberCount: Int {
        return _memberCount
    }
    
    var members: [String] {
        return _members
    }
    
}
