-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-11-2024 a las 03:36:56
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `proyecto_final`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carro`
--

CREATE TABLE `carro` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL DEFAULT 1,
  `fecha_agregado` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `carro`
--

INSERT INTO `carro` (`id`, `cliente_id`, `producto_id`, `cantidad`, `fecha_agregado`) VALUES
(67, 16, 3, 4, '2024-11-24 03:07:29'),
(68, 16, 3, 1, '2024-11-24 03:07:29'),
(71, 16, 1, 1, '2024-11-24 03:17:23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`, `descripcion`) VALUES
(1, 'comestible', 'todo tipo de comestible '),
(2, 'bebestible', 'todo tipo de bebestible no alcohólicas '),
(3, 'alcohol', 'todo tipo de bebidas alcohólicas ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` text DEFAULT NULL,
  `contrasena` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `email`, `telefono`, `direccion`, `contrasena`) VALUES
(1, 'facundo', 'facu391@gmail.com', NULL, NULL, '12345'),
(2, 'facundo', 'facu39sadf1@gmail.com', NULL, NULL, '12345'),
(4, 'facundo', 'facu3911@gmail.com', NULL, NULL, '1'),
(5, 'facundo2', 'facu3@gmail.com', NULL, NULL, 'h1234'),
(6, 'facundo2', 'facu23@gmail.com', '23450543', NULL, '21'),
(7, 'facundoads', 'facu3912@gmail.com', '23450543', NULL, '1234'),
(8, 'facundo5r', 'facu391p@gmail.com', '941654891', NULL, '$2a$11$y5ZTILJTGERltIBwKV0KsutFFYmjtgzNSFQnB5.WabMmoMIt4vSMq'),
(9, 'facundo', 'facu3912ss@gmail.com', '23450543', NULL, '$2a$11$w470Nt7k6fZEOM9CDes8qu8JPiu5/AVV0MqNOYRJTU5XIK5Ioi3gy'),
(10, 'facundos', 'facu391ss@gmail.com', '122423', NULL, '$2a$11$ORjjB/m5OY2INTOxHvXfvedpBRDwj0EF1lD4i5epIIQQlq29qZ8Q2'),
(11, 'facundoy', 'h@gmail.com', '1', 'cinco oriente 4854', '$2a$11$5hgWb/JW/wpU.fjp4ZPVZ.Sv8ixSCYXfpludFZNrByonI73vsWEYK'),
(12, 'a', 'a@gmail.com', '1234456', NULL, '$2a$11$Qac3dzKE4TBbgHjtnPBIHuHQfHduCONu1l5cabIa0M3co0k36nCl6'),
(13, 'facundo', 'z@gmail.com', '21345', NULL, '$2a$11$T4W/yDqc/5DZJWWR.Jf/r.qGOEmUnAu.r0TrsN2ZrKS6DbB8jeJua'),
(15, 'miguelasd', 'facgfu3@gmail.com', '3234234', NULL, '$2a$11$bwq7acWQN4hzHUMY8hMSau8oTutmE3vkZ.B.9nrggROuABwakbVRO'),
(16, 'pruebas', 'prueba1@gmail.com', '23450543', 'cinco oriente 4854', '$2a$11$VoCQGZmzEbpNPcAxZ1rwceyBFHRscCUTMfvhI8GIMMuE3Xl/.0Y82'),
(17, 'p', 'q@gmail.com', '12', NULL, '$2a$11$gD3Z4SYaxBumSaBtGuf9oOYrv661/n1PiZd5ArkN3BM6tQAG/.Hcy'),
(18, 'facundo2', 'afacu391@gmail.com', '23450543a', NULL, '$2a$11$z1fF41yiFciVyRXfIum95uoYBqV8o4cJtyw74OXw8/AQRg1ZEZ9FK'),
(19, 'gas', 'pe@gmail.com', '23450543', 'arica', '$2a$11$d7ACnxMb2asg9.grK6NgRuwThBnhcwk8iFDdFexAH3Vl8ffpFidRa'),
(20, 'miguel', 'angel@gmail.com', '432', NULL, '$2a$11$kyMOLeE16rF.L9pxVa5Xru3AuZ61NPD6J9/l9O/7o/9Io27Tth7TK'),
(21, 'ga', 'facu3a@gmail.com', '23450543', 'cinco oriente 4854', '$2a$11$xHArc9ALOwW/SZLSQvD6a.k2NxEnBA7N7rq7L1rht3GRu/BYpGywC'),
(22, 'facundo', 'x@gmail.com', '21', NULL, '$2a$11$cbsI4jSSDX/KlUnx8rsP5uljsdy8qmHKoR6Fl9Gutpks56SkZaS4S'),
(23, 'facundo', 'l@gmail.com', '3', 'cinco oriente 4854', '$2a$11$RFVRgGYjjA43AHa515I1p.iiGIBOqlCtGnHmnwUdTmK.MY93pNq6G');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente_producto`
--

CREATE TABLE `cliente_producto` (
  `cliente_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `etiquetas`
--

CREATE TABLE `etiquetas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `etiquetas`
--

INSERT INTO `etiquetas` (`id`, `nombre`) VALUES
(1, 'Gourmet'),
(2, 'Exclusivo'),
(3, 'Premium'),
(4, 'Organico');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad_disponible` int(11) NOT NULL,
  `fecha_entrada` datetime NOT NULL,
  `fecha_salida` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `id` int(11) NOT NULL,
  `pedido_id` int(11) NOT NULL,
  `metodo_pago` varchar(50) NOT NULL,
  `estado_pago` varchar(50) NOT NULL,
  `fecha_pago` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pagos`
--

INSERT INTO `pagos` (`id`, `pedido_id`, `metodo_pago`, `estado_pago`, `fecha_pago`) VALUES
(1, 1, 'Tarjeta', 'Pendiente', '2024-11-23 00:24:28'),
(2, 2, 'PayPal', 'Pendiente', '2024-11-23 00:39:29'),
(3, 3, 'Tarjeta', 'Pendiente', '2024-11-23 00:49:04'),
(4, 4, 'Tarjeta', 'Pendiente', '2024-11-23 01:15:42'),
(5, 5, 'Tarjeta', 'Pendiente', '2024-11-23 01:20:18'),
(6, 6, 'Efectivo', 'Pendiente', '2024-11-23 01:21:56'),
(7, 7, 'Efectivo', 'Pendiente', '2024-11-23 01:22:39'),
(8, 8, 'Tarjeta', 'Pendiente', '2024-11-23 01:29:55'),
(9, 9, 'Tarjeta', 'Pendiente', '2024-11-23 01:39:34'),
(10, 10, 'Tarjeta', 'Pendiente', '2024-11-23 01:44:04'),
(11, 11, 'Efectivo', 'Pendiente', '2024-11-23 01:44:58'),
(12, 12, 'Tarjeta', 'Pendiente', '2024-11-23 01:46:06'),
(13, 13, 'Tarjeta', 'Pendiente', '2024-11-23 01:49:36'),
(14, 14, 'Tarjeta', 'Pendiente', '2024-11-23 01:51:26'),
(15, 15, 'Tarjeta', 'Pendiente', '2024-11-23 02:02:02'),
(16, 16, 'Efectivo', 'Pendiente', '2024-11-23 02:09:56'),
(17, 17, 'Tarjeta', 'Pendiente', '2024-11-23 02:15:31'),
(18, 18, 'Tarjeta', 'Pendiente', '2024-11-23 20:18:21'),
(19, 19, 'Tarjeta', 'Pendiente', '2024-11-23 21:29:07'),
(20, 20, 'Tarjeta', 'Pendiente', '2024-11-23 21:32:17'),
(21, 21, 'Efectivo', 'Pendiente', '2024-11-23 23:07:38'),
(22, 22, 'Tarjeta', 'Pendiente', '2024-11-23 23:15:57'),
(23, 24, 'Tarjeta', 'Pendiente', '2024-11-23 23:52:24'),
(24, 26, 'Tarjeta', 'Pendiente', '2024-11-23 23:54:02'),
(25, 27, 'Tarjeta', 'Pendiente', '2024-11-24 00:10:14'),
(26, 28, 'Tarjeta', 'Pendiente', '2024-11-24 00:24:36'),
(27, 29, 'Tarjeta', 'Pendiente', '2024-11-24 00:29:49'),
(28, 30, 'Tarjeta', 'Pendiente', '2024-11-24 00:39:19'),
(29, 31, 'Tarjeta', 'Pendiente', '2024-11-24 02:24:52'),
(30, 32, 'Tarjeta', 'Pendiente', '2024-11-24 02:27:24'),
(31, 33, 'PayPal', 'Pendiente', '2024-11-24 02:29:44'),
(32, 34, 'Efectivo', 'Pendiente', '2024-11-24 02:43:16'),
(33, 35, 'Efectivo', 'Pendiente', '2024-11-24 02:58:08'),
(34, 38, 'PayPal', 'Pendiente', '2024-11-24 03:11:48'),
(35, 39, 'Efectivo', 'Pendiente', '2024-11-24 03:16:44'),
(36, 41, 'Tarjeta', 'Pendiente', '2024-11-24 03:19:46'),
(37, 42, 'Tarjeta', 'Pendiente', '2024-11-24 03:29:10'),
(38, 45, 'PayPal', 'Pendiente', '2024-11-24 03:32:18'),
(39, 46, 'Efectivo', 'Pendiente', '2024-11-24 03:32:46'),
(40, 47, 'Efectivo', 'Pendiente', '2024-11-24 03:33:54'),
(41, 48, 'Tarjeta', 'Pendiente', '2024-11-24 03:36:31'),
(42, 49, 'Tarjeta', 'Pendiente', '2024-11-24 03:36:56'),
(43, 50, 'Efectivo', 'Pendiente', '2024-11-24 03:38:52'),
(44, 51, 'Efectivo', 'Pendiente', '2024-11-24 03:39:29'),
(45, 52, 'PayPal', 'Pendiente', '2024-11-24 03:40:15'),
(46, 53, 'Tarjeta', 'Pendiente', '2024-11-24 03:45:20'),
(47, 54, 'Tarjeta', 'Pendiente', '2024-11-24 03:45:40'),
(48, 55, 'PayPal', 'Pendiente', '2024-11-24 03:48:22'),
(49, 56, 'Tarjeta', 'Pendiente', '2024-11-24 03:49:16'),
(50, 57, 'Tarjeta', 'Pendiente', '2024-11-24 03:50:39'),
(51, 58, 'Tarjeta', 'Pendiente', '2024-11-24 03:51:09'),
(52, 59, 'Tarjeta', 'Pendiente', '2024-11-24 03:53:26'),
(53, 60, 'Efectivo', 'Pendiente', '2024-11-24 03:54:46'),
(54, 61, 'Efectivo', 'Pendiente', '2024-11-24 03:58:34'),
(55, 62, 'Efectivo', 'Pendiente', '2024-11-24 04:01:58'),
(56, 63, 'Tarjeta', 'Pendiente', '2024-11-24 04:03:35'),
(57, 65, 'Tarjeta', 'Pendiente', '2024-11-24 04:10:08'),
(58, 68, 'Tarjeta', 'Pendiente', '2024-11-24 04:21:37'),
(59, 69, 'Tarjeta', 'Pendiente', '2024-11-24 04:25:50'),
(60, 71, 'Tarjeta', 'Pendiente', '2024-11-24 04:27:52'),
(61, 72, 'Efectivo', 'Pendiente', '2024-11-24 04:28:31'),
(62, 73, 'Tarjeta', 'Pendiente', '2024-11-24 04:33:02'),
(63, 74, 'Efectivo', 'Pendiente', '2024-11-24 04:34:54'),
(64, 76, 'Tarjeta', 'Pendiente', '2024-11-24 04:44:06'),
(65, 75, 'Tarjeta', 'Pendiente', '2024-11-24 04:44:06'),
(66, 77, 'Efectivo', 'Pendiente', '2024-11-24 04:45:55'),
(67, 78, 'Efectivo', 'Pendiente', '2024-11-24 04:46:09'),
(68, 79, 'Efectivo', 'Pendiente', '2024-11-24 04:46:51'),
(69, 80, 'Efectivo', 'Pendiente', '2024-11-24 04:52:33');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `estado` varchar(50) NOT NULL,
  `EstadoPedido` varchar(50) NOT NULL DEFAULT 'Pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`id`, `cliente_id`, `fecha`, `estado`, `EstadoPedido`) VALUES
(1, 11, '2024-11-23 00:24:28', 'Pendiente', 'Confirmado'),
(2, 11, '2024-11-23 00:39:29', 'Pendiente', 'Confirmado'),
(3, 11, '2024-11-23 00:49:04', 'Pendiente', 'Confirmado'),
(4, 11, '2024-11-23 01:15:42', 'Pendiente', 'Confirmado'),
(5, 11, '2024-11-23 01:20:18', 'Pendiente', 'Confirmado'),
(6, 11, '2024-11-23 01:21:56', 'Pendiente', 'Confirmado'),
(7, 11, '2024-11-23 01:22:39', 'Pendiente', 'Confirmado'),
(8, 11, '2024-11-23 01:29:55', 'Pendiente', 'Confirmado'),
(9, 11, '2024-11-23 01:39:34', 'Pendiente', 'Confirmado'),
(10, 11, '2024-11-23 01:44:04', 'Pendiente', 'Confirmado'),
(11, 11, '2024-11-23 01:44:58', 'Pendiente', 'Confirmado'),
(12, 11, '2024-11-23 01:46:05', 'Pendiente', 'Confirmado'),
(13, 11, '2024-11-23 01:49:36', 'Pendiente', 'Confirmado'),
(14, 11, '2024-11-23 01:51:26', 'Pendiente', 'Confirmado'),
(15, 11, '2024-11-23 02:02:02', 'Pendiente', 'Confirmado'),
(16, 11, '2024-11-23 02:09:56', 'Confirmado', 'Confirmado'),
(17, 11, '2024-11-23 02:15:31', 'Pendiente', 'Confirmado'),
(18, 11, '2024-11-23 20:18:21', 'Pendiente', 'Confirmado'),
(19, 15, '2024-11-23 21:29:07', 'Pendiente', 'Confirmado'),
(20, 11, '2024-11-23 21:32:17', 'Pendiente', 'Confirmado'),
(21, 11, '2024-11-23 23:07:38', 'Pendiente', 'Confirmado'),
(22, 11, '2024-11-23 23:15:57', 'Pendiente', 'Confirmado'),
(23, 11, '2024-11-23 23:52:17', 'Pendiente', 'Confirmado'),
(24, 11, '2024-11-23 23:52:24', 'Pendiente', 'Confirmado'),
(25, 11, '2024-11-23 23:53:57', 'Pendiente', 'Confirmado'),
(26, 11, '2024-11-23 23:54:02', 'Pendiente', 'Confirmado'),
(27, 11, '2024-11-24 00:10:13', 'Pendiente', 'Confirmado'),
(28, 11, '2024-11-24 00:24:36', 'Pendiente', 'Confirmado'),
(29, 11, '2024-11-24 00:29:49', 'Pendiente', 'Confirmado'),
(30, 11, '2024-11-24 00:39:19', 'Pendiente', 'Confirmado'),
(31, 11, '2024-11-24 02:24:52', 'Pendiente', 'Confirmado'),
(32, 16, '2024-11-24 02:27:24', 'Pendiente', 'Confirmado'),
(33, 16, '2024-11-24 02:29:44', 'Pendiente', 'Confirmado'),
(34, 16, '2024-11-24 02:43:16', 'Pendiente', 'Confirmado'),
(35, 16, '2024-11-24 02:58:07', 'Pendiente', 'Confirmado'),
(36, 16, '2024-11-24 03:07:39', 'Pendiente', 'Confirmado'),
(37, 16, '2024-11-24 03:10:40', 'Pendiente', 'Confirmado'),
(38, 17, '2024-11-24 03:11:48', 'Pendiente', 'Confirmado'),
(39, 11, '2024-11-24 03:16:43', 'Pendiente', 'Confirmado'),
(40, 16, '2024-11-24 03:17:31', 'Pendiente', 'Confirmado'),
(41, 1, '2024-11-24 03:19:46', 'Pendiente', 'Confirmado'),
(42, 1, '2024-11-24 03:29:10', 'Pendiente', 'Confirmado'),
(43, 1, '2024-11-24 03:29:33', 'Pendiente', 'Confirmado'),
(44, 1, '2024-11-24 03:32:04', 'Pendiente', 'Confirmado'),
(45, 1, '2024-11-24 03:32:18', 'Pendiente', 'Confirmado'),
(46, 1, '2024-11-24 03:32:46', 'Pendiente', 'Confirmado'),
(47, 1, '2024-11-24 03:33:54', 'Pendiente', 'Confirmado'),
(48, 1, '2024-11-24 03:36:31', 'Pendiente', 'Confirmado'),
(49, 1, '2024-11-24 03:36:56', 'Pendiente', 'Confirmado'),
(50, 1, '2024-11-24 03:38:52', 'Pendiente', 'Confirmado'),
(51, 1, '2024-11-24 03:39:29', 'Pendiente', 'Confirmado'),
(52, 1, '2024-11-24 03:40:14', 'Pendiente', 'Confirmado'),
(53, 1, '2024-11-24 03:45:20', 'Pendiente', 'Confirmado'),
(54, 1, '2024-11-24 03:45:40', 'Pendiente', 'Confirmado'),
(55, 1, '2024-11-24 03:48:22', 'Pendiente', 'Confirmado'),
(56, 1, '2024-11-24 03:49:16', 'Pendiente', 'Confirmado'),
(57, 1, '2024-11-24 03:50:39', 'Pendiente', 'Confirmado'),
(58, 1, '2024-11-24 03:51:09', 'Pendiente', 'Confirmado'),
(59, 1, '2024-11-24 03:53:26', 'Pendiente', 'Confirmado'),
(60, 1, '2024-11-24 03:54:46', 'Pendiente', 'Confirmado'),
(61, 1, '2024-11-24 03:58:34', 'Pendiente', 'Confirmado'),
(62, 1, '2024-11-24 04:01:58', 'Pendiente', 'Confirmado'),
(63, 1, '2024-11-24 04:03:35', 'Pendiente', 'Confirmado'),
(64, 16, '2024-11-24 04:04:28', 'Pendiente', 'Confirmado'),
(65, 11, '2024-11-24 04:10:08', 'Pendiente', 'Confirmado'),
(66, 16, '2024-11-24 04:10:34', 'Pendiente', 'Confirmado'),
(67, 16, '2024-11-24 04:15:05', 'Pendiente', 'Confirmado'),
(68, 11, '2024-11-24 04:21:37', 'Pendiente', 'Confirmado'),
(69, 11, '2024-11-24 04:25:50', 'Pendiente', 'Confirmado'),
(70, 16, '2024-11-24 04:26:19', 'Pendiente', 'Confirmado'),
(71, 21, '2024-11-24 04:27:52', 'Pendiente', 'Confirmado'),
(72, 21, '2024-11-24 04:28:31', 'Pendiente', 'Confirmado'),
(73, 21, '2024-11-24 04:33:01', 'Pendiente', 'Confirmado'),
(74, 21, '2024-11-24 04:34:54', 'Pendiente', 'Confirmado'),
(75, 21, '2024-11-24 04:44:06', 'Pendiente', 'Confirmado'),
(76, 21, '2024-11-24 04:44:06', 'Pendiente', 'Confirmado'),
(77, 23, '2024-11-24 04:45:55', 'Pendiente', 'Confirmado'),
(78, 23, '2024-11-24 04:46:09', 'Pendiente', 'Confirmado'),
(79, 19, '2024-11-24 04:46:51', 'Pendiente', 'Confirmado'),
(80, 19, '2024-11-24 04:52:33', 'Pendiente', 'Confirmado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido_producto`
--

CREATE TABLE `pedido_producto` (
  `pedido_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedido_producto`
--

INSERT INTO `pedido_producto` (`pedido_id`, `producto_id`, `cantidad`) VALUES
(35, 3, 1),
(38, 3, 1),
(39, 2, 1),
(41, 1, 3),
(41, 2, 1),
(41, 3, 3),
(41, 6, 2),
(41, 10, 1),
(41, 15, 1),
(41, 69, 1),
(42, 2, 1),
(43, 3, 1),
(44, 3, 1),
(45, 3, 1),
(46, 1, 1),
(47, 3, 1),
(48, 3, 1),
(49, 3, 1),
(50, 3, 1),
(51, 2, 1),
(52, 2, 1),
(53, 3, 1),
(54, 1, 1),
(55, 3, 1),
(56, 3, 1),
(57, 3, 2),
(58, 1, 1),
(59, 3, 1),
(60, 1, 1),
(61, 3, 1),
(62, 20, 1),
(63, 2, 1),
(65, 3, 1),
(68, 2, 1),
(69, 3, 1),
(71, 3, 1),
(72, 1, 1),
(72, 11, 1),
(73, 2, 1),
(74, 2, 2),
(75, 3, 1),
(76, 3, 1),
(77, 3, 1),
(78, 1, 1),
(79, 2, 1),
(80, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `categoria_id` int(11) DEFAULT NULL,
  `etiqueta_id` int(11) NOT NULL,
  `Proveedor_Id` int(11) NOT NULL,
  `ImageUrl` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `nombre`, `descripcion`, `precio`, `stock`, `categoria_id`, `etiqueta_id`, `Proveedor_Id`, `ImageUrl`) VALUES
(1, 'Aceite de Oliva Extra Virgen', '500 ml de aceite de oliva extra virgen', 4500.00, 10, 1, 1, 1, '/img/aceite_oliva.jpg'),
(2, 'Vino Cabernet Sauvignon', '750 ml de vino tinto de la variedad Cabernet Sauvignon', 8500.00, 8, 3, 1, 1, '/img/vino_cabernet.jpg'),
(3, 'Queso Brie', '200 gr de queso Brie', 5200.00, 15, 1, 3, 1, '/img/queso_brie.jpg'),
(4, 'Te Verde Organico', 'Caja con 20 bolsas de te verde organico', 3200.00, 30, 2, 4, 1, '/img/te_verde.jpg'),
(5, 'Chocolate Belga', 'Barra de chocolate oscuro belga 70% cacao', 3500.00, 25, 1, 2, 1, '/img/chocolate_belga.jpg'),
(6, 'Cerveza Artesanal IPA', '330 ml de cerveza artesanal tipo IPA', 3000.00, 20, 3, 1, 1, '/img/cerveza_ipa.jpg'),
(7, 'Miel de Ulmo', 'Frasco de 500 gr de miel pura de Ulmo', 5000.00, 18, 1, 4, 1, '/img/miel_ulmo.jpg'),
(8, 'Cafe Arabico Premium', '250 gr de cafe en grano arabico premium', 6000.00, 12, 2, 3, 1, '/img/cafe_premiun.jpg'),
(9, 'Whisky Single Malt', '700 ml de whisky escoces Single Malt', 14000.00, 5, 3, 3, 1, '/img/whisky_single_malt.jpg'),
(10, 'Salmon Ahumado', '100 gr de salmon ahumado', 7200.00, 12, 1, 1, 1, '/img/salmon_ahumado.jpg'),
(11, 'Agua Mineral Premium', '500 ml de agua mineral con gas', 1200.00, 50, 2, 4, 1, '/img/agua_mineral.jpg'),
(12, 'Pisco Gran Reserva', '700 ml de pisco chileno gran reserva', 9500.00, 6, 3, 3, 1, '/img/pisco_gran_reserva.jpg'),
(13, 'Caviar de Trucha', 'Frasco de 50 gr de caviar de trucha', 10000.00, 4, 1, 2, 1, '/img/caviar_trucha.jpg'),
(14, 'Te de Frutas', 'Frasco con 20 bolsitas de te de frutas', 2500.00, 25, 2, 4, 1, '/img/te_frutas.jpg'),
(15, 'Galletas Gourmet de Avena', 'Galletas gourmet de avena y nueces', 1800.00, 40, 1, 1, 1, '/img/galletas_avena.jpg'),
(16, 'Ron Premium', '700 ml de ron premium a�ejado', 8000.00, 7, 3, 3, 1, '/img/ron_premium.jpg'),
(17, 'Pasta de Trufa', '250 gr de pasta de trufa', 4800.00, 10, 1, 2, 1, '/img/pasta_trufa.jpg'),
(18, 'Champagne Brut', '750 ml de champagne brut de alta gama', 24000.00, 3, 3, 3, 1, '/img/champagne_brut.jpg'),
(19, 'Aceite de Coco Organico', '500 ml de aceite de coco organico', 4300.00, 15, 1, 4, 1, '/img/aceite_coco.jpg'),
(20, 'Jugo de Uva Natural', '1 litro de jugo de uva organico sin azucar anadido', 3500.00, 30, 2, 4, 1, '/img/jugo_uva.jpg'),
(31, 'Agua_Mineral_Premium', '500 ml de agua mineral con gas', 1200.00, 50, 2, 4, 1, '/img/agua_mineral.jpg'),
(32, 'Pisco_Gran_Reserva', '700 ml de pisco chileno gran reserva', 9500.00, 6, 3, 3, 1, '/img/pisco_gran_reserva.jpg'),
(33, 'Caviar_de_Trucha', 'Frasco de 50 gr de caviar de trucha', 10000.00, 4, 1, 2, 1, '/img/caviar_trucha.jpg'),
(34, 'Te_de_Frutas', 'Frasco con 20 bolsitas de te de frutas', 2500.00, 25, 2, 4, 1, '/img/te_frutas.jpg'),
(35, 'Galletas_Gourmet_de_Avena', 'Galletas gourmet de avena y nueces', 1800.00, 40, 1, 1, 1, '/img/galletas_avena.jpg'),
(36, 'Ron_Premium', '700 ml de ron premium anejado', 8000.00, 7, 3, 3, 1, '/img/ron_premium.jpg'),
(37, 'Pasta_de_Trufa', '250 gr de pasta de trufa', 4800.00, 10, 1, 2, 1, '/img/pasta_trufa.jpg'),
(38, 'Champagne_Brut', '750 ml de champagne brut de alta gama', 24000.00, 3, 3, 2, 1, '/img/champagne_brut.jpg'),
(39, 'Aceite_de_Coco_Organico', '500 ml de aceite de coco organico', 4300.00, 15, 1, 4, 1, '/img/aceite_coco.jpg'),
(40, 'Jugo_de_Uva_Natural', '1 litro de jugo de uva organico sin azucar anadido', 3500.00, 30, 2, 4, 1, '/img/jugo_uva.jpg'),
(41, 'Aceite_de_Oliva_Extra_Virgen', '500 ml de aceite de oliva extra virgen', 4500.00, 10, 1, 1, 1, '/img/aceite_oliva.jpg'),
(42, 'Vino_Cabernet_Sauvignon', '750 ml de vino tinto de la variedad Cabernet Sauvignon', 8500.00, 8, 3, 2, 1, '/img/vino_cabernet.jpg'),
(43, 'Queso_Brie', '200 gr de queso Brie', 5200.00, 15, 1, 3, 1, '/img/queso_brie.jpg'),
(44, 'Te_Verde_Organico', 'Caja con 20 bolsas de te verde organico', 3200.00, 30, 2, 4, 1, '/img/te_verde.jpg'),
(45, 'Chocolate_Belga', 'Barra de chocolate oscuro belga 70% cacao', 3500.00, 25, 1, 2, 1, '/img/chocolate_belga.jpg'),
(46, 'Cerveza_Artesanal_IPA', '330 ml de cerveza artesanal tipo IPA', 3000.00, 20, 3, 1, 1, '/img/cerveza_ipa.jpg'),
(47, 'Miel_de_Ulmo', 'Frasco de 500 gr de miel pura de Ulmo', 5000.00, 18, 1, 4, 1, '/img/miel_ulmo.jpg'),
(48, 'Cafe_Arabico_Premium', '250 gr de cafe en grano arabico premium', 6000.00, 12, 2, 3, 1, '/img/cafe_arabico_premium.jpg'),
(49, 'Whisky_Single_Malt', '700 ml de whisky escoces Single Malt', 14000.00, 5, 3, 2, 1, '/img/whisky_single_malt.jpg'),
(50, 'Salmon_Ahumado', '100 gr de salmon ahumado', 7200.00, 12, 1, 1, 1, '/img/salmon_ahumado.jpg'),
(51, 'Agua_Mineral_Premium', '500 ml de agua mineral con gas', 1200.00, 50, 2, 4, 1, '/img/agua_mineral.jpg'),
(52, 'Pisco_Gran_Reserva', '700 ml de pisco chileno gran reserva', 9500.00, 6, 3, 3, 1, '/img/pisco_gran_reserva.jpg'),
(53, 'Caviar_de_Trucha', 'Frasco de 50 gr de caviar de trucha', 10000.00, 4, 1, 2, 1, '/img/caviar_trucha.jpg'),
(54, 'Te_de_Frutas', 'Frasco con 20 bolsitas de te de frutas', 2500.00, 25, 2, 4, 1, '/img/te_frutas.jpg'),
(55, 'Galletas_Gourmet_de_Avena', 'Galletas gourmet de avena y nueces', 1800.00, 40, 1, 1, 1, '/img/galletas_avena.jpg'),
(56, 'Ron_Premium', '700 ml de ron premium anejado', 8000.00, 7, 3, 3, 1, '/img/ron_premium.jpg'),
(57, 'Pasta_de_Trufa', '250 gr de pasta de trufa', 4800.00, 10, 1, 2, 1, '/img/pasta_trufa.jpg'),
(58, 'Champagne_Brut', '750 ml de champagne brut de alta gama', 24000.00, 3, 3, 2, 1, '/img/champagne_brut.jpg'),
(59, 'Aceite_de_Coco_Organico', '500 ml de aceite de coco organico', 4300.00, 15, 1, 4, 1, '/img/aceite_coco.jpg'),
(60, 'Jugo_de_Uva_Natural', '1 litro de jugo de uva organico sin azucar anadido', 3500.00, 30, 2, 4, 1, '/img/jugo_uva.jpg'),
(61, 'Aceite_de_Oliva_Extra_Virgen', '500 ml de aceite de oliva extra virgen', 4500.00, 10, 1, 1, 1, '/img/aceite_oliva.jpg'),
(62, 'Vino_Cabernet_Sauvignon', '750 ml de vino tinto de la variedad Cabernet Sauvignon', 8500.00, 8, 3, 2, 1, '/img/vino_cabernet.jpg'),
(63, 'Queso_Brie', '200 gr de queso Brie', 5200.00, 15, 1, 3, 1, '/img/queso_brie.jpg'),
(64, 'Te_Verde_Organico', 'Caja con 20 bolsas de te verde organico', 3200.00, 30, 2, 4, 1, '/img/te_verde.jpg'),
(65, 'Chocolate_Belga', 'Barra de chocolate oscuro belga 70% cacao', 3500.00, 25, 1, 2, 1, '/img/chocolate_belga.jpg'),
(66, 'Cerveza_Artesanal_IPA', '330 ml de cerveza artesanal tipo IPA', 3000.00, 20, 3, 1, 1, '/img/cerveza_ipa.jpg'),
(67, 'Miel_de_Ulmo', 'Frasco de 500 gr de miel pura de Ulmo', 5000.00, 18, 1, 4, 1, '/img/miel_ulmo.jpg'),
(68, 'Cafe_Arabico_Premium', '250 gr de cafe en grano arabico premium', 6000.00, 12, 2, 3, 1, '/img/cafe_arabico_premium.jpg'),
(69, 'Whisky_Single_Malt', '700 ml de whisky escoces Single Malt', 14000.00, 5, 3, 2, 1, '/img/whisky_single_malt.jpg'),
(70, 'Salmon_Ahumado', '100 gr de salmon ahumado', 7200.00, 12, 1, 1, 1, '/img/salmon_ahumado.jpg'),
(71, 'Agua_Mineral_Premium', '500 ml de agua mineral con gas', 1200.00, 50, 2, 4, 1, '/img/agua_mineral.jpg'),
(72, 'Pisco_Gran_Reserva', '700 ml de pisco chileno gran reserva', 9500.00, 6, 3, 3, 1, '/img/pisco_gran_reserva.jpg'),
(73, 'Caviar_de_Trucha', 'Frasco de 50 gr de caviar de trucha', 10000.00, 4, 1, 2, 1, '/img/caviar_trucha.jpg'),
(74, 'Te_de_Frutas', 'Frasco con 20 bolsitas de te de frutas', 2500.00, 25, 2, 4, 1, '/img/te_frutas.jpg'),
(75, 'Galletas_Gourmet_de_Avena', 'Galletas gourmet de avena y nueces', 1800.00, 40, 1, 1, 1, '/img/galletas_avena.jpg'),
(76, 'Ron_Premium', '700 ml de ron premium anejado', 8000.00, 7, 3, 3, 1, '/img/ron_premium.jpg'),
(77, 'Pasta_de_Trufa', '250 gr de pasta de trufa', 4800.00, 10, 1, 2, 1, '/img/pasta_trufa.jpg'),
(78, 'Champagne_Brut', '750 ml de champagne brut de alta gama', 24000.00, 3, 3, 2, 1, '/img/champagne_brut.jpg'),
(79, 'Aceite_de_Coco_Organico', '500 ml de aceite de coco organico', 4300.00, 15, 1, 4, 1, '/img/aceite_coco.jpg'),
(80, 'Jugo_de_Uva_Natural', '1 litro de jugo de uva organico sin azucar anadido', 3500.00, 30, 2, 4, 1, '/img/jugo_uva.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto_proveedor`
--

CREATE TABLE `producto_proveedor` (
  `producto_id` int(11) NOT NULL,
  `proveedor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id`, `nombre`, `telefono`, `email`) VALUES
(1, 'Proveedor1', '941543891', 'miguel@gmail.com');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `carro`
--
ALTER TABLE `carro`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_Carro_Cliente` (`cliente_id`),
  ADD KEY `FK_Carro_Producto` (`producto_id`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `cliente_producto`
--
ALTER TABLE `cliente_producto`
  ADD PRIMARY KEY (`cliente_id`,`producto_id`),
  ADD KEY `FK_ClienteProducto_Producto` (`producto_id`);

--
-- Indices de la tabla `etiquetas`
--
ALTER TABLE `etiquetas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `producto_id` (`producto_id`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_Pagos_Pedido` (`pedido_id`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_Pedidos_Clientes` (`cliente_id`);

--
-- Indices de la tabla `pedido_producto`
--
ALTER TABLE `pedido_producto`
  ADD PRIMARY KEY (`pedido_id`,`producto_id`),
  ADD KEY `fk_producto` (`producto_id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_Productos_Categorias` (`categoria_id`),
  ADD KEY `FK_Producto_Etiqueta` (`etiqueta_id`),
  ADD KEY `FK_Productos_Proveedores` (`Proveedor_Id`);

--
-- Indices de la tabla `producto_proveedor`
--
ALTER TABLE `producto_proveedor`
  ADD PRIMARY KEY (`producto_id`,`proveedor_id`),
  ADD KEY `FK_ProductoProveedor_Proveedor` (`proveedor_id`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `carro`
--
ALTER TABLE `carro`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carro`
--
ALTER TABLE `carro`
  ADD CONSTRAINT `FK_Carro_Cliente` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  ADD CONSTRAINT `FK_Carro_Producto` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `cliente_producto`
--
ALTER TABLE `cliente_producto`
  ADD CONSTRAINT `FK_ClienteProducto_Cliente` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  ADD CONSTRAINT `FK_ClienteProducto_Producto` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD CONSTRAINT `FK_Pagos_Pedido` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`);

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `FK_Pedidos_Clientes` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`);

--
-- Filtros para la tabla `pedido_producto`
--
ALTER TABLE `pedido_producto`
  ADD CONSTRAINT `fk_pedido` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_producto` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `FK_Producto_Etiqueta` FOREIGN KEY (`etiqueta_id`) REFERENCES `etiquetas` (`id`),
  ADD CONSTRAINT `FK_Productos_Categorias` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`),
  ADD CONSTRAINT `FK_Productos_Proveedores` FOREIGN KEY (`Proveedor_Id`) REFERENCES `proveedores` (`id`);

--
-- Filtros para la tabla `producto_proveedor`
--
ALTER TABLE `producto_proveedor`
  ADD CONSTRAINT `FK_ProductoProveedor_Producto` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `FK_ProductoProveedor_Proveedor` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
