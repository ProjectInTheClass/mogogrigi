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
    var keywords: String
    var likeArt: Bool
    var memo: String
    var artImg: String
}


let keywordList1 = ["고양이", "갓구운 식빵", "잠자리", "의자", "꽃 씨앗", "노트북", "책상", "손수건", "옥수수", "반딧불이", "둥근 식탁", "라탄 바구니", "크로와상", "커피잔", "유리 꽃병", "격자 창문", "흔들의자"]
let keywordList2 = ["노천 카페", "낡은 서재", "노을", "늦은 새벽", "이른 아침", "점심시간", "오두막", "작은 풀밭", "작은 언덕", "퇴근시간", "봄의 가로수", "벽돌 담장", "초저녁", "거실"]
let keywordList3 = ["그레이 블루", "꽃무늬", "체크무늬", "정오의 빛", "겨울 공기", "진한 체리빛", "반사된 빛", "여린 물빛", "보라빛", "짙은 인디고", "깊은 코랄", "밝은 코랄", "병아리색"]

let tipList = ["\" 한번 지나간 단어조합은 되돌릴 수 없어요 \"", "\" 오른쪽 스와이프로 단어조합을 저장할 수 있어요 \"", "\" 왼쪽 스와이프로 새로운 단어조합을 볼 수 있어요 \"", "\" 세개의 단어로 한줄 문장을 만들어 보세요 \"", "\" 아이디어는 작은 단어들로부터 태어날 수 있어요 \"", "\" 단어들은 n마다 업데이트되니 기대해주세요 \""]


var Post_List = [
    PostList(postID: 1, postDate: "2020-09-19", category: 1, keyword01: "고양이", keyword02: "의자", keyword03: "책", keywords: "고양이, 의자, 책", likeArt: true, memo: "의자에 앉아 책을 읽는 내 무릎에 나른하게 앉아 그르렁 대는 고양이와 함께하는 오후", artImg: "01"),
    PostList(postID: 2, postDate: "200-09-11", category: 1, keyword01: "구름", keyword02: "바다", keyword03: "노을", keywords: "구름, 바다, 노을", likeArt: false, memo: "노을진 바다를 바라보는", artImg: "02"),
    PostList(postID: 3, postDate: "200-09-12", category: 1, keyword01: "강아지", keyword02: "하늘", keyword03: "바다", keywords: "강아지, 하늘, 바다", likeArt: false, memo: "바닷가에서 뛰어노는 강아지", artImg: "03"),
    PostList(postID: 4, postDate: "200-09-13", category: 1, keyword01: "봄비", keyword02: "하늘", keyword03: "반딧불이", keywords: "봄비, 하늘, 반딧불이", likeArt: false, memo: "반딧불이가 봄비처럼 내리는 하늘", artImg: "04"),
    PostList(postID: 5, postDate: "200-09-14", category: 1, keyword01: "산책", keyword02: "허수아비", keyword03: "손전등", keywords: "산책, 허수아비, 손전등", likeArt: false, memo: "산책을 하는 도중 만난 허수아비", artImg: "05"),
    PostList(postID: 5, postDate: "200-09-14", category: 1, keyword01: "산책", keyword02: "허수아비", keyword03: "손전등", keywords: "산책, 허수아비, 손전등", likeArt: false, memo: "산책을 하는 도중 만난 허수아비", artImg: "05"),
    PostList(postID: 5, postDate: "200-09-14", category: 1, keyword01: "산책", keyword02: "허수아비", keyword03: "손전등", keywords: "산책, 허수아비, 손전등", likeArt: false, memo: "산책을 하는 도중 만난 허수아비", artImg: "05"),
    PostList(postID: 5, postDate: "200-09-14", category: 1, keyword01: "산책", keyword02: "허수아비", keyword03: "손전등", keywords: "산책, 허수아비, 손전등", likeArt: false, memo: "산책을 하는 도중 만난 허수아비", artImg: "05")
]
