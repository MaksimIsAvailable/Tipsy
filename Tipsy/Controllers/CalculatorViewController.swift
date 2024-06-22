//
//  ViewController.swift
//  Tipsy
//
//  Created by Maksim on 17.06.2024.
//

import UIKit

final class CalculatorViewController: UIViewController {
    // MARK: - Dependencies
    var tip = 0.10
    var numberOfPeople = 2
    var billTotal = 0.0
    var finalResult = "0.0"
    let resultsViewController = ResultsViewController()
    
    // MARK: - UI Properties
    private lazy var firstView: UIView = {
        let element = UIView()
        element.backgroundColor = UIColor(red: 0.99, green: 1.00, blue: 0.89, alpha: 1.00)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var secondView: UIView = {
        let element = UIView()
        element.backgroundColor = UIColor(red: 0.51, green: 0.71, blue: 1.00, alpha: 1.00)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var enterBillTotalLabel: UILabel = {
        let element = UILabel()
        element.text = "Enter bill total"
        element.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        element.textColor = UIColor(red: 0.35, green: 0.45, blue: 0.63, alpha: 1.00)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var billTextField: UITextField = {
        let element = UITextField()
        element.placeholder = "e.g. 123.56"
        element.font = UIFont.systemFont(ofSize: 45, weight: .regular)
        element.textAlignment = .center
        element.textColor = UIColor(red: 0.10, green: 0.13, blue: 0.19, alpha: 1.00)
        element.keyboardType = .decimalPad
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var selectTipLabel: UILabel = {
        let element = UILabel()
        element.text = "Select tip"
        element.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        element.textColor = UIColor(red: 0.35, green: 0.45, blue: 0.63, alpha: 1.00)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var pctButtonsStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.alignment = .center
        element.spacing = 40
        element.distribution = .fillEqually
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var zeroPctButton: UIButton = {
        let element = UIButton()
        element.setTitle("0%", for: .normal)
        element.setTitleColor(UIColor(red: 0.10, green: 0.13, blue: 0.19, alpha: 1.00), for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .regular)
        element.addTarget(self, action: #selector(tipChanged), for: .touchUpInside)
        element.layer.borderWidth = 1
        element.layer.cornerRadius = 8
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var tenPctButton: UIButton = {
        let element = UIButton()
        element.setTitle("10%", for: .normal)
        element.setTitleColor(UIColor(red: 0.10, green: 0.13, blue: 0.19, alpha: 1.00), for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .regular)
        element.addTarget(self, action: #selector(tipChanged), for: .touchUpInside)
        element.layer.borderWidth = 1
        element.layer.cornerRadius = 8
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var twentyPctButton: UIButton = {
        let element = UIButton()
        element.setTitle("20%", for: .normal)
        element.setTitleColor(UIColor(red: 0.10, green: 0.13, blue: 0.19, alpha: 1.00), for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .regular)
        element.addTarget(self, action: #selector(tipChanged), for: .touchUpInside)
        element.layer.borderWidth = 1
        element.layer.cornerRadius = 8
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var chooseSplitLabel: UILabel = {
        let element = UILabel()
        element.text = "Choose Split"
        element.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        element.textColor = UIColor(red: 0.35, green: 0.45, blue: 0.63, alpha: 1.00)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var splitNumberLabel: UILabel = {
        let element = UILabel()
        element.text = "2"
        element.textColor = UIColor(red: 0.10, green: 0.13, blue: 0.19, alpha: 1.00)
        element.font = UIFont.systemFont(ofSize: 40, weight: .regular)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var stepper: UIStepper = {
        let element = UIStepper()
        element.value = 2
        element.minimumValue = 2
        element.maximumValue = 25
        element.stepValue = 1
        element.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        element.addTarget(self, action: #selector(stepperValueChanged), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var calculateButton: UIButton = {
        let element = UIButton()
        element.setTitle("Calculate", for: .normal)
        element.setTitleColor(.white, for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .regular)
        element.layer.cornerRadius = 8
        element.backgroundColor = UIColor(red: 0.10, green: 0.13, blue: 0.19, alpha: 1.00)
        element.addTarget(self, action: #selector(calculatePressed), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.99, green: 1.00, blue: 0.89, alpha: 1.00)
        setupUI()
        setupConstrains()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        view.addSubview(firstView)
        view.addSubview(secondView)
        
        firstView.addSubview(enterBillTotalLabel)
        firstView.addSubview(billTextField)
        
        secondView.addSubview(selectTipLabel)
        secondView.addSubview(pctButtonsStackView)
        secondView.addSubview(chooseSplitLabel)
        secondView.addSubview(splitNumberLabel)
        secondView.addSubview(stepper)
        secondView.addSubview(calculateButton)
        
        pctButtonsStackView.addArrangedSubview(zeroPctButton)
        pctButtonsStackView.addArrangedSubview(tenPctButton)
        pctButtonsStackView.addArrangedSubview(twentyPctButton)
    }
    
    // MARK: - Selector methods
    @objc private func tipChanged(_ sender: UIButton) {
        
        billTextField.endEditing(true)
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true

        
        updateButtonStyles()
        
        let buttonTitle = sender.currentTitle!
        let buttonTitleMinusPercentSign =  String(buttonTitle.dropLast())
        let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
        tip = buttonTitleAsANumber / 100
    }
    
    private func updateButtonStyles() {
        let buttons = [zeroPctButton, tenPctButton, twentyPctButton]
        for button in buttons {
            if button.isSelected {
                button.backgroundColor = UIColor(red: 0.10, green: 0.13, blue: 0.19, alpha: 1.00)
                button.setTitleColor(UIColor.white, for: .normal)
            } else {
                button.backgroundColor = UIColor.clear
                button.setTitleColor(UIColor(red: 0.10, green: 0.13, blue: 0.19, alpha: 1.00), for: .normal)
            }
        }
    }
    
    @objc private func calculatePressed(_ sender: UIButton) {
        
        let bill = billTextField.text!
        if bill != "" {
            billTotal = Double(bill)!
            let result = billTotal * (1 + tip) / Double(numberOfPeople)
            finalResult = String(format: "%.2f", result)
        }

        let resultsVC = ResultsViewController()
            resultsVC.result = finalResult
            resultsVC.tip = Int(tip * 100)
            resultsVC.split = numberOfPeople
            
            self.present(resultsVC, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.result = finalResult
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = numberOfPeople
        }
    }
    
    @objc private func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
    }
}

// MARK: - Setup Constraints
private extension CalculatorViewController {
    func setupConstrains() {
        NSLayoutConstraint.activate([
            firstView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            firstView.bottomAnchor.constraint(equalTo: secondView.topAnchor),
            firstView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            firstView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            secondView.heightAnchor.constraint(equalToConstant: view.frame.width / 0.65),
            secondView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            secondView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            secondView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            enterBillTotalLabel.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: 40),
            enterBillTotalLabel.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 20),
            
            billTextField.centerXAnchor.constraint(equalTo: firstView.centerXAnchor),
            billTextField.topAnchor.constraint(equalTo: enterBillTotalLabel.bottomAnchor, constant: 35),
            
            selectTipLabel.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 40),
            selectTipLabel.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 20),
            
            pctButtonsStackView.centerXAnchor.constraint(equalTo: secondView.centerXAnchor),
            pctButtonsStackView.topAnchor.constraint(equalTo: selectTipLabel.bottomAnchor, constant: 20),
            
            zeroPctButton.widthAnchor.constraint(equalToConstant: 90),
            tenPctButton.widthAnchor.constraint(equalToConstant: 90),
            twentyPctButton.widthAnchor.constraint(equalToConstant: 90),
            
            chooseSplitLabel.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 40),
            chooseSplitLabel.topAnchor.constraint(equalTo: pctButtonsStackView.bottomAnchor, constant: 35),
            
            splitNumberLabel.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 130),
            splitNumberLabel.topAnchor.constraint(equalTo: chooseSplitLabel.bottomAnchor, constant: 20),
            splitNumberLabel.centerYAnchor.constraint(equalTo: stepper.centerYAnchor),
            
            stepper.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -100),
            stepper.topAnchor.constraint(equalTo: chooseSplitLabel.bottomAnchor, constant: 30),
            
            calculateButton.centerXAnchor.constraint(equalTo: secondView.centerXAnchor),
            calculateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            calculateButton.widthAnchor.constraint(equalToConstant: 230),
            calculateButton.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
}
