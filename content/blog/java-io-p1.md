+++
date = "2017-09-21T20:52:07+03:00"
title = "Java I/O - Part 1"
draft = false

+++

Pek çok uygulamada yapılan temel iş aslında veri giriş-çıkışıdır. Bir kaynaktan veri alınır, veriyle bazı işler yapılır ve işlenen veriler çıktı olarak bir yere gönderilir. Network ile çalışan uygulamalarda da durum böyledir: Bir kaynaktan veri alınır ve başka bir kaynağa veri gönderilir. Java'nın gelişmiş I/O yapısı sayesinde, bir dosyadan veri okumak ile başka bir sunucudan veri okumak arasında pek fark yoktur. Aynı şekilde bir dosyaya veri yazmak ile başka bir makineye veri göndermek de birbirine oldukça benzer. Bu benzerliği sağlayan yapı "**stream**" yapısıdır.

_Stream_ ilk duyulduğunda karmaşık bir terim gibi gelse de aslında veri transfer eden Java sınıflarıdır. Veri almak için kullanılan stream sınıflarına _input stream_, veri çıkışı için kullanılan stream sınıflarına ise _output stream_ denir. Farklı veri kaynakları için farklı stream sınıfları vardır. Örneğin dosyadan veri okumak için "_FileInputStream_" kullanılırken, Telnet'e veri yazmak için "TelnetOutputStream" kullanılır. Ancak işin güzel yanı, tüm input stream sınıfları veri okumak için aynı temel metotları kullanırken, tüm output strem sınıfları da veri yazmak için aynı metotları kullanır.

Farklı stream sınıfları arasındaki temel fark aslında bunların oluşturuluş şeklidir, hepsi aynı hiyerarşinin parçası olduğu için kullanılış açısından hiçbir fark yoktur. Dolayısıyla stream sınıfı oluşturulduktan sonra, hangi stream sınıfının kullanıldığı tamamen görmezden gelinebilir. 

Temel anlamda iki farklı stream var demiştik: input ve output stream. Bunları teker teker ele alalım.

**Input Stream**

Java'da input stream sınıfları hiyerarşisinin tepesinde **java.io.InputStream** bulunur. Bu sınıf "abstract" olduğu için objesi oluşturulamaz ancak tüm input stream sınıfları için temel birkaç metot sağlar:

* public int available()
* public void close()
* public abstract int read()
* public int read(byte[] input)
* public int read(byte[] input, int offset, int length)
* public long skip(long n)

Farklı veri kaynakları veya hedefleri için farklı stream sınıfları olsa da, hepsi aynı InputStream sınıfından türer. Dolayısıyla, bu sınıftan türeyen bütün sınıflar bu temel metotları kullanır. Örneğin bir dosyadan veri okumak için FileInputStream, bir TCP bağlantısından veri almak için java.net.SocketInputStream kullanılır, ancak bu sınıfların kullanılış şekli tamamen aynıdır.

java.io.InputStream sınıfının en temel metodu read() metodudur. Hiçbir argüman almayan bu metot bir bayta karşılık gelen 0-255 arasında bir sayı (int) döner. Yani, her çağrılışında veri kaynağından bir bayt okur ve döner. Verinin sonuna ulaştığını ise -1 değerini dönerek belirtir. 

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

Bu örnekte, dosyayı oluşturan tüm baytları bir dizinin içine attık. read() metodundan cevap olarak ise okuduğu baytların sayısını aldık. 

Eğer dosyada 5 bayttan daha fazla değer varsa, InputStream yazabildiği kadarını yazar. Benzer şekilde, eğer dosyada 5 bayttan daha az değer varsa, yalnızca olan değerleri yazar. 

Son read() metodunda diziye yazılacak bayt sayısını ve bu baytların dizinin neresinden itibaren yazılacağını ayarlayabiliriz.

{{< highlight java >}}
InputStream inputStream = new FileInputStream("hello.txt");
byte[] byteValues = new byte[8]
int numberOfBytes = inputStream.read(byteValues, 3, 5)
{{< /highlight >}}

Örneğin yukarıdaki örnekte dizinin ilk üç değeri boş (0) ve ardından gelen 5 değer dosyadan okunan bayt değerleri olacaktır. Metot cevap olarak ise yazılan baytların sayısını döner. Bu metot hata kontrolü için güzel bir mekanizma sağladığı için oldukça faydalıdır: Önce kaynaktan gelen baytları bir dizi içine okumayı denersin, sonra başarılı şekilde okuyabildiğin baytların sayısını okuman gerekenle karşılaştırırsın. Eğer arada bir fark varsa başarılı bir okuyabildiğin bayt sayısı kadar _offset_ verip, tekrar yazmayı denersin. read() metodu bu durumda yazmaya kaldığı yerden devam eder.

Nadiren de olsa, okunacak bazı baytların atlanması gerektiği durumlarda **skip()** metodu kullanılabilir. 

Son olarak InputStream ile yapılan iş bittiğinde mutlaka **close()** metodu çağrılarak InputStream için ayrılmış kaynakların (açık dosyalar, dinlenen portlar gibi) serbest bırakılması gerekir.

**Output Stream**

Output stream ailesinin tepesinde java.io.OutputStream bulunur. Aynı kuzeni InputStream gibi OutputStream de _abstract_ bir sınıftır ve tüm output stream sınıflarında var olan bazı temel metotlarla gelir.

java.io.OutputStream sınıfının yapısı şu şekildedir: 

* public abstract void write(int b)
* public void write(byte[] data)
* public void write(byte[] data, int offset, int length)
* public void flush()
* public void close()

InputStream ile OutputStream mantık olarak birbirine benzediğinden, birini anladıktan sonra diğerini almak oldukça kolay gelecektir; bu nedenle OutputStream'de tekrar her metodun detaylı olarak açıklanmasına gerek yok. Kısaca özet geçmek gerekirse, temel **write()** metodu 0-255 arasındaki bayt değerlerini bir hedefe yazmaya yarar. Her baytı teker teker yazmak için metot çağırmak yavaş bir çözüm olduğundan write() metodunun "byte" dizisi alan versiyonu da vardır. Bu da dizideki tüm değerleri hedefe yazar. Son versiyon ise diziyi belirli bir "offset" değeri kadar atlar ve verilen "limit" değeri kadar baytı hedefe yazar. 

Output stream ile yazılacak veri bittiğinde close() metodu çağrılmalıdır. Aksi halde, stream için tutulan kaynaklar serbest bırakılmamış olur. Örneğin, SocketOutputStream kapatılmazsa TCP bağlantısı aktif kalmaya devam eder. close() metodu çağrıldıktan sonra ise bağlantı sona erer ve bu noktadan sonra stream objesine veri yazmak _IOException_ fırlatır.

Genelde input stream sınıflarının birer output stream karşılığı bulunur. Örneğin FileInputStream'ın karşılığı FileOutputStream'dir. Benzer şekilde SocketInputStream'in bir de SocketOutputStream karşılığı vardır.

**try-with-resources**

Java 7 ile birlikte stream kapatma işine biraz syntax güzelliği eklemek amacıyla **try-with-resources** yapısı eklenmiştir:

{{< highlight java >}}
try (InputStream inputStream = new FileInputStream("hello.txt")) {
    byte[] bytes = new byte[8];
    inputStream.read(bytes, 3, 5);
    for (byte aByte : bytes) {
        System.out.println(Integer.toBinaryString(aByte));
    }
}
{{< /highlight >}}

Yukarıdaki **try** bloğu içindeki kod çalıştıktan sonra inputStream'in **close()** metodu çağrılır. Bu yapı tüm input ve output streamleri için kullanılabilir.

**Kapanış**

Bu yazıda ele alınan java.io.InputStream ve java.io.OutputStream sınıfları yalnızca bayt transferine odaklanır. Genelde ise aktardığımız baytlara farklı şekillerde davranmak isteriz: örneğin string veya obje gibi. Ayrıca performans, güvenlik ve güvenilirlik gibi nedenlerle bu baytları biraz değiştirmemiz gerekir: veriyi sıkıştırmak veya şifrelemek gibi. Bu gibi işlemler için, başka bir yazıda ele alacağım "**filtre stream**" sınıfları vardır ve uygulamalarımızda genellikle bu tür streamler ile muhatap oluruz. Ancak yine de I/O işleminin temelini kavramak açısından InputStream ve OutputStream yapılarını öğrenmek önemlidir. 