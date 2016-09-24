//
//  MainViewController.swift
//  moviewall
//
//  Created by KUAN-YING CHOU on 9/24/16.
//  Copyright © 2016 KUAN-YING CHOU. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

let movies_id = [76341, 76343, 76344]
var movies = [(String, String)]()
let api_key = "553ac01e8b3b3cc0c17b6489fca129a5"
let tmdb_url = "https://api.themoviedb.org/3"

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        for movie_id in movies_id {
            Alamofire.request(tmdb_url + "/movie/\(String(movie_id))?api_key=\(api_key)").responseJSON { (response) in
                if let JSON = response.result.value {
                    let abc:NSDictionary = JSON as! NSDictionary
                    print(JSON)
                    if let name = abc.value(forKey: "original_title"), let imageUrl = abc.value(forKey: "poster_path") {
                        print(name)
                        print(imageUrl)
                        movies.append((name as! String, imageUrl as! String))
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - UITableViewDataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = movies[indexPath.row].0
        cell?.imageView?.sd_setImage(with: URL.init(string: "https://image.tmdb.org/t/p/w370_and_h556_bestv2\(movies[indexPath.row].1)"), placeholderImage: UIImage.init(named: "movie"))
        return cell!
    }
}
