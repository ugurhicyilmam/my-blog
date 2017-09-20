+++
date = "2017-09-19T20:52:07+03:00"
title = "Java I/O"
draft = false

+++

Pek çok uygulamada yapılan temel iş aslında veri giriş-çıkışıdır. Bir kaynaktan veri alınır, veriyle bazı işler yapılır ve işlenen veriler çıktı olarak bir yere gönderilir. Network ile çalışan uygulamalarda da durum böyledir, bir kaynaktan veri alınır ve başka bir kaynağa veri gönderilir. Java'nın I/O yapısı sayesinde, bir dosyadan veri okumak ile başka bir sunucudan veri okumak arasında pek fark yoktur. Aynı şekilde bir dosyaya veri yazmak ile başka bir makineye veri göndermek de birbirine oldukça benzer. Bu benzerliği sağlayan yapı "**stream**" yapısıdır.

_Stream_ ilk duyulduğunda karmaşık bir terim gibi gelse de aslında veri transfer eden Java sınıflarıdır. Veri almak için kullanılan stream sınıflarına _input stream_, veri çıkışı için kullanılan stream sınıflarına ise _output stream_ denir. Farklı veri kaynakları için farklı stream sınıfları vardır. Örneğin dosyadan veri okumak için "_FileInputStream_" kullanılırken, Telnet'e veri yazmak için "TelnetOutputStream" kullanılır. Ancak işin güzel yanı, tüm input stream sınıfları veri okumak için aynı temel metotları kullanırken, tüm output strem sınıfları da veri yazmak için aynı metotları kullanır.

Farklı stream sınıfları arasındaki fark aslında bunların oluşturuluş şeklidir, hepsi aynı hiyerarşinin parçası olduğu için kullanılış açısından hiçbir fark yoktur. Dolayısıyla stream sınıfı oluşturduktan sonra, hangi stream sınıfının kullanıldığını tamamen görmezden gelebilirsiniz. 

Normal stream sınıflarına ek olarak, filtre amaçlı kullanılan stream sınıfları da vardır. Bunlar bir stream sınıfından akan veriyi bir şekilde değiştirir. Örneğin bir dosyaya yazılacak veya ağ üzerinden gönderilecek veriyi "gzip" formatında sıkıştırmak için **GZIPInputStream** kullanılır.

**Input Stream**

Java'da input stream sınıfları hiyerarşisinin tepesinde **java.io.InputStream** bulunur. Bu sınıf "abstract" olduğu için objesi oluşturulamaz ancak tüm input stream sınıfları için temel birkaç metot sağlar:

* public int available()
* public void close()
* public abstract int read()
* public int read(byte[] input)
* public int read(byte[] input, int offset, int length)
* public long skip(long n)

Bu sınıftan türeyen bütün sınıflar bu temel metotları kullanır. Farklı kaynak türleri için input stream sınıfları vardır. Örneğin bir dosyadan veri okumak için FileInputStream, bir TCP bağlantısından veri almak için java.net.SocketInputStream kullanılır.

java.io.InputStream sınıfının en temel metodu read() metodudur. Hiçbir argüman almayan bu metot bir bayta karşılık gelen 0-255 arasında bir sayı (int) döner. Verinin sonuna ulaştığını ise -1 değerini dönerek belirtir. 

Örneğin aşağıdaki kod parçası bir dosyadan veriyi baytlar halinde okuyup, bu baytların binary karşılığını ekrana yazdırır:

{{< highlight java >}}
InputStream inputStream = new FileInputStream("hello.txt");
int byteValue;
while ((byteValue = inputStream.read()) > 0) {
    System.out.println(Integer.toBinaryString(byteValue));
}
{{< /highlight >}}

Yukarıdaki örnekte bir döngü içinde teker teker baytları okuduk. Bunun yerine, InputStream'den tüm baytları bir dizi içerisinde de isteyebiliriz:

{{< highlight java >}}
InputStream inputStream = new FileInputStream("hello.txt");
byte[] byteValues = new byte[5]
int numberOfBytes = inputStream.read(byteValues)
{{< /highlight >}}

Bu örnekte, dosyayı oluşturan tüm baytları bir dizi içerisine attık. read() metodundan cevap olarak ise okuduğu baytların sayısını aldık. 

Eğer dosyada 5 bayttan daha fazla değer varsa, InputStream yazabildiği kadarını yazar. Benzer şekilde, eğer dosyada 5 bayttan daha az değer varsa, yalnızca olan değerleri yazar. 

Son read() metodunda diziye yazılacak bayt sayısını ve bu baytların dizinin neresinden itibaren yazılacağını ayarlayabiliriz.

{{< highlight java >}}
InputStream inputStream = new FileInputStream("hello.txt");
byte[] byteValues = new byte[8]
int numberOfBytes = inputStream.read(byteValues, 3, 5)
{{< /highlight >}}

Örneğin yukarıdaki örnekte dizinin ilk üç değeri boş (0) ve ardından gelen 5 değer dosyadan okunan bayt değerleri olacaktır.

