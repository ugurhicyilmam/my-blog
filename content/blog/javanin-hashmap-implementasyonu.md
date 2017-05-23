+++
date = "2017-05-22T11:48:39+03:00"
title = "Java'nın HashMap İmplementasyonu"

+++

**HashMap**, Java içerisindeki önemli konulardan biri ve bu nedenle teknik görüşmelerde karşılaşmanız yüksek ihtimal. Bu yazıda kısaca HashMap mantığıyla giriş yaptıktan sonra Java'daki implementasyonunu açıklayacağım.

İlk olarak biraz analoji kullanarak ve teknik detaylara girmeden konuyu ele alalım. HashMap, pek çok bölmeye sahip ve her bölmeye belli tip eşyaların girebileceği bir dolaba benzetilebilir. Örneğin bir ayakkabı bölmesine, bir kıyafet bölmesine, bir de kitap bölmesine sahip bir dolap... Dolaba bir ayakkabı koyacağınız zaman ayakkabı bölmesine koymak zorundasınız. Ayakkabıyı alacağınız zaman da ayakkabı bölmesinden almalısınız. Böylece ayakkabıyı yerleştirmek de kolaylaşıyor, bulmak da...

Ayakkabı bölmesinde birden fazla ayakkabı koymak zorunda olduğunuzda ne oluyor? 

Bu sorunu çözmek için en basit yöntem  ayakkabıları üst üste, aynı bölme içine yığmak. Herhangi bir ayakkabıyı almak istediğinizde de, yığıntının içinden istediğiniz ayakkabıyı arayarak bulmak. Java'nın HashMap implementasyonunda da benzer bir yaklaşım var.

Yazının bu noktadan sonrası biraz daha teknik olarak devam edecek.

Java'nın HashMap implementasyonu aslında bir dizi **Linked List**'ten (bağlı liste) oluşuyor. _Linked List_ içerisindeki düğümler HashMap'e eklenen _key-value_ (anahtar-değer) ikililerini ve diğer düğümlere olan bağlantıları tutuyor. 

_Linked List_ içerisindeki her düğüm _Entry_ sınıfının objelerinden oluşuyor:

{{< highlight java >}}
private static class Entry<K,V> implements Map.Entry<K,V> {
     final K key;
     final int hash;
     V value;
     Entry<K,V> next;
}
{{< /highlight >}}

Her _Entry_ objesinin içinde key-value ikilileri var. Görüldüğü gibi key değişkeni _final_ olarak tanımlanmış. Bu eklenen bir kaydın _key_ değerinin değiştirilemeyeceği anlamına geliyor. Öte yandan _value_ değeri değiştirilebiliyor.

Her Entry objesi ayrıca next adında, bir sonraki Entry objesine işaret eden bir alana sahip. Bu sayede Entry objeleri aynı zamanda bir Linked List gibi davranıyor.

Son olarak, "hash" alanı, key alanının hash değerini tutuyor. Bu değer, Entry objesinin dizi içerisindeki yerini tespit etmede kullanılılyor. Birden fazla _Entry_ aynı _key_ değerine sahip olduğunda _next_ alanıyla birbirlerine bağlanarak bir _Linked List_ meydana getiriyor.

HashMap sınıfının içine göz atınca aşağıdaki değerleri görüyoruz:

{{< highlight java >}}
static final int DEFAULT_INITIAL_CAPACITY = 16;
static final float DEFAULT_LOAD_FACTOR = 0.75F;
transient int modCount;
static final int TREEIFY_THRESHOLD = 8;
{{< /highlight >}}

HashMap oluştururken **default constructor** kullanıldığında, bu değerler kullanılıyor. Bu değerlere göre yeni bir HashMap oluşturduğunuzda, dizinin boyutu 16 olarak belirleniyor. HashMap içindeki toplam eleman sayısının dizi boyutuna oranı 0.75'i geçtiğinde ise eski dizinin iki katı boyutunda yeni bir dizi oluşturuluyor.

##### Java 8 Değişiklikleri

HashMap, _key_ ararken O(1) performansı sağlasa da HashMap içindeki pek çok _key_ alanının _hash_ değeri aynıysa bu performans düşmeye başlar, çünkü bu durumda _key_ değerleri Linked List'ler içinde aranmaya başlanır. Linked List'in arama performansı da O(n) olduğundan, O(1) değerimiz O(n)'e doğru yakınlaşmaya başlar.

Bu sorunu çözebilmek için, belli bir _threshold_ değeri aşıldıktan sonra Linked List yerine _Binary Tree_ kullanılır ve bu sayede en kötü performans O(n)'den O(logn)'e düşürülür. Tabii bunun için _key_ değerlerinin karşılaştırılabilir olması gerekir. Aksi durumda korkunç O(n) performansına geri döneriz.


##### ConcurrentModificationException

_ConcurrentModificationException_ multi-threaded bir uygulamada karşılaşabileceğiniz bir hata... Threadlerden birinde HashMap üzerinde iterasyon devam ederken, bir başka thread içinde HashMap üzerinde değişiklik yapıldığında ortaya çıkar.

HashMap içinde modCount adında bir alan HashMap üzerinde yapılan tüm değişikliklerin sayısını tutar. Benzer bir şekilde, HashMap'in "iterator" objesinde de iteratorModCount adında bir alan iterator ilk oluşturulduğundaki modCount değerini tutar. Her iterasyonda iteratorModCount ve modCount değerleri karşılaştırılır ve değerler farklı olduğunda ConcurrentModificationException fırlatılır.

#### HashSet

Java'nın HashSet implementasyonu aslında HashMap implementasyonunun biraz özelleştirilmiş hali olduğundan bu yazı da onu da açıklamak yerinde olacak.

HashSet aslında eklenen değerleri tutmak için HashMap kullanır:

{{< highlight java >}}
private static final Object PRESENT = new Object();
private transient HashMap<E,Object> map;

public boolean add(E e) {
  return map.put(e, PRESENT)==null;
}
{{< /highlight >}}

Eklenen değerler bir HashMap'e _key_ olarak eklenir. _Value_ olarak ise PRESENT alanında tutulan, boş bir obje eklenir. Bu obje HashSet içerisinde hiç kullanılmaz ve _static_ bir alanda tutulur, yani uygulama içerisindeki tüm HashSet'lerde bu değer aynıdır.


#### Kaynakça

Ayrıntılı bilgi için aşağıdaki kaynaklara bakabilirsiniz:

http://www.javamadesoeasy.com/2015/02/hashmap-custom-implementation.html
https://dzone.com/articles/hashmap-performance
http://hg.openjdk.java.net/jdk8/jdk8/jdk/file/687fd7c7986d/src/share/classes/java/util/HashMap.java
http://hg.openjdk.java.net/jdk8/jdk8/jdk/file/687fd7c7986d/src/share/classes/java/util/HashSet.java