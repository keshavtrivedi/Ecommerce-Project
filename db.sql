-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.13-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for shopping-cart
CREATE DATABASE IF NOT EXISTS `shopping-cart` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `shopping-cart`;

-- Dumping structure for table shopping-cart.cart
CREATE TABLE IF NOT EXISTS `cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `productId` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table shopping-cart.cart: ~0 rows (approximately)
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;

-- Dumping structure for table shopping-cart.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `categoryId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`categoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table shopping-cart.categories: ~4 rows (approximately)
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
REPLACE INTO `categories` (`categoryId`, `name`) VALUES
	(1, 'Drinks\r\n'),
	(2, 'Fruits'),
	(3, 'Meats, Eggs'),
	(4, 'Vegetables');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;

-- Dumping structure for table shopping-cart.products
CREATE TABLE IF NOT EXISTS `products` (
  `productId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `price` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `stock` int(11) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  PRIMARY KEY (`productId`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table shopping-cart.products: ~15 rows (approximately)
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
REPLACE INTO `products` (`productId`, `name`, `price`, `description`, `image`, `stock`, `categoryId`) VALUES
	(1, 'Wine', '200', 'White wine', 'wine01.jpg', 5, 1),
	(2, 'Wine', '500', 'Red wine', 'wine02.jpg', 1, 1),
	(3, 'Wine', '400', 'Fine wine', 'wine03.jpg', 3, 1),
	(4, 'Wine', '1000', 'Fine red wine', 'wine04.jpg', 2, 1),
	(5, 'Wine', '300', 'Wine', 'wine05.jpg', 5, 1),
	(6, 'Beer', '30', 'Kingfisher', 'beer01.jpg', 3, 1),
	(7, 'Beer', '20', 'Heniken', 'beer02.jpg', 10, 1),
	(8, 'Beer', '10', 'Fresh beer', 'beer03.jpg', 20, 1),
	(9, 'Beer', '5', 'Beer', 'beer04.jpg', 100, 1),
	(10, 'Apple', '7', 'Sweet apple', 'apple01.jpg', 200, 2),
	(11, 'Apple', '8', 'Delicious apple', 'apple02.jpg', 10, 2),
	(12, 'Apple', '4', 'Red apple', 'apple03.jpg', 500, 2),
	(13, 'Apple', '3', 'Blue apple', 'apple04.jpg', 20, 2),
	(14, 'Apple', '7', 'Big apple', 'apple05.jpg', 10, 2),
	(15, 'Banana', '20', 'Sweet banana', 'banana01.jpg', 20, 2),
	(16, 'Banana', '15', 'Delicious banana', 'banana02.jpg', 30, 2),
	(17, 'Banana', '25', 'Good banana', 'banana03.jpg', 10, 2),
	(18, 'Beef', '10', 'Meat', 'meat01.jpg', 5, 3),
	(19, 'Pork', '20', 'Pork', 'meat02.jpg', 10, 3),
	(20, 'Lamb', '20', 'Lamb', 'meat03.jpg', 20, 3),
	(21, 'Chicken', '15', 'Chicken', 'meat04.jpg', 15, 3),
	(22, 'Egg', '3', 'Egg', 'egg01.jpg', 30, 3),
	(23, 'Tomato', '2', 'Tomato', 'tomatos.jpg', 10, 4),
	(24, 'Cabbage', '5', 'Cabbage', 'cabbage01.jpg', 50, 4),
	(25, 'Carrot', '1', 'Carrot', 'carrot01.jpg', 20, 4);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;

-- Dumping structure for table shopping-cart.users
CREATE TABLE IF NOT EXISTS `users` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table shopping-cart.users: ~0 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
REPLACE INTO `users` (`userId`, `email`, `password`) VALUES
	(1, 'Keshavtrivedi1145@gmail.com', '0cc175b9c0f1b6a831c399e269772661');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
