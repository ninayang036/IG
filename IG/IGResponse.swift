//
//  IGResponse.swift
//  Instagram
//
//  Created by Yang Nina on 2021/5/6.
//

import Foundation

struct IGResponse:Decodable {
    let graphql:Graphql
    struct Graphql:Decodable {
        let user:User
        struct User:Decodable {
            let biography:String
            let external_url:URL//商品連結
            let edge_followed_by: Edge_followed_by//粉絲人數
                struct Edge_followed_by:Decodable {
                    let count:Int
                }
            let edge_follow:Edge_follow//追蹤人數
               struct Edge_follow:Decodable {
                   let count:Int
               }
            let full_name:String//名字
            let category_name:String//帳號類型
            let profile_pic_url:URL//大頭照片
            let username:String//帳號 sweethouse.sl
            let edge_owner_to_timeline_media:Edge_owner_to_timeline_media
            struct Edge_owner_to_timeline_media:Decodable {
                let count:Int
                let edges:[Edges]
                struct Edges:Decodable {
                    let node:Node
                    struct Node:Decodable {
                        let display_url:URL //貼文圖片
                        let edge_media_to_caption:Edge_media_to_caption
                        struct Edge_media_to_caption:Decodable {
                            let edges:[Edges]
                            struct Edges:Decodable {
                                let node:Node
                                struct Node:Decodable {
                                    let text:String
                                }
                            }
                        }
                        let edge_media_to_comment:Edge_media_to_comment //留言數量
                        struct Edge_media_to_comment:Decodable {
                            let count:Int
                        }
                        let edge_liked_by:Edge_liked_by //貼文按讚數
                        struct Edge_liked_by:Decodable {
                            let count:Int
                        }
                        let taken_at_timestamp:Date
                    }
                }
            }
        }
    }
}

