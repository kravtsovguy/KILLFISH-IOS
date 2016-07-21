//
//  MusicViewController.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 07.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import UIKit
import MapKit

class MusicViewController: MasterNavViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var nowView: MusicNowView!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var bottomC: NSLayoutConstraint!
    var searchController = UISearchController(searchResultsController: nil)
    
    var locationManager = CLLocationManager()
    
    var items: [MusicInfo] = []
    var filteredItems: [MusicInfo] = []
    
    var buyed = [Int:Double]()
    
   /* override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        let app = UIApplication.sharedApplication()
        if searchController.active && !app.statusBarHidden && searchController.searchBar.frame.origin.y == 0 {
            if let container = self.searchController.searchBar.superview {
                container.frame = CGRectMake(container.frame.origin.x, container.frame.origin.y, container.frame.size.width, container.frame.size.height + app.statusBarFrame.height)
            }
        }
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        if !App.ios9{
            //bottomC.constant += 100
        }
        
        App.musicView = self
        
        view.backgroundColor = UIColor.clearColor()
        
        App.loadCacheMusicCost()
        App.loadCacheMusic()
        items = App.music
        
        tableView.reloadData()
        
        
        /*
        let searchBar:UISearchBar = UISearchBar(frame: CGRectMake(0, 0, 200, 20))
        
        searchBar.placeholder = "Название"
        let rightNavBarButton = UIBarButtonItem(customView:searchBar)
        App.servicesView.navigationItem.rightBarButtonItem = rightNavBarButton
*/
    
        
        //self.edgesForExtendedLayout = .None
        
        searchController.searchBar.tintColor = UIColor.whiteColor()
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        //App.servicesView.navigationItem.titleView = self.searchController.searchBar;
        self.searchController.searchBar.searchBarStyle = UISearchBarStyle.Minimal;
        //self.extendedLayoutIncludesOpaqueBars = true;
        //self.hidesBottomBarWhenPushed
        searchController.dimsBackgroundDuringPresentation = false
        //self.edgesForExtendedLayout = UIRectEdge.None;
        definesPresentationContext = true
        //self.tableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
        
        searchController.searchBar.sizeToFit()
        
        searchController.searchBar.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
        //searchController.searchBar.backgroundImage = UIColor
        
        
        let tf = searchController.searchBar.valueForKey("searchField") as? UITextField
        tf?.textColor = UIColor.whiteColor()
        
        searchView.addSubview(searchController.searchBar)
        //tableView.tableHeaderView = searchController.searchBar
        
        self.tableView.backgroundView = UIView()
        
        /*
        let temp = searchController.searchBar
        temp.barStyle = .BlackTranslucent;
        temp.showsCancelButton = true;
        temp.autocorrectionType = .No;
        temp.autocapitalizationType = .None;
        //temp.delegate=self;
        self.tableView.tableHeaderView=temp;
*/
        
        setupInfoBtn("Справка", msg: "Закажите вашу любимую песню. Публичное исполнение музыкальных произведений организовано и осуществляется компанией HARLEX SALES Limited Liability Partnership")
        
        self.nowView.setup(nil, bar: nil)
        setupLocationManager()
        
        APICalls.getMusicCost { _ in}
        
        APICalls.getMusic { (music) -> Void in
            self.items = music
            self.tableView.reloadData()
        }

    }
    
    override func dismissKeyboard() {
        searchController.dismissKeyboard()
    }
    
    override func viewWillAppear(animated: Bool) {
        //super.viewWillAppear(animated)
        
        //APICalls.getMusicPlay{_ in }
        

        
        //tableView.tableHeaderView = nil
        //self.nowView.hidden = true
        //nowView.frame.size.height = 0
        //self.tableView.tableHeaderView?.frame.size.height = 0
        
        setupNowView()
    }
    
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.distanceFilter = 50
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() && (CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse || CLLocationManager.authorizationStatus() == .AuthorizedAlways){
            locationManager.startUpdatingLocation()
        }

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredItems = items.filter { item in
            return item.title.lowercaseString.containsString(searchText.lowercaseString) || item.artist.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredItems.count
        }
        return items.count
        
        //return filteredItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("musicCell")! as! MusicViewCell
        
        var item: MusicInfo!
        
        if self.searchController.active && self.searchController.searchBar.text != "" {
            item = self.filteredItems[indexPath.row]
        } else {
            item = self.items[indexPath.row]
        }
        if buyed[item.id] != nil{
            item.lastBuy = buyed[item.id]!
        }
        cell.setup(item)
        //cell.setup(filteredItems[indexPath.row])
        //cell.setup(items[indexPath.row])
        cell.accessoryType = UITableViewCellAccessoryType.None
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
        cell.selectedBackgroundView = bgColorView
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let alertController = UIAlertController(title: "Заказ песни", message:
            "Вы хотите вне очереди проиграть данную композицию во всех барах KillFish?\nОбратите внимание, с Вашего счёта будет списано \(App.musicCost/100) \(App.curr).\nЕсли у Вас золотая карта, то Вам доступно 5 бесплатных заказов в сутки, если серебряная, то 2", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Заказать", style: UIAlertActionStyle.Default,handler: { (action: UIAlertAction!) in
            
            
            
            var item: MusicInfo!
            
            if self.searchController.active && self.searchController.searchBar.text != "" {
                item = self.filteredItems[indexPath.row]
            } else {
                item = self.items[indexPath.row]
            }
            
            APICalls.buyMusic(item.id, onCompletion: { (msg) -> Void in
                
                JLToast.makeText(msg, duration: JLToastDelay.LongDelay).show()
                self.buyed[item.id] = NSDate().timeIntervalSince1970
                tableView.reloadData()
                
                }, onError: { (err) -> Void in
                    
                JLToast.makeText(err, duration: JLToastDelay.LongDelay).show()
                    
            })

            /*
            JLToast.makeText("Заказ принят!", duration: JLToastDelay.LongDelay).show()
            self.buyed[item.id] = NSDate().timeIntervalSince1970
            tableView.reloadData()
            */
        }))
        
        alertController.addAction(UIAlertAction(title: "Отмена", style: UIAlertActionStyle.Cancel,handler: { (action: UIAlertAction!) in
        }))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    var isReady = false
    
    func setupNowView(){
        if let loc = locationManager.location{
            updateNowMusic(loc)
        }
    }
    
    func updateNowMusic(loc: CLLocation){
        APICalls.getBarsByCoords(loc.coordinate.latitude, lon: loc.coordinate.longitude, distance: 500) { (bars) -> Void in
            
            if bars.count>0 {
                
                APICalls.getCurrentStream(bars[0].id, onCompletion:{ (stream) -> Void in
                    
                    var str = stream.stream
                    if str == "listen" {
                        str+="1"
                    }
                    
                    APICalls.getMusicPlay(str,onCompletion: { (musicPlay) -> Void in
                        if musicPlay.count>0{
                            //self.tableView.tableHeaderView = self.nowView
                            //self.nowView.hidden = false
                            //self.tableView.tableHeaderView?.frame.size.height = 70
                            //self.nowView.frame.size.height = 70
                            self.nowView.setup(musicPlay[0], bar: bars[0])
                        }
                    })
                })
                
            }else{
                self.nowView.setup(nil, bar: nil)
            }

        }
    }

}

extension MusicViewController: UISearchResultsUpdating, CLLocationManagerDelegate {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .Authorized, .AuthorizedWhenInUse:
            manager.startUpdatingLocation()
        default: break
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let loc = locations.last! as CLLocation
        
        /*
        if isReady{
            return
        }
        isReady = true
        */
        //distance: 500
        updateNowMusic(loc)
    }
    
}
