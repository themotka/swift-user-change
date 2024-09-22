import UIKit

protocol MainDelegate: AnyObject {
    func didUpdateUser(_ user: User)
}

class MainViewController: UIViewController {
    
    var user: User?
    weak var delegate: MainDelegate?
    
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(saveButton)
        
        setupConstraints()
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)

        if let user = user {
            firstNameTextField.text = user.firstName
            lastNameTextField.text = user.lastName
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            firstNameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            firstNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 20),
            lastNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lastNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            saveButton.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc private func saveButtonTapped() {
            guard let firstName = firstNameTextField.text, !firstName.isEmpty,
                  let lastName = lastNameTextField.text, !lastName.isEmpty else {
                return
            }
            
            let updatedUser = User(firstName: firstName, lastName: lastName)
            delegate?.didUpdateUser(updatedUser)
            navigationController?.popViewController(animated: true)
        }
}

