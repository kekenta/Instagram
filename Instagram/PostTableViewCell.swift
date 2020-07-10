//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 0002 QBS on 2020/06/21.
//  Copyright © 2020 0002 QBS. All rights reserved.
//

import UIKit
import FirebaseUI


class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!

    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
        
    // PostDataの内容をセルに表示
    func setPostData(_ postData: PostData)
    {
        // 画像の表示
        postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postData.id + ".jpg")
        postImageView.sd_setImage(with: imageRef)

        // キャプションの表示
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"

        // 日時の表示
        self.dateLabel.text = ""
        if let date = postData.date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = formatter.string(from: date)
            self.dateLabel.text = dateString
        }

        // いいね数の表示
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"

        // いいねボタンの表示
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
        
        //コメントの表示
        // 表示名とコメントを格納する配列
        //var convComments: [String] = []
        // コメント格納用の配列allCommentを空に設定する
        var allComment = ""
        var commentLiv2 = ""
        // コメントラベルに複数行の表示が行えるように設定する
        commentLabel.numberOfLines = 0;
        // postData.commentsの中から要素を１行ずつ取り出しcommentLivへ格納後、表示に合わせて要素を取り出す
        
        for arrayCount in postData.comments{
            commentLiv2 = "\(arrayCount["commentname"]!) ： \(arrayCount["comment"]!)"
            // 複数のコメントがある場合に「コメント入力者名 : コメント内容」の形の文字列にし、
            // それに改行を加えながら全てのコメントを全てallCommentに入れる
            allComment += (commentLiv2 + "\n")
            // allCommentの内容をcommentLabelに表示する
            self.commentLabel.text = allComment
        }
    }
}
