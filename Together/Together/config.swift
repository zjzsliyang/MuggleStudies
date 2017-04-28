//
//  config.swift
//  Together
//
//  Created by Yang Li on 28/04/2017.
//  Copyright © 2017 Yang Li. All rights reserved.
//

import Foundation

let ERROR_INFO = [
  "SUCCESS": [
    "number": "200",
    "value": "操作成功完成"
  ],
  
  // 错误状态码
  "DATABASE_ERR": [
    "number": "400",
    "value": "数据库操作有误"
  ],
  "REQUEST_ERR": [
    "number": "401",
    "value": "携带参数不完整"
  ],
  "INSIDE_ERR": [
    "number": "402",
    "value": "函数内部错误"
  ],
  
  // 用户信息错误
  "PASSWD_ERR": [
    "number": "300",
    "value": "用户名或密码错误"
  ],
  "USER_ERR": [
    "number": "301",
    "value": "不存在此用户"
  ],
  "ACCOUNT_ERR": [
    "number": "302",
    "value": "用户名已存在"
  ],
  
  //API调用错误
  "API_INSIDE": [
    "number": "310",
    "value": "API调用内部错误"
  ]
  
];
