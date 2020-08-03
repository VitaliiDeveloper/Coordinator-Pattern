//
//  WordDetailView.swift
//  SkyEng_Task
//
//  Created by Vitalii Lavreniuk on 8/3/20.
//  Copyright © 2020 Vitalii Lavreniuk. All rights reserved.
//

import UIKit

final class WordDetailView: BaseView {
  var tableView = UITableView()
  var cellAttributes = [String : [WordDetailTableViewCellAttributes]]()
  var sectionTitles = [String]()
  
  let bgImageView = UIImageView(image: UIImage(named: "search-pngrepo-com")!)
  
  override func firstInitialization() {
    super.firstInitialization()
    
    self.backgroundColor = .white
    
    self.addSubview(bgImageView)
    
    tableView.isHidden = true
    tableView.dataSource = self
    tableView.delegate = self
    self.addSubview(tableView)
    
    tableView.register(UINib(nibName: "WordDetailTableViewCell", bundle: Bundle.main  ), forCellReuseIdentifier: "WordDetailTableViewCell")
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
      
      tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                     constant: 0),
      tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                                        constant: 0),
      tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                         constant: 0),
      tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                          constant: 0)
    ])
  }
  
  func createAttributes(from models:[MeaningsWordDataModel<String>]) {
    self.cellAttributes = [:]
    self.sectionTitles = []
    
    for model in models {
      if let translation = model.translation?.text {
        self.cellAttributes[translation] = []
        self.sectionTitles.append(translation)
        
        let attr = WordDetailTableViewCellAttributes()
        attr.id = model.id
        attr.wordID = model.wordId ?? 0
        
        if let url = URL(string: "https:" + (model.images?[0].url ?? "")), let data = try? Data(contentsOf: url) {
          attr.image = UIImage(data: data)
        }
        
        attr.text = model.text ?? ""
        attr.translation = model.translation?.text ?? ""
        attr.note = model.translation?.note ?? ""
        attr.definition = model.definition?.text ?? ""
        
        self.cellAttributes[translation]!.append(attr)
      }
    }
    
    self.tableView.isHidden = false
    self.tableView.reloadData()
  }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension WordDetailView: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.sectionTitles.count
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
    return self.cellAttributes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "WordDetailTableViewCell") as! WordDetailTableViewCell
    cell.selectionStyle = .none
    
    let attr = self.cellAttributes[sectionTitles[indexPath.section]]![indexPath.row]
    
    cell.set(attributes: attr)
    
    return cell
  }
}
