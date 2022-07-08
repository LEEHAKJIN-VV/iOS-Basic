//
//  ListViewController.swift
//  MyMovieChart
//
//  Created by 이학진 on 2022/07/06.
//

import UIKit

class ListViewController: UITableViewController {
    var MarbleDataSet = [("토르 러브 & 썬더", "엔드 게임 이후 토르의 행방은??", "2022-07-06", 9.7,"thor.png"),
    ("닥터스트레인지2", "스칼렛 위치 vs 스티븐", "2022-05-04", 8.9,"doctor.png"),
    ("샹치와 텐링즈의 전설", "마블에 새로운 캐릭터 등장!", "2021-09-02", 8.9,"shangchi.png")]
    var FavorDataset1 = [("범죄와의 전쟁", "느그 서장 남천동 살제??", "2021-02-22", 8.65, "fight.png"),
                         ("신셰게", "너 나하고, 일 하나 같이하자!", "2013-02-21",8.94, "newworld.png"),
                         ("부당거래", "너 지금 부터 범인해라", "2010.10.28", 9.01,"baddeal.png")]
    var FavorDataset2 = [("올드보이", "웃어라 모든 사람이 너와 함께 웃을 것이다.", "2013-11-21", 8.92,"oldboy.png"),
                         ("암살", "지금 임무를 완수하겠습니다.", "2015-07-22",9.10,"kill.png"),
                         ("감시자들", "야 꽃돼지!", "2013-07-03", 7.76,"hiden.png")]
    var SectionHeaderList = ["마블 영화", "한국 영화1", "한국 영화2"]
    lazy var MovieDataSet = [MarbleDataSet, FavorDataset1, FavorDataset2]
    
    lazy var list: [[MovieVO]] = {
        var dataList: [[MovieVO]] = Array(repeating: [], count: MovieDataSet.count)
        
        for (i, data) in MovieDataSet.enumerated() {
            var tmpList: [MovieVO] = []
            for (title, desc, opendate, rating, imgPath) in data {
                let mvo: MovieVO = MovieVO()
                mvo.title = title
                mvo.description = desc
                mvo.rating = rating
                mvo.opendate = opendate
                mvo.thumbnail = imgPath
                tmpList.append(mvo)
            }
            dataList[i] = tmpList
        }
        return dataList
    }()
    
    // 섹션의 수를 반환
    override func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }

    // 각 섹션마다 행의 수를 반환
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list[section].count
    }
    
    // section의 header 반환
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if SectionHeaderList.count < section {
            return nil
        } else {
            return SectionHeaderList[section]
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 주어진 행에 맞는 데이터 소스를 읽음
        let row = self.list[indexPath.section][indexPath.row]
        // 테이블 셀 객체를 직접 생성하는 대신 큐로부터 가져옴
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell
        cell.title?.text = row.title // 영화 제목
        cell.title?.textAlignment = .left
        cell.desc?.text = row.description // 영화 요약
        cell.desc?.textAlignment = .left
        cell.opendate?.text = row.opendate // 영화 개봉일
        cell.opendate?.textAlignment = .right // d
        cell.rating?.text = "\(row.rating!)" // 영화 별점
        cell.rating?.textAlignment = .right
        cell.thumbnail.image = UIImage(named: row.thumbnail!) // 영화 썸네일
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row)번째 행입니다.")
    }
}
