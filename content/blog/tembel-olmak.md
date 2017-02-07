+++
date = "2017-02-07T17:23:17+03:00"
title = "tembel olmak"
draft = true

+++

Tembellik, toplum genelinde olumsuz bir özellik olarak değerlendirilir. Genel inanış, çok çalışmanın başarı için kaçınılmaz olduğu yönündedir.  Aile içinde bile, "Ruşen amcanın oğlu Sedat" gibi çalışkan insanlar övülürken, ebeveynlerimiz tembelliğimizden dolayı bizlere çemkirir. 

Sıkça yapılan bir hata, tembellik ile sorumsuzluğu karıştırmak. Tembel olmak hiçbir şey yapmamak anlamına gelmiyor, sadece bir şeyi halletmenin kolay bir yolunu bulup, çok fazla çaba harcamaktan kaçınmak anlamına geliyor.

İş programlamaya geldiğinde, tembellik özellikle avantajlı oluyor. 

**Kod yazmaktan kaçınmak**

Tembel bir insan olarak, gereksiz kod yazmaktan özellikle kaçınmaya çalışıyorum. 

Öncelikle, kod yazmak çok kolay bir iş değil. Birkaç metot içeren basit bir uygulama yazmak bile, azımsanmayacak miktarda bir odaklanma gerektiriyor. Kod yazmak, mümkün mertebe kaçınılması gereken, nahoş bir aktivite. 

Kod yazmaktan kaçınmak için, öncelikle sorunu iyi değerlendirmek gerekiyor. Müşteriden bir istek geldiğinde ya da siz bir eksiklik farkedip, ekleme yapmanız gerektiğini düşündüğünüzde, önce bir soluklanmanız ve sorunu çözmek için kod yazmak zorunda mısınız diye düşünmeniz gerekiyor. Pek çok defa, müşteri tarafından çok ciddi sorun olduğu düşünülen konuları, biraz düşünme ve tartışmayla hiç kod yazmadan çözdüğüm olmuştur.

Bir diğer yöntem ise, kodu güzel modüllere ayırmak ve gelecekte oluşturduğunuz modülleri, etkili bir şekilde kullanmak. Bu nedenle kodunuzu güzel bir şekilde modüllere ayırmalı, yazılmış kodları mümkün olduğunca yeniden kullanmaya odaklanmalısınız.

**Döküman hazırlamak**

Kod yazıldıktan sonra birkaç ay içinde, o kodun ne yaptığını hatırlayan kimse kalmıyor. Bu süre uzadıkça, o kodu yazan kişinin kimliği bile anonimleşiyor.

Derken, bu tuhaf, anonimleşmiş, artık kimsenin hatırlamadığı kod parçaları hakkında, bir değişiklik isteği, hata ve hatta bir soru geliyor. Bu problemin muhattabı olan zat-ı şahaneleri ise ne yazık ki tarafınız. 

Böyle bir durumla karşılaştığınızda harcayacağınız eforu bir düşünün. Kod okumak, kod yazmaktan bile zor bir iş ve tembel bir yazılımcı bunu minimize etmek zorunda. 

Bunu ne yazık ki birkaç acı tecrübeyle öğrendim ve uzun zamandır yazdığım her "public" fonksiyon için, kesinlikle döküman yazmaktayım. Hatta, çoğu zaman fonksiyonu yazmadan önce dökümanını hazırlıyorum ki daha sonra sorumsuzluk edemeyeyim. 

**Ona minik testler yazın**

Yeni bir proje veya özellik üzerinde çalışıyorsunuz. Ve bam! Sizin geliştirdiğiniz bir özellik düzgün çalışmıyor. Elbette geliştirdikten sonra her şey düzgün çalışıyor mu diye test etmiştiniz ve sorun olmadığını görüp, kodunuzu göndermiştiniz. Ancak, projenin "dıdısının dıdısında", sizin geliştirdiğiniz kısımla tamamen alakasız olan bilinmeyen bir köşede yapılmış ufak bir değişiklik, sizin kodunuzu patlattı. 

Bu tarz sorunları engellemek için dahiyane bir çözüm var: Test otomasyonu. Eğer yazdığınız özellikleri %100 kapsayan testleriniz varsa yapılan değişiklikler nedeniyle bozulan özellikler anında tespit edilebilecek, çözülebilecek ve sizin başınızı ağrıtmayacak.

Kod içerisinde hata bulmak ve düzeltmek, özellike zaman geçtikçe daha da zorlaşır. Hatanın yapıldığı andan çözümüne kadar geçen zaman, hatanın doğru bir şekilde çözülememesi ihtimalini arttırır. Bu nedenle kod ilk yazıldığı anda mümkün olduğunca farklı açıdan test edilmeli ve hata yapma olasılığı en aza indirilmelidir. Bu sizi gelecekte çok daha fazla efordan kurtaracaktır.


Bu tavsiyeler, fi tarihinde okuduğum bir _Quora_ cevabına dayanıyor ancak fi tarihinde olduğundan dolayı kaynak gösteremeyeceğim. Arada bir "sorumsuzluk" edip uygulamasam da, genellikle uyguluyorum ve beni ciddi baş ağrılarından kurtardığını söyleyebilirim. 