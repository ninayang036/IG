//
//  WallCollectionViewController.swift
//  IG
//
//  Created by Yang Nina on 2021/5/24.
//

import UIKit

private let reuseIdentifier = "Cell"

class WallCollectionViewController: UICollectionViewController {
    var userInfo:IGResponse?
    var postImages = [IGResponse.Graphql.User.Edge_owner_to_timeline_media.Edges]()
    func fetchData(){
        //let urlStr = "https://www.instagram.com/sweethouse.sl/?__a=1"
        let urlStr = "http://127.0.0.1/IGJSON.json"
        if let url = URL(string: urlStr){
            URLSession.shared.dataTask(with: url) { data, response, error in
                let decoder = JSONDecoder()
                //ex:May 26,2021 at 1:59 PM
                decoder.dateDecodingStrategy = .secondsSince1970
                if let data = data {
                    do {
                        let searchResponse = try decoder.decode(IGResponse.self, from: data)
                        self.userInfo = searchResponse
                        DispatchQueue.main.async {
                            self.postImages = (self.userInfo?.graphql.user.edge_owner_to_timeline_media.edges)!
                            self.navigationItem.title = self.userInfo?.graphql.user.username
                            self.navigationItem.backButtonTitle = ""
                            self.collectionView.reloadData()
                        }
                    } catch {
                        print(error)
                    }

                }
            }.resume()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCellSize()
        fetchData()
    }
    func configureCellSize(){
        let itemSpace:CGFloat = 3
        let columnCount:CGFloat = 3
        
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let width = floor(((collectionView.bounds.width) - itemSpace * (columnCount - 1)) / columnCount)
        flowLayout?.itemSize = CGSize(width: width, height: width)
        flowLayout?.estimatedItemSize = .zero
        flowLayout?.minimumInteritemSpacing = itemSpace
        flowLayout?.minimumLineSpacing = itemSpace
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        //return 12
        return postImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(WallCollectionViewCell.self)", for: indexPath) as? WallCollectionViewCell else {return UICollectionViewCell()}
        //cell.showphotoImg.image = UIImage(named: "Pic\(indexPath.item)")
        let item = postImages[indexPath.item]
        //圖片是抓URL
        URLSession.shared.dataTask(with: item.node.display_url) { data, response, error in
            if let data = data{
                DispatchQueue.main.async {
                    cell.showphotoImg.image = UIImage(data: data)
                }
            }
        }.resume()
        return cell
    }
   
//ProfileCollectuinReusableView
override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    //ReusableView的ofKind設定為Header, ID對象是userInfo的reusableView, as轉型為自訂reusableView型別
    guard let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(ProfileCollectionReusableView.self)", for: indexPath) as? ProfileCollectionReusableView else { return UICollectionReusableView()}
    if let userImgUrl = userInfo?.graphql.user.profile_pic_url{
        URLSession.shared.dataTask(with: userImgUrl) { data, response, error in
            if let data = data{
                DispatchQueue.main.async {
                    reusableView.headshotImg.image = UIImage(data: data)
                }
            }
        }.resume()
    }
    if let postsCount = userInfo?.graphql.user.edge_owner_to_timeline_media.count,
       let follower = userInfo?.graphql.user.edge_followed_by.count,//Int
       let following = userInfo?.graphql.user.edge_follow.count,
       let username = userInfo?.graphql.user.full_name,
       let category = userInfo?.graphql.user.category_name,
       let intro = userInfo?.graphql.user.biography{
        let tpostCount = Int(postsCount)/1000
        let hpostCount = Int(postsCount - tpostCount * 1000)
        reusableView.postsLabel.text = String("\(tpostCount),\(hpostCount)")
        let followercount = Float(follower)/10000
        reusableView.followersLabel.text = String(format: "%.1f", followercount)+"萬"
        reusableView.followingLabel.text = String(following)
        reusableView.usernameLabel.text = username
        reusableView.categoryLabel.text = category
        reusableView.introLabel.text = intro
    }
    //reusableView.userAccountLabel.text = "sweethouse.sl"
    reusableView.headshotImg.layer.cornerRadius = reusableView.headshotImg.bounds.width/2
    for i in reusableView.Buttons{
        i.layer.cornerRadius = 5
        i.layer.borderWidth = 1
        i.layer.borderColor = UIColor(red: 218/255, green: 219/255, blue: 218/255, alpha: 1).cgColor
    }
    return reusableView
}

    @IBSegueAction func detailPost(_ coder: NSCoder) -> PostDetailCollectionViewController? {
        guard let row = collectionView.indexPathsForSelectedItems?.first?.row else { return nil }
        return PostDetailCollectionViewController(coder: coder, IGData: userInfo!, indexPath: row)
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
