//
//  BackgroundProvidingClass.swift
//  iOSDependencyInjection
//
//  Created by Atil Samancioglu on 6.08.2022.
//

import Foundation
import UIKit

class BackgroundProvidingClass : BackgroundProviderProtocol { // arkaplan rengi sağlayan
    var backgroundColor: UIColor { // protokoldeki değişkeni burada artık scopelamak gerekiyor
    let backgroundColors : [UIColor] = [.systemGray,.systemRed,.systemMint,.systemCyan] // backgroundColors değişkeni bu renklerden birini her seferinde random olarak vericek
        return backgroundColors.randomElement()! // bunlardan herhangi bi rengin dönüceğine eminiz o yuzden ! koyuyoruz
    }
 }
