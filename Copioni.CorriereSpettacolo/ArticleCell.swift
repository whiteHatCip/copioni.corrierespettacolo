//
//  ArticleCell.swift
//  Copioni.CorriereSpettacolo
//
//  Created by Fabio Cipriani on 01/09/16.
//  Copyright © 2016 Fabio Cipriani. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var AuthorAndTitleLbl: UILabel!
    @IBOutlet weak var DateLbl: UILabel!
    @IBOutlet weak var pdfImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(_ article: Article) {
        AuthorAndTitleLbl.text = "\(article.author) - \(article.title)"
        DateLbl.text = article.date
        pdfImage.image = UIImage(named: "pdf")
    }
    
}
