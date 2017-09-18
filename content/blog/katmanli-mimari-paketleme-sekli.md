+++
date = "2017-09-18T19:43:57+03:00"
title = "Katmanlı Mimari'de Paketleme Şekli"

+++

Uygulama geliştirme sürecinde verilmesi gereken önemli kararlardan biri kaynak kodları paketlere bölme şeklidir. Katmanlı mimaride genellikle uygulanan yöntem her katman için bir paket oluşturup, sınıfları bulunduğu katmanın paketine atmaktır. Katmanlı mimari anlaşılması son derece kolay bir mimari yaklaşım olup pek çok problemi çözer. Zaten bu yazı da bir katmanlı mimari eleştirisi değil. Ancak paketleri de bu katmanlı yapıya göre düzenlemek her zaman en iyi çözüm olmayabilir. 

Katmanlı mimaride tipik olarak “_presentation_”, “_application_”, “_domain_”, “_infrastructure_” gibi katmanlar bulunur. Bu yapı pek çok “_enterprise_” uygulama için yaygın olsa da projeden projeye farklılık görülebilir. Örneğin pek çok web uygulamasında “_repository_”, “_service_”, “_controller_” gibi katmanlar bulunur. 

Paketleri katmanlara göre oluşturduğumuzda ortaya şuna benzer bir yapı çıkar:

*	com.example.repository
*	com.example.service
*	com.example.controller
*	com.example.model
*	com.example.dto
*	com.exampe.util

Böyle bir paketleme son derece basit ve anlaşılabilir olsa da bazı problemler ortaya çıkarır. En başta paketler arasında ortaya çıkan aşırı bağımlılık problemi gelir. Paketler belli problemleri çözmeye odaklanmadıklarından problemin çözülebilmesi için başka paketlerle etkileşime girmelidir. 

Ortaya çıkan bir diğer sorun uygulamadaki paket sayısının uygulama büyüdükçe büyümemesidir. Uygulama yüzlerce farklı özellik içerse de uygulamadaki paket sayısı hemen hemen sabit kalır ve paketlerin içi yüzlerce sınıf ile dolar.

Paketleri katmanlara göre oluşturmanın alternatifi paketleri oluştururken özellikleri göz önünde bulundurmaktır. Bu yöntemde uygulamanın belirli bir özelliğine odaklanan her sınıf aynı paket içinde toplanır. 

Örneğin bu yapıyı kullanan **pet-clinic** uygulamasındaki paket yapısı şu şekildedir:

*	org.springframework.samples.petclinic.owner
*	org.springframework.samples.petclinic.system
*	org.springframework.samples.petclinic.vet
*	org.springframework.samples.petclinic.visit

Bu mimaride her paket kendi içinde bir bütündür ve diğer paketlere olan bağımlılığı son derece azdır. Aynı zamanda yalnızca paket isimlerine bakarak bile uygulamanın yaptığı iş hakkında kolayca fikir sahibi olunabilir.

Bu paketleme yöntemi ilk bakışta katmanlı yapı ile çelişiyor gibi görünse de aslında katmanlı mimari daha mikro ölçekte, her paket içinde uygulanmaya devam etmektedir.

Örneğin pet-clinic uygulamasındaki "_owner_" paketinin içeriğine bir göz atalım:

*	Owner.java
*	OwnerController.java
*	OwnerRepository.java
*   ...

Görüldüğü gibi, katmanlı yapı aslında her paket içinde yaşamaya devam ediyor.

Açıkçası ben uzun süredir katmanlara göre paketleme yöntemini kullanıyordum. Son zamanlarda geliştirdiğimiz bir uygulamanın büyüklüğü artınca yukarıda bahsi geçen dezavantajları yaşamaya başladım. Biraz araştırma sonrası özelliğe göre paketleme yönteminin zaten uygulanan bir yöntem olduğunu görüp birkaç kişisel projemde bu yöntemi uyguladım. Şu ana dek karşılaştığım tek sıkıntı, uygulama içerisindeki özelliklerin tanımının her zaman kesin olmaması. Yani uygulama şu özelliklerden oluşuyor ve bunlara şu paketler karşılık geliyor demek her zaman kolay değil. Bu problem dışında, bu yöntemi uygulamanın hayatımı kolaylaştırdığını söyleyebilirim. 