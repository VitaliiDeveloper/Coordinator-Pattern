//
//  SearchWordTableViewCell.swift
//  SkyEng_Task
//
//  Created by Vitalii Lavreniuk on 8/2/20.
//  Copyright © 2020 Vitalii Lavreniuk. All rights reserved.
//

import UIKit

final class SearchWordTableViewCell: UITableViewCell, TableViewCellDataSource {
  var id:Int?
  
  @IBOutlet weak var indexLabel: UILabel!
  @IBOutlet weak var translatedWordLabel: UILabel!
  @IBOutlet weak var noteLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.indexLabel.layer.cornerRadius = self.indexLabel.frame.size.width / 2
    self.indexLabel.layer.borderColor = UIColor.blue.cgColor
    self.indexLabel.layer.borderWidth = 1
  }
  
  func set(attributes: Any) {
    guard let attributes = attributes as? SearchWordTableViewCellAttributes else { assertionFailure("Wrong type"); return }
    
    self.id = attributes.id
    
    self.indexLabel.text = attributes.index.description
    self.translatedWordLabel.text = attributes.translatedWord
    self.noteLabel.text = attributes.notes
  }
}
