+++
date = "2017-12-28T17:19:40+03:00"
title = "Spring Boot REST API Hata Yönetimi"
draft = true
+++

TL;DR Kaynak kodlar: **[github/spring-error-handling](https://github.com/ugurhicyilmam/spring-error-handling)**

Bir REST API tasarımında, API kullanıcılarının kolayca anlayabileceği bir hata standardı belirlemek oldukça önemli... Ne yazık ki, Spring Boot'un hata işlerken sergilediği varsayılan davranış çoğu durumda pek de yardımcı olmuyor. 

Örneğin, uygulamanın çalışması esnasında fırlayan bir hata, aşağıdaki gibi bir cevap dönmesine sebep oluyor:

{{< highlight java >}}
{
    "timestamp": 1514472019629,
    "status": 500,
    "error": "Internal Server Error",
    "exception": "com.ugurhicyilmam.asset.AssetNotFoundException",
    "message": "No message available",
    "path": "/rest/assets/1"
}
{{< /highlight >}}

Bu örnekte, belli ki uygulama bir AssetNotFoundException hatası fırlatmış. Bu cevap hiç yoktan iyi ve neyin yanlış gittiği konusunda bir fikir veriyor. Ancak bundan daha iyisini yapmak mümkün.

Benim bir REST API tasarımına başlarken yaptığım ilk işlerden biri, API tarafından dönülecek cevaplara bir standart getirmektir. Bunun için, cevap yapısını temsil eden, aşağıdaki gibi bir sınıf tanımlarım:

{{< highlight java >}}
@Data
public class Response<T> {
    private String code;
    private T data;

    public Response(T data, String code) {
        this.data = data;
        this.code = code;
    }
}
{{< /highlight >}}

Bu sınıfı biraz daha geliştireceğiz, ancak şimdilik işimizi görecek tüm alanlara sahip; dönen cevabın tipini ve verileri ekleyebileceğimiz iki alan.

Bu sınıfla beraber, dönmek istediğimiz cevaplara şöyle bir standart getirmek istiyoruz: 

{{< highlight java >}}
{
    "code": "E01",
    "data": {...} || null
}
{{< /highlight >}}

Başarılı mesajlar ise şu şekilde bir yapıya sahip olabilir: 

{{< highlight java >}}
{
    "code": "S00",
    "data": {...} || null
}
{{< /highlight >}}

Bu yapıyı kullandığımızda, tek yapmamız gereken şey sistemde oluşması mümkün olan her türlü hata için bir kod belirlemek ve bunları bir dökümanda tutmak.

Şimdi _AssetNotFoundException_ için kendi belirlediğimiz bir hata kodunu dönelim. Bunun için **_@ControllerAdvice_** ve **_@ExceptionHandler_** yapılarını kullanacağız.

{{< highlight java >}}
@ControllerAdvice
@ResponseBody
@ResponseStatus(HttpStatus.BAD_REQUEST)
class AssetControllerAdvice {

    @ExceptionHandler(AssetNotFoundException.class)
    Response handleAssetNotFound(AssetNotFoundException e) {
        return new Response<>(null, "E01");
    }
}
{{< /highlight >}}

Yukarıdaki sınıfın tanımlanmasından sonra cevabımız hata cevabımız şuna dönüşecektir:

{{< highlight java >}}
{
    "code": "E01",
    "data": null
}
{{< /highlight >}}

Şimdi yukarıda kullandığımız yapıları sırasıyla açıklayalım:

* _@ControllerAdvice_ ile sınıfımızdan bir "bean" oluşturduk. 
* _@ResponseBody_ ile, sınıf içerisindeki metotlardan dönen cevabın JSON olmasını sağladık
* _@ResponseStatus_ ile tüm cevapların HTTP kodunu 400 olarak ayarladık.
* _@ExceptionHandler_ ile AssetNotFoundException'ı yakalayacak ve istediğimiz cevabı dönecek bir metot tanımladık.

Response yapısını biraz daha geliştirebilmek için, Response sınıfının içine bazı yardımcı metotlar ekleyebiliriz. Ayrıca, hata kodlarımızı bir enum içinde tutabiliriz. Response yapısının son hali için projenin GitHub sayfasına bakabilirsiniz.

**Detaylar**

