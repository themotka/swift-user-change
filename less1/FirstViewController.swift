import UIKit

class FirstViewController: UIViewController {

    private var user = User(firstName: "Big", lastName: "Bob")

    private let firstNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lastNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(firstNameLabel)
        view.addSubview(lastNameLabel)
        view.addSubview(button)
        
        setupConstraints()
        updateLabels()
        
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            firstNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            firstNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            lastNameLabel.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 20),
            lastNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func updateLabels() {
        firstNameLabel.text = "First Name: \(user.firstName)"
        lastNameLabel.text = "Last Name: \(user.lastName)"
    }
    
    @objc private func editButtonTapped() {
        let editVC = MainViewController()
        editVC.user = user
        editVC.delegate = self
        navigationController?.pushViewController(editVC, animated: true)
    }
    
    
}

extension FirstViewController: MainDelegate {
    func didUpdateUser(_ user: User) {
            self.user = user
            updateLabels()
        }
}
