+++
date = "2017-09-19T20:52:07+03:00"
title = "Java I/O"
draft = true

+++

Pek çok uygulamada yapılan temel iş aslında veri giriş-çıkışıdır. Bir kaynaktan veri alınır, veriyle bazı işler yapılır ve işlenen veriler çıktı olarak bir yere gönderilir. Network ile çalışan uygulamalarda da durum böyledir, bir kaynaktan veri alınır ve başka bir kaynağa veri gönderilir. Java'nın I/O yapısı sayesinde, bir dosyadan veri okumak ile başka bir sunucudan veri okumak arasında pek fark yoktur. Aynı şekilde bir dosyaya veri yazmak ile başka bir makineye veri göndermek de birbirine oldukça benzer. Bu benzerliği sağlayan yapı "**stream**" yapısıdır.

_Stream_ ilk duyulduğunda karmaşık bir terim gibi gelse de aslında veri transfer eden Java sınıflarıdır. Veri almak için kullanılan stream sınıflarına _input stream_, veri çıkışı için kullanılan stream sınıflarına ise _output stream_ denir. Farklı veri kaynakları için farklı stream sınıfları vardır. Örneğin dosyadan veri okumak için "_FileInputStream_" kullanılırken, Telnet'e veri yazmak için "TelnetOutputStream" kullanılır. Ancak işin güzel yanı, tüm input stream sınıfları veri okumak için aynı temel metotları kullanırken, tüm output strem sınıfları da veri yazmak için aynı metotları kullanır.

Farklı stream sınıfları arasındaki fark aslında bunların oluşturuluş şeklidir, hepsi aynı hiyerarşinin parçası olduğu için kullanılış açısından hiçbir fark yoktur. Dolayısıyla stream sınıfı oluşturduktan sonra, hangi stream sınıfının kullanıldığını tamamen görmezden gelebilirsiniz. 

