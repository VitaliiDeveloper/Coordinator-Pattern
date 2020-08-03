//
//  SearchWordsView.swift
//  SkyEng_Task
//
//  Created by Vitalii Lavreniuk on 8/2/20.
//  Copyright © 2020 Vitalii Lavreniuk. All rights reserved.
//

import UIKit

protocol SearchWordsViewDelegate:AnyObject {
  func searchWordsView(_ view:SearchWordsView, didSelectAttributes:SearchWordTableViewCellAttributes)
}

final class SearchWordsView: BaseView {
  weak var delegate:SearchWordsViewDelegate?
  
  let bgImageView = UIImageView(image: UIImage(named: "search-pngrepo-com")!)
  
  var tableView = UITableView()
  var cellAttributes = [String : [SearchWordTableViewCellAttributes]]()
  var sectionTitles = [String]()
  
  override func firstInitialization() {
    super.firstInitialization()
    
    self.backgroundColor = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1)
    
    self.addSubview(bgImageView)
    
    tableView.layer.cornerRadius = 20
    tableView.showsVerticalScrollIndicator = false
    tableView.isHidden = true
    tableView.delegate = self
    tableView.dataSource = self
    self.addSubview(tableView)
    
    tableView.register(UINib(nibName: "SearchWordTableViewCell", bundle: Bundle.main),
                       forCellReuseIdentifier: "SearchWordTableViewCell")
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    
    bgImageView.translatesAutoresizingMaskIntoConstraints = false
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      bgImageView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
      bgImageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
      bgImageView.widthAnchor.constraint(equalToConstant: 100),
      bgImageView.heightAnchor.constraint(equalToConstant: 100),
      
      tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
      tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
      tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
      tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10)
    ])
  }
  
  func createAttributes(from models:[SearchWordDataModel]) {
    sectionTitles = []
    self.cellAttributes = [:]
    
    for model in models {
      sectionTitles.append(model.text)
      
      self.cellAttributes[model.text] = []
      
      if let meanings = model.meanings {
        var index = 1
        
        for meaning in meanings {
          autoreleasepool { [unowned self] in
            let attr = SearchWordTableViewCellAttributes()
            attr.id = meaning.id
            attr.index = index
            attr.translatedWord = meaning.translation?.text ?? ""
            attr.notes = meaning.translation?.note ?? ""
            
            self.cellAttributes[model.text]?.append(attr)
            
            index += 1
          }
        }
      }
    }
    
    self.tableView.isHidden = false
    self.tableView.reloadData()
  }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension SearchWordsView: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.searchWordsView(self, didSelectAttributes: self.cellAttributes[sectionTitles[indexPath.section]]![indexPath.row])
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return cellAttributes.count
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = Bundle.main.loadNibNamed("TitledTableViewHeader", owner: self, options: nil)![0] as! TitledTableViewHeader
    view.label.text = self.sectionTitles[section]
   
    return view
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let key = sectionTitles[section]
    return cellAttributes[key]?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SearchWordTableViewCell") as! SearchWordTableViewCell
    cell.selectionStyle = .none
    
    let key = sectionTitles[indexPath.section]
    let attr = cellAttributes[key]![indexPath.row]
    
    cell.set(attributes: attr)
    
    return cell
  }
}
