//
//  BackgroundProviderProtocol.swift
//  iOSDependencyInjection
//
//  Created by Atil Samancioglu on 6.08.2022.
//

import Foundation
import UIKit
// bunu tabi herhangi bir dizide de saklayabilirdik ama profesyonel hayatta dizide saklanmaz, protokollerle ve bu protokolu uygulayan sınıflarla iş yapıcaz.
protocol BackgroundProviderProtocol{ // arkaplan rengi sağlayıcı
    var backgroundColor : UIColor {get}
}
