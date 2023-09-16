//
//  AnotherVC.swift
//  iOSDependencyInjection
//
//  Created by Atil Samancioglu on 6.08.2022.
//

import UIKit

class AnotherVC: UIViewController{ // UIViewController bu çağırılırken bi tane protokol verilecek dedik. bu protokolden de backgroundColor ı kullanıcaz
    private let providerProtocol : BackgroundProviderProtocol?
   
    init(providerProtocol: BackgroundProviderProtocol?){
        self.providerProtocol = providerProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = providerProtocol?.backgroundColor ?? .white // gelmezse beyaz yap
    }
}
