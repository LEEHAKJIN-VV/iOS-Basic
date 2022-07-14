// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieVO = try? newJSONDecoder().decode(MovieVO.self, from: jsonData)

import Foundation

class MovieVO {
    var thumbnail: String? // 영화 섬네일 이미지 주소
    var title: String? // 영화 제목
    var description: String? // 영화 설명
    var detail: String? // 상세정보
    var opendate: String? // 개봉일
    var rating: Double? // 평점
}

