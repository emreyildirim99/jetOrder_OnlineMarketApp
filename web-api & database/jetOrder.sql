-- phpMyAdmin SQL Dump
-- version 4.9.3
-- https://www.phpmyadmin.net/
--
-- Anamakine: localhost:3306
-- Üretim Zamanı: 19 Şub 2021, 19:55:55
-- Sunucu sürümü: 5.7.26
-- PHP Sürümü: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Veritabanı: `jetorder_github`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `favorites`
--

CREATE TABLE `favorites` (
  `favoriteProductID` int(11) NOT NULL,
  `favoriteUserID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `orders`
--

CREATE TABLE `orders` (
  `orderID` int(11) NOT NULL,
  `orderCode` varchar(255) NOT NULL,
  `orderTotalPrice` decimal(10,2) NOT NULL,
  `orderStatus` int(11) NOT NULL DEFAULT '0',
  `orderCustomerID` int(11) NOT NULL,
  `orderProductID` int(11) NOT NULL,
  `orderQuantity` int(11) NOT NULL,
  `orderDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `productRatings`
--

CREATE TABLE `productRatings` (
  `ratingCustomerID` int(11) NOT NULL,
  `ratingProductID` int(11) NOT NULL,
  `ratingCategoryID` int(11) NOT NULL,
  `ratingPoint` decimal(10,1) DEFAULT '0.0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tetikleyiciler `productRatings`
--
DELIMITER $$
CREATE TRIGGER `Insert New Rating` AFTER INSERT ON `productRatings` FOR EACH ROW BEGIN
SELECT AVG(ratingPoint) INTO @averagePoint FROM productRatings WHERE ratingProductID = NEW.ratingProductID LIMIT 1;

UPDATE products SET productPoint = @averagePoint WHERE productID = NEW.ratingProductID;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Update Product Rating` AFTER UPDATE ON `productRatings` FOR EACH ROW BEGIN
SELECT AVG(ratingPoint) INTO @averagePoint FROM productRatings WHERE ratingProductID = NEW.ratingProductID LIMIT 1;

UPDATE products SET productPoint = @averagePoint WHERE productID = NEW.ratingProductID;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `products`
--

CREATE TABLE `products` (
  `productID` int(11) NOT NULL,
  `productName` varchar(255) NOT NULL,
  `productPhoto` varchar(255) NOT NULL,
  `productPrice` decimal(10,2) NOT NULL,
  `productDesc` varchar(255) NOT NULL,
  `productQuantity` varchar(255) NOT NULL,
  `productCategory` int(11) NOT NULL,
  `productPoint` decimal(10,1) NOT NULL DEFAULT '0.0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `products`
--

INSERT INTO `products` (`productID`, `productName`, `productPhoto`, `productPrice`, `productDesc`, `productQuantity`, `productCategory`, `productPoint`) VALUES
(1, 'Elma', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/27131000/elma-amasya-kg-526109.jpg', '10.00', 'Herkes tarafından severek tüketilen Elma Amasya, sahip olduğu hoş kokusuyla da tüketicinin dikkatini üzerine çekmeyi başarıyor.', 'Kilo', 1, '4.0'),
(2, 'Armut', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/27028000/armut-santa-maria-kg-23d06a.jpg', '20.00', 'Kendine özgü bir görünüme ve lezzete sahip olan meyve, diğer armut çeşitlerine göre daha büyük olan boyutuyla dikkat çekiyor.', 'Kilo', 1, '3.0'),
(3, 'Domates', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/28087009/domates-agrocan-salkim-paket-8368af-1650x1650.jpg', '15.00', 'Son derece doğal ve ince kabuklu olan pembe domates, içerdiği A, C, E ve B vitaminleriyle vücudunuzun ihtiyaç duyduğu besin öğelerini karşılama konusunda önemli rol oynuyor.', 'Kilo', 2, '0.0'),
(10, 'Ruffles Cips', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/05089461/05089461-f31164.png', '20.00', 'Frito Lay tarafından üretilen Ruffles cipsleri Türkiye\'nin özenle seçilmiş patateslerini bir araya getirir. ', 'Adet', 3, '4.0'),
(11, 'Tadım Ayçekirdek', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/8097411/08097411-dea313.jpg', '10.00', 'Yüksek demir içerir. Demir yorgunluğun ve bitkinliğin azaltır.\r\n', 'Adet', 3, '0.0'),
(12, 'Eti Gong', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/07012145/07012145-36cdc0.jpg', '2.00', 'Eti Gong muhteşemmm patlamış mısır ve pirinç ', 'Adet', 3, '0.0'),
(13, 'Anna\'s Bisküvi', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/07018351/anna-s-zencefilli-biskuvi-150-gr-3d2d5e.jpg', '22.50', 'Anna\'s Zencefilli Bisküvi 150 gr., farklı lezzetiyle doygun bir tat sunar.\r\n', 'Adet', 3, '0.0'),
(14, 'Torku No On', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/08019138/08019138-7dec9c.jpg', '3.00', 'Zengin içeriği ile tamamen kendine özgü bir lezzet kazandırılan NO ON, gönül rahatlığıyla tüketilmesi yaklaşımıyla tasarlanıp, renklendirici içermeyen, şekeri pancardan ve helal sertifikalı gazlı bir içecektir.', 'Adet', 4, '0.0'),
(15, 'Saol Vitamin C-mix', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/08069989/saol-vitamin-water-c-mix-500-ml-0e65fb.jpg', '7.00', 'Şimdi Saol Vitaminli Su ile, Saol Vitamin Water\'ın, farklı ihtiyaçlara cevap veren dördüncü çeşidi Saol Vitamin Water C + Mix yeni favoriniz olacak. ', 'Adet', 4, '0.0'),
(16, 'Pepsi Ahududu', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/08019129/08019129-25e77f.jpg', '3.00', 'Serin yerde muhafaza ediniz.', 'Adet', 4, '0.0'),
(17, 'Çilek', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/27081000/27081000-7e292e.jpg', '20.00', 'Çilek, hoş kokusu ve parlak rengiyle bahar ve yaz aylarının vazgeçilmez meyvelerinin başında gelir.', 'Kilo', 1, '3.0'),
(18, 'Coca Cola Energy', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/08113115/08113115-1bc95f.jpg', '7.50', 'Coca Cola Energy 250 ML Kutu', 'Adet', 4, '0.0'),
(19, 'Coca Cola', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/08019125/08019125-afe4c7.jpg', '3.80', 'Coca Cola Lime Misket Limonu Aromalı Kola 250 Ml', 'Adet', 4, '0.0'),
(20, 'Finike Portakalı', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/27307029/27307029-f69001.jpg', '7.95', 'Finike Portakalı, dünyanın en lezzetli portakal türlerinden biri olarak bilinir. Finike portakalı, tamamen doğal olarak üretilerek sizlere sunulur; ailece güvenle tüketmeniz için uygundur. ', 'Kilo', 1, '3.0'),
(21, 'Avokado', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/28010004/28010004-10a053.jpg', '10.00', 'Avokado', 'Kilo', 1, '0.0'),
(22, 'Muz Yerli', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/27270000/muz-yerli-kg-9d3d01.jpg', '10.00', 'Muhteşem lezzetiyle günün her saatinde keyifle tüketilebilen muz yerli, en sevilen meyvelerden biri olarak ön plana çıkıyor.', 'Kilo', 1, '0.0'),
(23, 'Greyfurt', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/27162000/27162000-96423c.jpg', '5.00', 'Greyfurt', 'Kilo', 1, '0.0'),
(24, 'Kavun İthal', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/27206002/kavun-ithal-kg-998fb1.jpg', '25.00', 'Kavun İthal', 'Kilo', 1, '0.0'),
(25, 'Salata Kıvırcık', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/28360089/salata-kivircik-adet-da42ae.jpg', '6.00', 'Yılın her mevsimi sofralardaki yerini almayı başaran kıvırcık salata', 'Adet', 2, '0.0'),
(26, 'Salatalık', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/28130000/hiyar-kg-4aa292.jpg', '6.75', 'Sulu yapısı, tazecik, kütür kütür lezzetiyle sofraların vazgeçilmez sebzelerinden biri haline gelen Salatalık, mineral bakımından zengin olan yiyecekler arasındaki yerini almayı başarıyor. ', 'Kilo', 2, '0.0'),
(27, 'Pırasa', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/28330099/pirasa-kg-108f2f.jpg', '6.95', 'Pırasa', 'Kilo', 2, '0.0'),
(28, 'Sivri Biber', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/28054000/biber-sivri-kg-2ab518.jpg', '11.90', 'Yemeklerin içinde, salatalarda, kahvaltılarda ve tek başına tüketebileceğiniz sivri biber, lezzetli ve yararlı bir sebze çeşididir.', 'Kilo', 2, '0.0'),
(29, 'Soğan Kuru Dökme', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/28420000/sogan-kuru-dokme-kg-25131e.jpg', '1.00', 'Soğan Kuru Dökme', 'Kilo', 2, '0.0'),
(35, 'Ülker Napoliten', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/07163020/07163020-74f24f.jpg', '3.00', 'Ülker Napoliten, her biri tek tek ambalajlanıp, şık kutusuna yerleştirilmiş halde sunulmaktadır.', 'Adet', 3, '0.0'),
(36, 'Toblerone Çikolata', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/07040810/07040810-a3a338.jpg', '12.00', 'İsviçre\'de üretilen ve dünyanın ilk üçgen çikolatası olarak anılan Toblerone, sütlü özel formülü ile ağzınızda lezzetli ve unutamayacağınız bir tat bırakır.', 'Adet', 3, '0.0'),
(37, 'Cheetos Multipack', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/05081428/05081428-f9b08f.jpg', '2.00', 'Cheetos Multipack çıtır çıtır, çok lezzetli! ', 'Adet', 3, '0.0'),
(38, 'Kinder Süt Dilimi', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/11561991/kinder-sut-dilimi-4x28-gr-29c0f1.jpg', '5.75', 'Kinder Süt Dilimi özellikle çocukların çok sevdiği bir lezzettir.', 'Adet', 3, '0.0'),
(39, 'Oreo Bisküvi', 'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/07020046/oreo-biskuvi-228-gr-6-li-paket-61fa15.jpg', '14.50', 'Kremayla bisküvinin muhteşem buluşmasından oluşan Oreo bisküvisi çocuklardan yetişkinlere herkesin tercih ettiği ürünlerden biri olmaya devam ediyor. \r\n', 'Adet', 3, '0.0');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `shoppingCart`
--

CREATE TABLE `shoppingCart` (
  `cartUserID` int(11) NOT NULL,
  `cartProductID` int(11) NOT NULL,
  `cartQuantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `users`
--

CREATE TABLE `users` (
  `userID` int(11) NOT NULL,
  `userName` varchar(255) NOT NULL,
  `userPhone` varchar(255) NOT NULL,
  `userEmail` varchar(255) NOT NULL,
  `userPassword` varchar(255) NOT NULL,
  `userProvince` varchar(255) NOT NULL,
  `userDistrict` varchar(255) NOT NULL,
  `userAddress` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`favoriteProductID`,`favoriteUserID`);

--
-- Tablo için indeksler `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`orderID`);

--
-- Tablo için indeksler `productRatings`
--
ALTER TABLE `productRatings`
  ADD PRIMARY KEY (`ratingCustomerID`,`ratingProductID`);

--
-- Tablo için indeksler `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`productID`);

--
-- Tablo için indeksler `shoppingCart`
--
ALTER TABLE `shoppingCart`
  ADD PRIMARY KEY (`cartUserID`,`cartProductID`);

--
-- Tablo için indeksler `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userID`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `orders`
--
ALTER TABLE `orders`
  MODIFY `orderID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `products`
--
ALTER TABLE `products`
  MODIFY `productID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- Tablo için AUTO_INCREMENT değeri `users`
--
ALTER TABLE `users`
  MODIFY `userID` int(11) NOT NULL AUTO_INCREMENT;
