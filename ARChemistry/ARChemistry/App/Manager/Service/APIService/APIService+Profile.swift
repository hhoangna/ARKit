//
//  File.swift
//  GrabWork
//
//  Created by machnguyen_uit on 5/14/18.
//  Copyright © 2018 machnguyen_uit. All rights reserved.
//

import Foundation

extension APIService {
    
    @discardableResult
    func login(_ login:LoginDto, callback: @escaping APICallback<BaseDto>) -> APIRequest {
        return requestAPIServer(method: .POST,
                       path: "api/v1/user/login",
                       input: .dto(login),
                       callback: callback);
    }
    
    @discardableResult
    func register(_ register:RegisterDto, callback: @escaping APICallback<UserDto>) -> APIRequest {
        return requestAPIServer(method: .POST,
                       path: "api/v1/user/create",
                       input: .dto(register),
                       callback: callback);
    }
    
    @discardableResult
    func logout(callback: @escaping APICallback<BaseDto>) -> APIRequest {
        return requestAPIServer(method: .POST,
                       path: "api/v1/user/logout",
                       input: .empty,
                       callback: callback);
    }
    
    @discardableResult
    func updateUser(_ user:UserDto, callback: @escaping APICallback<BaseDto>) -> APIRequest {
        return requestAPIServer(method: .PUT,
                       path: "api/v1/user/create",
                       input: .dto(user),
                       callback: callback);
    }
}
