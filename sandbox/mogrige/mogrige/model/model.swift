//
//  model.swift
//  mogrige
//
//  Created by Hyunseok Yang on 2020/09/24.
//

import Foundation
import UIKit

struct PostList {
    var postID: Int
    var postDate: String
    var category: Int
    var keyword01: String
    var keyword02: String
    var keyword03: String
    var likeArt: Bool
    var memo: String
    var artImg: String
}


let keywordList = ["고양이", "강아지", "잠자리", "바람", "노을", "의자", "바다", "허수아비", "청소", "노트북", "책상", "손수건", "밀짚모자", "김밥", "옥수수", "코트", "패딩", "새싹", "봄비", "반딧불이", "토끼", "가을", "단풍", "산책", "손전등", "별", "하늘", "구름", "태풍", "손목시계", "책"]


var Post_List = [
    PostList(postID: 1, postDate: "2020-09-19", category: 1, keyword01: "고양이", keyword02: "의자", keyword03: "책", likeArt: true, memo: "의자에 앉아 책을 읽는 내 무릎에 나른하게 앉아 그르렁 대는 고양이와 함께하는 오후", artImg: "01"),
    PostList(postID: 2, postDate: "200-09-11", category: 1, keyword01: "구름", keyword02: "바다", keyword03: "노을", likeArt: false, memo: "노을진 바다를 바라보는", artImg: "02"),
    PostList(postID: 3, postDate: "200-09-12", category: 1, keyword01: "강아지", keyword02: "하늘", keyword03: "바다", likeArt: false, memo: "바닷가에서 뛰어노는 강아지", artImg: "03"),
    PostList(postID: 4, postDate: "200-09-13", category: 1, keyword01: "봄비", keyword02: "하늘", keyword03: "반딧불이", likeArt: false, memo: "반딧불이가 봄비처럼 내리는 하늘", artImg: "04"),
    PostList(postID: 5, postDate: "200-09-14", category: 1, keyword01: "산책", keyword02: "허수아비", keyword03: "손전등", likeArt: false, memo: "산책을 하는 도중 만난 허수아비", artImg: "05"),
    PostList(postID: 5, postDate: "200-09-14", category: 1, keyword01: "산책", keyword02: "허수아비", keyword03: "손전등", likeArt: false, memo: "산책을 하는 도중 만난 허수아비", artImg: "05"),
    PostList(postID: 5, postDate: "200-09-14", category: 1, keyword01: "산책", keyword02: "허수아비", keyword03: "손전등", likeArt: false, memo: "산책을 하는 도중 만난 허수아비", artImg: "05"),
    PostList(postID: 5, postDate: "200-09-14", category: 1, keyword01: "산책", keyword02: "허수아비", keyword03: "손전등", likeArt: false, memo: "산책을 하는 도중 만난 허수아비", artImg: "05")
]
