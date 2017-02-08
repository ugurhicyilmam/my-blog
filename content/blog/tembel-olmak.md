+++
date = "2017-02-07T17:23:17+03:00"
title = "tembel olmak"
+++

Tembellik, toplum genelinde olumsuz bir özellik olarak değerlendirilir. Genel inanış, çok çalışmanın başarı için kaçınılmaz olduğu yönündedir.  Aile içinde bile, "Ruşen amcanın oğlu Sedat" gibi çalışkan insanlar övülürken, ebeveynlerimiz tembelliğimizden dolayı bizlere çemkirir. 

Sıkça yapılan bir hata, tembellik ile sorumsuzluğu karıştırmak... Aslında, tembel olmak hiçbir şey yapmamak anlamına gelmiyor, sadece bir işi halletmenin daha kolay bir yolunu bulup, çok fazla çaba harcamaktan kaçınmak anlamına geliyor.

İş programlamaya geldiğinde, tembellik özellikle avantajlı oluyor. 

**Kod yazmaktan kaçınmak**

Tembel bir insan olarak, gereksiz kod yazmaktan özellikle kaçınmaya çalışıyorum. 

Öncelikle, kod yazmak çok kolay bir iş değil. Birkaç metot içeren basit bir uygulama yazmak bile, azımsanmayacak miktarda bir odaklanma gerektiriyor. Özellikle proje büyüdükçe, eklenen her satır kodun uygulamayı bozma ihtimali var. Kod yazmak, mümkün mertebe kaçınılması gereken, nahoş bir aktivite. 

Kod yazmaktan kaçınmak için, öncelikle sorunu iyi değerlendirmek gerekiyor. Müşteriden bir istek geldiğinde ya da siz bir eksiklik fark edip, ekleme yapmanız gerektiğini düşündüğünüzde önce bir soluklanmanız ve sorunu çözmek için kod yazmak zorunda mısınız diye düşünmeniz gerekiyor. Pek çok defa, müşteri tarafından çok ciddi sorun olduğu düşünülen konuları, biraz düşünme ve ikna yöntemiyle hiç kod yazmadan çözdüğüm olmuştur.

Bir diğer yöntem ise, kodu güzel modüllere ayırmak ve gelecekte oluşturduğunuz modülleri, etkili bir şekilde kullanmak. Bu nedenle kodunuzu güzel bir şekilde modüllere ayırmalı, yazılmış kodları mümkün olduğunca yeniden kullanmaya odaklanmalısınız.

**Doküman: sıkıcı ama gerekli**

Kod yazıldıktan sonra birkaç ay içinde, o kodun ne yaptığını hatırlayan kimse kalmıyor. Bu süre uzadıkça, o kodu yazan kişinin kimliği bile anonimleşiyor. Bir gün bu tuhaf, anonimleşmiş, artık kimsenin hatırlamadığı kod parçaları hakkında, bir değişiklik isteği, hata ya da bir soru geliyor. Bu problemin muhatabı olan zat-ı şahanelerinin ise, dokümansız yabana gönderdiği bu kod parçasından dolayı başı belaya giriyor. 

Böyle bir durumla karşılaştığınızda harcayacağınız çabayı bir düşünün. Kod okumak, kod yazmaktan bile zor bir iş ve tembel bir yazılımcı bunu minimize etmek zorunda. 

Bunu ne yazık ki birkaç acı tecrübeyle öğrendim ve uzun zamandır yazdığım her "public" fonksiyon için, kesinlikle doküman yazmaktayım. Hatta çoğu zaman fonksiyonu yazmadan önce dokümanını hazırlıyorum ki daha sonra şeytana uyup, doküman yazmamazlık etmeyeyim. 

**Ona minik testler yazın**

Yeni bir proje veya özellik üzerinde çalışıyorsunuz. Ve bam! Sizin geliştirdiğiniz bir özellik düzgün çalışmıyor. Elbette geliştirdikten sonra her şey düzgün çalışıyor mu diye test etmiştiniz ve sorun olmadığını görüp, kodunuzu göndermiştiniz. Ancak, projenin "dıdısının dıdısında", sizin geliştirdiğiniz kısımla tamamen alakasız olan bilinmeyen bir köşede yapılmış ufak bir değişiklik, sizin kodunuzu patlattı. 

Bu tarz sorunları engellemek için dâhiyane bir çözüm var: Test otomasyonu. Eğer yazdığınız özellikleri %100 kapsayan testleriniz varsa yapılan değişiklikler nedeniyle bozulan özellikler anında tespit edilebilecek, çözülebilecek ve sizin başınızı ağrıtmayacak.

Kod içerisinde hata bulmak ve düzeltmek, özellikle zaman geçtikçe daha da zorlaşır. Hatanın yapıldığı andan çözümüne kadar geçen zaman, hatanın doğru bir şekilde çözülememesi ihtimalini arttırır. Bu nedenle kod ilk yazıldığı anda mümkün olduğunca farklı açıdan test edilmeli ve hata yapma olasılığı en aza indirilmelidir. Bu sizi gelecekte çok daha fazla çabadan kurtaracaktır.


Bu tavsiyeler, fi tarihinde okuduğum bir _Quora_ cevabından esinlenildi ancak fi tarihinde olduğundan dolayı kaynak gösteremeyeceğim. Arada bir "sorumsuzluk" edip uygulamasam da, genellikle uyguluyorum ve beni ciddi baş ağrılarından kurtardığını söyleyebilirim.

Bu yazıyı daha önce de bloğumda yayınlamıştım. Bir gözden geçirip, yeni bloğumda tekrar yayınlıyorum.

