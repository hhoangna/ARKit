//
//  ViewController.swift
//  Test
//
//  Created by Admin on 9/27/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tbvContent: UITableView!
    @IBOutlet weak var btnLoad: UIButton!
    @IBOutlet weak var lblPrint: UILabel!
    @IBOutlet weak var tfTest: UITextField!
    @IBOutlet weak var vTest: UIView!
    
    var animals: [Animal]?
    var userdefault: UserDefaults?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userdefault = UserDefaults.standard
        // Do any additional setup after loading the view, typically from a nib.
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .right
        let attributedPlaceholder = NSAttributedString(string: "Placeholder", attributes: [NSAttributedString.Key.paragraphStyle: centeredParagraphStyle, .baselineOffset: 0])
        tfTest.attributedPlaceholder = attributedPlaceholder
        tfTest.textAlignment = .left
    }
    
    func loadFromJSON(filename fileName: String) -> [Animal]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(List.self, from: data)
                return jsonData.animals
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }

    
    @IBAction func loadFromJSON(_ sender: UIButton) {
        animals = loadFromJSON(filename: "animal")
        tbvContent.reloadData()
    }
    
    @IBAction func loadFromNSUserDefault(_ sender: UIButton) {
        if let decode = userdefault?.data(forKey: "AnimalSaved") {
            let animal = try? JSONDecoder().decode(Animal.self, from: decode)
            lblPrint.text = animal!.name + "\t-\t\(animal!.weight)"
        }
    }
//    
//    func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        let newbounds: CGRect = bounds
//        let size: CGSize = placeholder().size(attributes: [NSAttributedString.Key.font: font])
//        let width = Int(bounds.size.width - size.width)
//        newbounds.origin.x = CGFloat(width)
//        newbounds.size.width = size.width
//        return newbounds
//    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tbvContent.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        let animal = animals?[indexPath.row]
        
        cell.lblTitle.text = animal?.name
        cell.lblSubtitle.text = "\(String(describing: animal?.weight))"
        cell.delegate = self
        return cell
    }
}

extension ViewController: CellDelegate {
    func onBtnSave(cell: UITableViewCell, sender: UIButton) {
        let indexPath = tbvContent.indexPath(for: cell)
        guard let animal = animals?[(indexPath?.row)!] else {return}
        if let encode = try? JSONEncoder().encode(animal) {
            userdefault?.set(encode, forKey: "AnimalSaved")
        }
    }
}

