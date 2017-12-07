//
//  NewsTableViewController.swift
//  NYTimesApp
//
//  Created by Giovanny Rocha on 11/22/17.
//  Copyright © 2017 Giovanny Rocha. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewsTableViewController: UITableViewController, UISearchBarDelegate {

    var news = [News]()
    //var urlAPI:String
    let urlAPI = "https://api.nytimes.com/svc/search/v2/articlesearch.json"
    let urlImage = "http://www.nytimes.com/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchText.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return news.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        
        let auxNews = news[indexPath.row]
        cell.labelResumeNews.text = auxNews.headLine
        cell.labelSourceNews.text = auxNews.source
        cell.labelDateNews.text = auxNews.pubDate
        if auxNews.urlImageThumbnail != "" {
            //print("url es \(auxNews.urlImageThumbnail)")
            let imageAux:NSData = try! NSData(contentsOf: auxNews.urlImageThumbnail.asURL())!
            cell.imageView?.image = UIImage(data:imageAux as Data)
        } else {
            cell.imageView?.image = #imageLiteral(resourceName: "no_image1")
        }
        

        // Configure the cell...

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let viewController = segue.destination as? ViewController
    
        // click in row
        if let selectedIndexPath = tableView.indexPathForSelectedRow{
            let newsAux = self.news[selectedIndexPath.row]
            
            viewController?.headLine = newsAux.headLine
            viewController?.snippet = newsAux.snippet
            viewController?.source = newsAux.source
            viewController?.publicationDate = newsAux.pubDate
            viewController?.urlImage = newsAux.urlImageXLarge
            
        }
    
    }
 

    @IBOutlet weak var searchText: UISearchBar!
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        //print("Metodo searchBarSearchButtonClicked \(searchBar.text)")
        
        self.news.removeAll()
        searchNews(searchNews: searchBar.text!)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        //print("Metodo searchBarCancelButtonClicked \(searchBar.text)")
        searchBar.text = ""
    }
    
    func searchNews(searchNews: String){
        var urlXlarge:String = ""
        var urlThumbnail:String = ""
        
        // GET
        
        let parameters:Parameters = [
            "api-key" : "0bf4b3a0da1f4087903e092866bd2ac1",
            "sort": "newest",
            "q" : searchNews
        ]
        
        Alamofire.request(urlAPI, method: .get, parameters: parameters).responseJSON { response in
            
            
            if let data = response.data, let _ = String(data: data, encoding: .utf8) {
                //print("Data: \(utf8Text)") // original server data as UTF8 string
                let json = try! JSON(data: data)
                
                for (_,subJson):(String, JSON) in json["response"]["docs"] {
                    // Do something you want
                    
                    for (_,subJson1):(String, JSON) in subJson["multimedia"]{
                        
                        if subJson1["legacy"]["xlarge"] != JSON.null{
                            urlXlarge = self.urlImage + subJson1["legacy"]["xlarge"].string!
                        }
                        
                        if subJson1["legacy"]["thumbnail"] != JSON.null{
                            urlThumbnail = self.urlImage + subJson1["legacy"]["thumbnail"].string!
                        }
                    }
                    
                    let headlineAux = subJson["headline"]["main"].string
                    let snippetAux = subJson["snippet"].string
                    let sourceAux = subJson["source"].string
                    let pubDateJson = subJson["pub_date"].string
                    
                    let isoFormatter = DateFormatter()
                    isoFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ"
                    isoFormatter.locale = Locale(identifier: "en_US_POSIX")
                    let date = isoFormatter.date(from: pubDateJson!)
                    isoFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
                    isoFormatter.locale = Locale(identifier: "en_US_POSIX")
                    let pubDateAux = isoFormatter.string(from: date!)
                    
                    let newsAux = News(id: NSUUID().uuidString, headLine: headlineAux!, snippet: snippetAux!, pubDate: pubDateAux, source: sourceAux!, urlImageXLarge: urlXlarge, urlImageThumbnail: urlThumbnail)
                    
                    self.news.append(newsAux!)
                }
                
                self.tableView.reloadData()
            }
        }
    }
    
}
