+++
date = "2017-09-25T23:52:07+03:00"
title = "Java I/O - Part 2"
draft = true

+++

Bu yazının [ilk kısmında](http://www.ugurhicyilmam.com/blog/java-io-p1/) java.io.InputStream ve java.io.OutputStream sınıflarını anlatmıştık. Söz konusu sınıflar I/O yapısını anlamak açısından son derece önemli olsa da, düşük seviyeli sınıflardır: işlenmemiş baytlar ile çalışırlar. Ancak gerçek dünyada genellikle direkt olarak baytlar üzerinde çalışmayız; veriyi işleriz ve veriye anlamlar yükleriz. Örneğin veriyi göndermeden önce sıkıştırmak isteyebiliriz veya bize gönderilen sıkıştırılmış veriyi açmamız gerekebilir. Bize gönderilen baytlar aslında bir yazıyı veya objeyi temsil ediyor olabilir. Bu gibi durumlarda, sadece java.io.InputStream ve java.io.OutputStream sınıflarından türeyen düşük seviyeli sınıflarla işimizi halledemeyiz.

Düşük seviyeli baytların işlenmesini kolaylaştırmak amacıyla **filtre** sınıfları eklenmiştir. Filtre sınıfları iki amaçla kullanılır: bayt manipülasyonu ve baytların yazıya çevrilmesi... Bayt manipülasyonu yapanlara "**filtre stream**", baytı yazı olarak işleyenlere "**reader**" ve "**writer**" denir.

**Filtre Streamleri**

Filtreler, zincir şeklinde uygulanır. Zincirin ilk halkası java.io.InputStream veya java.io.OutputStream'den türeyen ve işlenmemiş bayt dönen sınıflardır. Daha sonraki halkalar ise baytları manipüle eden filtrelerden oluşur. Zincirin her halkası, kendinden önceki halkkadan dönen veriyi alır ve işleyerek bir sonraki halkaya döner. 


... örnek ile devam et ...