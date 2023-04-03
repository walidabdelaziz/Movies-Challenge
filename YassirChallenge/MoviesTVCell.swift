//
//  MoviesTVCell.swift
//  YassirChallenge
//
//  Created by Walid Ahmed on 03/04/2023.
//

import UIKit
import SDWebImage

class MoviesTVCell: UITableViewCell {
    @IBOutlet weak var bgV: UIView!
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    
    var movie: Movies? {
        didSet {
            guard let movie = movie else { return }
            movieImg.sd_setImage(with: URL(string: "\(Consts.baseURLForPosters)\(movie.posterPath ?? "")"))
            movieNameLbl.text = movie.title ?? ""
            let dateConverted = Utils.StringToDateThenToString(dateStr: movie.releaseDate ?? "", oldFormat: "yyyy-MM-dd", newFormat: "yyyy")
            yearLbl.text = dateConverted
        }
    }
            
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
