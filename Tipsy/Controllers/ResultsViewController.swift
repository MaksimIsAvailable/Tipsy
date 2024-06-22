//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Maksim on 19.06.2024.
//

import UIKit
final class ResultsViewController: UIViewController {
    // MARK: - Dependencies
    var result = "0.0"
    var tip = 10
    var split = 2
    
    // MARK: - UI Properties
    private lazy var firstViewResult: UIView = {
        let element = UIView()
        element.backgroundColor = UIColor(red: 0.51, green: 0.71, blue: 1.00, alpha: 1.00)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var secondtViewResult: UIView = {
        let element = UIView()
        element.backgroundColor = UIColor(red: 0.99, green: 1.00, blue: 0.89, alpha: 1.00)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var recalculateButton: UIButton = {
        let element = UIButton()
        element.setTitle("Recalculate", for: .normal)
        element.setTitleColor(.white, for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .regular)
        element.layer.cornerRadius = 8
        element.backgroundColor = UIColor(red: 0.10, green: 0.13, blue: 0.19, alpha: 1.00)
        element.addTarget(self, action: #selector(recalculatePressed), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var totalPersonLabel: UILabel = {
        let element = UILabel()
        element.text = "Total per person"
        element.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        element.textColor = UIColor(red: 0.35, green: 0.45, blue: 0.63, alpha: 1.00)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var totalLabel: UILabel = {
        let element = UILabel()
        element.text = result
        element.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        element.textColor = UIColor(red: 0.10, green: 0.13, blue: 0.19, alpha: 1.00)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var settingsLabel: UILabel = {
        let element = UILabel()
        element.text = "Split between \(split) people, with \(tip)% tip."
        element.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        element.textColor = UIColor(red: 0.35, green: 0.45, blue: 0.63, alpha: 1.00)
        element.numberOfLines = 0
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()






    
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstrains()

        //totalLabel.text = result
        //settingsLabel.text = "Split between \(split) people, with \(tip)% tip."

    }
    
    // MARK: - Private methods
    private func setupUI() {
        view.addSubview(firstViewResult)
        view.addSubview(secondtViewResult)
        view.addSubview(recalculateButton)
        firstViewResult.addSubview(totalPersonLabel)
        firstViewResult.addSubview(totalLabel)
        secondtViewResult.addSubview(settingsLabel)
    }
    
    // MARK: - Selector methods
    @objc private func recalculatePressed(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - Setup Constraints
private extension ResultsViewController {
    func setupConstrains() {
        NSLayoutConstraint.activate([
            
            firstViewResult.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            firstViewResult.bottomAnchor.constraint(equalTo: secondtViewResult.topAnchor),
            firstViewResult.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            firstViewResult.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            secondtViewResult.heightAnchor.constraint(equalToConstant: view.frame.width / 0.8),
            secondtViewResult.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            secondtViewResult.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            secondtViewResult.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            totalPersonLabel.centerXAnchor.constraint(equalTo: firstViewResult.centerXAnchor),
            totalPersonLabel.topAnchor.constraint(equalTo: firstViewResult.topAnchor, constant: 110),
            
            totalLabel.centerXAnchor.constraint(equalTo: firstViewResult.centerXAnchor),
            totalLabel.topAnchor.constraint(equalTo: totalPersonLabel.bottomAnchor, constant: 30),
            
            settingsLabel.centerXAnchor.constraint(equalTo: secondtViewResult.centerXAnchor),
            settingsLabel.topAnchor.constraint(equalTo: secondtViewResult.topAnchor, constant: 60),
            settingsLabel.trailingAnchor.constraint(equalTo: secondtViewResult.trailingAnchor, constant: -60),
            settingsLabel.leadingAnchor.constraint(equalTo: secondtViewResult.leadingAnchor, constant: 60),

            
            recalculateButton.widthAnchor.constraint(equalToConstant: 230),
            recalculateButton.heightAnchor.constraint(equalToConstant: 55),
            recalculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recalculateButton.bottomAnchor.constraint(equalTo: secondtViewResult.safeAreaLayoutGuide.bottomAnchor),
            

        ])
    }
}
