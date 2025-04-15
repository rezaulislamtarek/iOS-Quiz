//
//  TopicListController.swift
//  iOS Quiz
//
//  Created by Rezaul Islam on 12/4/25.
//

import UIKit
import Combine

class TopicListController: UIViewController {
    private var cancellable = Set<AnyCancellable>()
    private let viewModel : TopicViewModel
    private var topics : [Topic] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    init(viewModel: TopicViewModel = TopicViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setupUI()
        
        
        
        bindviewModel()
        
    }
    
    
    private func bindviewModel() {
        viewModel.$topicList.sink { [weak self] data in
            self?.topics = data
            self?.tableView.reloadData()
        }.store(in: &cancellable)
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        self.title = "iOS Quiz"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TopicCellTableViewCell.self, forCellReuseIdentifier: TopicCellTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.showsVerticalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

extension TopicListController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TopicCellTableViewCell.identifier, for: indexPath) as? TopicCellTableViewCell else {
            return UITableViewCell()
            
        }
        cell.configure(with: topics[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped on: \(topics[indexPath.row].name)")
        let playerController = QuizPlayerController(topic: topics[indexPath.row].name)
        navigationController?.pushViewController(playerController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

