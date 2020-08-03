//
//  WordDetailTableViewCell.swift
//  SkyEng_Task
//
//  Created by Vitalii Lavreniuk on 8/3/20.
//  Copyright © 2020 Vitalii Lavreniuk. All rights reserved.
//

import UIKit

final class WordDetailTableViewCell: UITableViewCell, TableViewCellDataSource {
  
  @IBOutlet weak var wordImageView: UIImageView!
  @IBOutlet weak var wordLabel: UILabel!
  @IBOutlet weak var noteLabel: UILabel!
  @IBOutlet weak var definitionTextView: UITextView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    wordImageView.layer.cornerRadius = wordImageView.bounds.size.width / 2
  }
  
  func set(attributes: Any) {
    guard let attributes = attributes as? WordDetailTableViewCellAttributes else { return }
    
    self.wordImageView.image = attributes.image
    self.wordLabel.text = attributes.text
    self.noteLabel.text = attributes.note
    self.definitionTextView.text = attributes.definition
  }
}
