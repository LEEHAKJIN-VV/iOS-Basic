//
//  ListViewController.swift
//  MyMovieChart
//
//  Created by 이학진 on 2022/07/06.
//

import UIKit

class ListViewController: UITableViewController, URLSessionDelegate, URLSessionTaskDelegate, URLSessionDataDelegate {
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    var receivedData: Data?
    
    lazy var list: [MovieVO] = {
        var datalist = [MovieVO]()
        return datalist
    }()

    // 각 섹션마다 행의 수를 반환
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 주어진 행에 맞는 데이터 소스를 읽음
        let row = self.list[indexPath.row]
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
        
        // 이미지 url 서버 통신
        let url: URL! = URL(string: row.thumbnail!)
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                return
            }
            DispatchQueue.main.async {
                cell.thumbnail.image = UIImage(data: data!)
            }
        }
        task.resume()
        
        return cell
    }
    
    override func viewDidLoad() {
        startLoad()
    }
    
    // delegate를 이용한 URLSession 통신
    func startLoad() {
        let url: URL! = URL(string: "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=1&count=100&genreId=&order=releasedateasc")!
        receivedData = Data()
        let task = session.dataTask(with: url)
        task.resume()
    }
    
    // 테이블의 데이터를 추가하는 메소드
    func addTableData(_ movelist:[Movie]) {
        for movie in movelist {
            let mvo:MovieVO = MovieVO()
            
            mvo.title = movie.title
            mvo.description = movie.genreNames
            mvo.thumbnail = movie.thumbnailImage
            mvo.detail = movie.linkURL
            mvo.rating = Double(movie.ratingAverage)
            self.list.append(mvo)
        }
        self.tableView.reloadData() // 테이블 뷰 reload
    }
    
    // reponse의 header 수신
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        guard let response = response as? HTTPURLResponse,
              (200...299).contains(response.statusCode),
              let mimeType = response.mimeType,
              mimeType == "application/json" else {
            completionHandler(.cancel)
            return
        }
        completionHandler(.allow)
    }
    // data 받음
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.receivedData?.append(data)
    }
    // 통신이 완료된 후 호출
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        DispatchQueue.main.async {
            guard error == nil else {
                // handle client error
                return
            }
            if let receivedData = self.receivedData {
                // Parsing
                let decoder = JSONDecoder()
                let parsingData = try? decoder.decode(MovieInfo.self, from: receivedData)
                
                if let movelist = parsingData?.hoppin.movies.movie {
                    self.addTableData(movelist) // 테이블 데이터 추가
                }
            }
        }
    }
}



