//
//  ViewController.swift
//  iOSDependencyInjection
//
//  Created by Atil Samancioglu on 6.08.2022.
//

import UIKit
import Swinject
// dependency injection aslında kullanılan bir yöntem. hem ios ta hem androidde karşımıza çıkar. androidde çok daha fazla kullanılır. iosta çok populer değil ama endüstride ve mülakatlarda karşımıza çıkabilir. dependency injection ı kullanabilmek için Swinject bu kütüphaneyi kullanıcaz
// dependency demek projemizin çalışabilmesi için bağımlı olduğu yapılar demek. indirdiğimiz podlar, framework ler de birer dependency aslında çünkü projemizin çalışabilmesi için bunlara ihtiyaç duyuyoruz. ama şuan işleyeceğimiz konu kütüphaneler falan değil kendi kodumuzdaki dependency injection
// dependency kod yazarken bizim karşımıza çıkabilecek, kodumuzun çalışması için gerekli olan diğer objeleri/protocolleri/instanceları/yapıları kolay bi şekilde sağlamamıza olanak sağlayan bir yapıdır
// ikinci viewcontrollera atamayı yapmadan önce protokolumuzu bu viewcontrollerda çözümleyip oraya enjekte edicez
class ViewController: UIViewController {
    
    // bu kısım Swinject kodları
    let container : Container = { // Container da bazı şeyler kayıt ederiz. burada kaydettiğimiz yapılar örneğin sınıf ya da viewcontroller, bunları kaydettiğimizde Swinject i kullanarak başka yerlerde çözümleme yapabiliyoruz. kısacası burada Swinject e diyoruz ki bu sınıftan/protokolden/viewcontrollerdan bi şey oluşturacağında böyle yapabilirsin. bunu deyince diğer yerlerde bu dependency leri bağımlı kalmadan oluşturmak çok kolay olucak
        let container = Container()
        container.register(BackgroundProvidingClass.self) { resolver in // BackgroundProvidingClass ın kendisini register edicez. bize resolver yani çözümleyici vericek ama şuan ihtiyaç yok
            return BackgroundProvidingClass() // Container dedik ki BackgroundProvidingClass diye bişi oluşturursan böyle oluştur. burada dependency yoktu
        } // Swinject e dedik ki bi gün biri gelip sana BackgroundProvidingClass tanımlamak isterse üstteki gibi tanımlayabilir. üstüne dedik ki bi gün bi developer gelir AnotherVC ı tanımlamak isterse bu AnotherVC bazı parametreler isteyecek, bunları sen zaten tanımlamayı biliyosun, çözümleyebilirsin(resolve) dedik. bu çözümleme işi optional bişi, oladabilir olmayadabilir, BackgroundProvidingClass() buraya farklı bi parametre eklersek çözümleyemez mesela. o yuzden anothervc da BackgroundProviderProtocol? bunu optional yaptık
        container.register(AnotherVC.self) { resolver in // yukarıda protokol olmasa da o protokolu uygulayan bi sınıf tanımladık.
            let vc = AnotherVC(providerProtocol: resolver.resolve(BackgroundProvidingClass.self))
            return vc
        }
        
        return container
    }()
    // butona basınca başka bi viewcontroller açılırken arka planı deiştirmek istiyoruz. bunun için arka plan renklerini saklayan bir protocol ve bu protocolu uygulayan bir sınıf yazıcaz. bu sınıfın tanımlanmasını sadece bu viewcontroller la yapıcaz. yani ikinci viewcontroller ımıza bu tanımlanmalar enjekte edilecek
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        button.setTitle("Open Another VC", for: .normal)
        button.center = view.center
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside) // butona dokunulduğunda(touchUpInside) buttonClicked bu fonksiyon çağırılacak
        view.addSubview(button)
        
        
    }
    
    @objc private func buttonClicked() {
        if let viewController = container.resolve(AnotherVC.self) { // if let yapmamızın sebebi çözümleyemezse diye. burada AnotherVC oluştururken provider protokol kullanmadık çözümle dedik. ben sana AnotherVC ın nasıl tanımlanıcağını öğrettim
            present(viewController, animated: true) // çözümlediyse viewController ı present edicek
        }
    }
// çözümleme işlerini otomatik yaptık. çözümlendiğinde AnotherVC ın nasıl tanımlanacağı biliniyor. AnotherVC bizden BackgroundProvidingClass istiyor. o sınıfı burada tanımladık. o class ın içindeki değişken bize random bi renk veriyor. anothervc içinde de arka planı bu değişkene göre belirliyoruz
    
    
}




