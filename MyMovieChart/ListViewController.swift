//
//  ListViewController.swift
//  MyMovieChart
//
//  Created by 이학진 on 2022/07/06.
//

import UIKit

class ListViewController: UITableViewController {
    // 테이블 뷰를 구성할 리스트 데이터
    var dataSet = [("토르 러브 & 썬더", "엔드 게임 이후 토르의 행방은??", "2022-07-06", 9.7, "darknight.jpg"),
    ("닥터스트레인지2", "스칼렛 위치로 각성한 완다와 닥터스터레인지의 이야기", "2022-05-04", 8.9, "rain.jpg"),
    ("샹치와 텐링즈의 전설", "마블에 새로운 캐릭터 등장!", "2021-09-02", 8.9, "secret.jpg")]
    
    lazy var list: [MovieVO] = {
        var dataList: [MovieVO] = []
        for (title, desc, opendate, rating, thumbnail) in self.dataSet {
            let mvo: MovieVO = MovieVO()
            mvo.title = title
            mvo.description = desc
            mvo.opendate = opendate
            mvo.rating = rating
            mvo.thumbnail = thumbnail
            dataList.append(mvo)
        }
        return dataList
    }()
    
    override func viewDidLoad() {
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count // 생성 해야 할 테이블의 행의 개수 반환
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 주어진 행에 맞는 데이터 소스를 읽음
        let row: MovieVO = self.list[indexPath.row]
        //print(type(of: row))
        // 테이블 셀 객체를 직접 생성하는 대신 큐로부터 가져옴

        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell
        
        // 영화 제목
        cell.title?.text = row.title
        // 영화 요약
        cell.desc?.text = row.description
        // 영화 개봉일
        cell.opendate?.text = row.opendate
        // 영화 별점
        cell.rating?.text = "\(row.rating!)"
        // 영화 썸네일
        cell.thumbnail.image = UIImage(named: row.thumbnail!)
        
        return cell

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row)번째 행입니다.")
    }
}
