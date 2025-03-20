-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-02-2024 a las 01:27:00
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `libreria`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `autor`
--

CREATE TABLE `autor` (
  `IdAutor` int(11) NOT NULL,
  `Nombre` varchar(30) NOT NULL,
  `Apellidos` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `autor`
--

INSERT INTO `autor` (`IdAutor`, `Nombre`, `Apellidos`) VALUES
(1, 'Ruben', 'Garcia Lorca'),
(6, 'Ana', 'Crespo Arias'),
(8, 'Marta', 'Muñoz Diaz'),
(10, 'Pepe', 'Diaz Moreno'),
(11, 'Martin', 'Pastor Ferrer'),
(12, 'Fernando', 'Herreras Perez'),
(13, 'Lidia', 'Garcia Merez'),
(14, 'Juan Nicolas', 'Lopez Herman'),
(15, 'Lucia', 'Galvan Lopez'),
(16, 'Eva', 'Jadan Flores'),
(17, 'Patricia', 'de la Torre Verde');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `direccion`
--

CREATE TABLE `direccion` (
  `IdDireccion` int(11) NOT NULL,
  `NombreRemitente` varchar(30) NOT NULL,
  `ApellidosRemitente` varchar(40) NOT NULL,
  `Pais` varchar(40) NOT NULL,
  `Provincia` varchar(40) NOT NULL,
  `Ciudad` varchar(40) NOT NULL,
  `CP` int(11) NOT NULL,
  `Calle` varchar(50) NOT NULL,
  `Numero` int(11) DEFAULT NULL,
  `Piso` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `direccion`
--

INSERT INTO `direccion` (`IdDireccion`, `NombreRemitente`, `ApellidosRemitente`, `Pais`, `Provincia`, `Ciudad`, `CP`, `Calle`, `Numero`, `Piso`) VALUES
(1, 'Juan', 'Perez Limon', 'España', 'Toledo', 'Illescas', 45200, 'Real', 45, NULL),
(3, 'Eustaqui', 'Gamba', 'España', 'Toledo', 'Yuncos', 45210, 'Canada', 20, NULL),
(4, 'Pepito', 'Grillo', 'España', 'Toledo', 'Bargas', 45593, 'Barrio Nuevo', 15, NULL),
(5, 'Marta', 'Jesu', 'España', 'Alicante', 'Torrevieja', 31081, 'Acarretos', NULL, '1ºC'),
(6, 'Carlos', 'Roza', 'España', 'Sevilla', 'Gines', 41001, 'Almirante Lobo', NULL, '2ºB'),
(8, 'Emilio', 'Estino', 'España', 'Toledo', 'Los yébenes (Toledo)', 45470, 'Leon', 50, ''),
(9, 'Pepe', 'Pepito', 'QQQQQ', 'Toledo', 'Los yébenes (Toledo)', 45470, 'Leon', 50, ''),
(10, 'Algodon', 'De Azucar', 'rgretewrtgergt', 'Toledo', 'Los yébenes (Toledo)', 45470, 'Leon', 50, ''),
(11, 'Ana', 'Fernandéz Prieto', 'España', 'Albacete', 'Alcalá del júcar', 2210, 'Cuenca', 34, '3ºC'),
(12, 'Marta', 'Garcia', 'España', 'Toledo', 'Illescas', 45200, 'Almenares', 45, ''),
(13, 'Fernando', 'Hernández Maeso', 'España', 'Albacete', 'Alcalá del júcar', 2210, 'Cuenca', 34, '3ºC'),
(14, 'Henar', 'Del Valle Henares', 'Francia', 'Paris', 'Île-de-France', 75001, 'Rue des Fleurs Parfumées', 12, ''),
(17, 'Ana', 'Galan Sanz', 'Portugal', 'Lisboa', 'Lisboa', 1000, 'Rua das Oliveiras', 5, ''),
(57, 'Alex', 'Sanchez', 'España', 'Toledo', 'Bargas', 45003, 'Belgica', 1, ''),
(58, 'Pepita ', 'Perez', 'Espala', 'Toledo', 'Bargas', 4165485, 'Pepe', 14, ''),
(59, 'Pepita ', 'Perez', 'Espala', 'Toledo', 'Bargas', 1265156, 'Pepe', 51, ''),
(60, 'asa', 'asa', 'as', 'as', 'as', 544, 'dfgd', 4, ''),
(61, 'Pepita ', 'Perez', 'as', 'sada', 'asd', 515, 'asdas', 1, ''),
(62, 'dsf', 'df', 'df', 'sdf', 'sdf', 613, 'asd', 6, '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `genero`
--

CREATE TABLE `genero` (
  `IdGenero` int(11) NOT NULL,
  `Nombre` varchar(30) NOT NULL,
  `Descripcion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `genero`
--

INSERT INTO `genero` (`IdGenero`, `Nombre`, `Descripcion`) VALUES
(1, 'Terror', 'En la categoria de terror encontraras diversos libros de terror\r\n'),
(2, 'Romance', 'En la categoria de romance encontraras diversos libros de romance\r\n\r\n'),
(3, 'Ciencia', 'En la categoria de ciencia encontraras diversos libros de ciencia\r\n'),
(4, 'Fantasia', 'En la categoria de fantasia encontraras diversos libros de fantasia\r\n'),
(5, 'Thriller', 'En la categoria de thriller encontraras diversos libros de thriller\r\n\r\n'),
(6, 'Comic y Manga', 'En la categoria de comic y manga encontraras diversos libros de comic y manga\r\n\r\n'),
(7, 'Autoayuda y Espiritualidad', 'En la categoria de ayuda y espiritualidad encontraras diversos libros de ayuda y espiritualidad\r\n'),
(8, 'Infantiles', 'En la categoria de infantiles encontraras diversos libros de infantiles\r\n\r\n');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libro`
--

CREATE TABLE `libro` (
  `IdLibro` int(20) NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  `Descripcion` varchar(5000) NOT NULL,
  `Precio` decimal(10,2) NOT NULL,
  `Genero` int(11) NOT NULL,
  `Autor` int(11) NOT NULL,
  `Formato` varchar(20) NOT NULL,
  `Edicion` int(20) NOT NULL,
  `Tipo` varchar(20) NOT NULL,
  `Stock` int(11) NOT NULL,
  `ISBN` varchar(20) NOT NULL,
  `Saga` varchar(40) DEFAULT NULL,
  `Num_Saga` int(11) DEFAULT NULL,
  `Imagen` varchar(100) NOT NULL,
  `Populares` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `libro`
--

INSERT INTO `libro` (`IdLibro`, `Nombre`, `Descripcion`, `Precio`, `Genero`, `Autor`, `Formato`, `Edicion`, `Tipo`, `Stock`, `ISBN`, `Saga`, `Num_Saga`, `Imagen`, `Populares`) VALUES
(1, 'La casa de las sombras', 'Catherine, tras superar un despedido injusto y el acoso en una cadena televisiva en Londres, comienza de nuevo. Le ofrecen catalogar la singular colección de muñecas y títeres antiguos de M.H. Mason, con representaciones sangrientas de la Gran Guerra. Invitada a la Red House, donde se resguarda la colección, Catherine enfrenta oscuros secretos detrás de las macabras exhibiciones. Visiones de Mason despiertan sombras de su pasado, desafiando su estabilidad mental. La trama oscila entre realidad, cordura y memoria, desenterrando verdades inquietantes. La novela explora la lucha de Catherine por enfrentar su pasado y descubrir horrores inimaginables.', '18.00', 1, 1, 'Fisico', 1, 'Tapa Blanda', 0, '978-8445014882', NULL, NULL, '../img/Libros/Terror/la casa de las sombras.jpg', 1),
(2, 'La casa de las sombras', 'Catherine, tras superar un despedido injusto y el acoso en una cadena televisiva en Londres, comienza de nuevo. Le ofrecen catalogar la singular colección de muñecas y títeres antiguos de M.H. Mason, con representaciones sangrientas de la Gran Guerra. Invitada a la Red House, donde se resguarda la colección, Catherine enfrenta oscuros secretos detrás de las macabras exhibiciones. Visiones de Mason despiertan sombras de su pasado, desafiando su estabilidad mental. La trama oscila entre realidad, cordura y memoria, desenterrando verdades inquietantes. La novela explora la lucha de Catherine por enfrentar su pasado y descubrir horrores inimaginables.', '7.99', 1, 1, 'Digital', 1, 'Ebook', 896, '978-8445014482', NULL, NULL, '../img/Libros/Terror/la casa de las sombras.jpg', 0),
(3, 'Mi esposa y yo compramos un rancho', 'Harry, un exmarine, y su mujer, Sasha, han dejado su ajetreada vida en la ciudad para marcharse a vivir de la tierra en un rancho en las montañas de Idaho. Su maravilloso nuevo hogar se halla alrededor de quince hectáreas de campo, álamos y bosques de pinos en el valle de Teton. Aunque sus amigos no comprenden este extraño cambio de vida, Harry y Sasha no pueden estar más emocionados del futuro que están construyendo juntos y sin ayuda de nadie.\nO al menos hasta que sus vecinos les advierten del espíritu que habita el valle. Uno que, dependiendo de la estación, acecha y cambia de aspecto. Aunque al principio crean que no se trata más que de una superstición local, conforme vayan pasando las estaciones, todo se volverá cada vez más peligroso y siniestro.', '18.52', 1, 17, 'Fisico', 3, 'Tapa Blanda', 862, '978-8408267515', NULL, NULL, '../img/Libros/Terror/mi esposa y yo compramos un rancho.jpg', 1),
(4, 'Noche buena en un barco embrujado', '¡El mejor libro para leer estas fiestas navideñas! Afirmó que nunca había visto un fantasma y que le encantaría hacerlo: “sobre todo ahora, en Navidad, que sería el momento adecuado por el ambiente festivo\".', '24.95', 1, 13, 'Fisico', 8, 'Tapa Dura', 100, '978-8419790361', NULL, NULL, '../img/Libros/Terror/nochebuena en un barco embrujado.jpg', 0),
(5, 'Acercate', 'Amanda es una arquitecta de éxito felizmente casada, quien, un día, empieza a experimentar extraños fenómenos: una propuesta dirigida a su jefe es sustituida por otra llena de insultos obscenos, unos extraños golpeteos no cesan de oírse en su casa, siente la necesidad de volver a fumar y termina quemando ``accidentalmente`` a su marido con un cigarro y por las noches sueña con una bella mujer de afilados dientes a la orilla de un mar rojo como la sangre. Amanda siente que su vida ha perdido el equilibrio y está deslizándose por una curva peligrosa, pero no termina de entender por qué. No sabe si está poseída por un demonio o perdiendo la cabeza. En un rincón de su mente no cesa de preguntarse si en realidad no está disfrutando con todo lo que le sucede y eso la aterroriza aún más.', '21.90', 1, 6, 'Fisico', 2, 'Tapa Blanda', 50, '978-8412564020', NULL, NULL, '../img/Libros/Terror/acercate.jpg', 0),
(6, 'Cruentos', 'Relatos de terror en verso\r\nCuarenta relatos de terror en verso. Cuarenta\r\ninolvidables cápsulas de miedo en mayúsculas\r\nacompañadas de magníficas ilustraciones.\r\nLovecraft, Poe y King se unen en una nueva y\r\noriginal perspectiva que redimensiona los pasajes del horror de la mano de un reconocido y multidimensional artista en su obra más completa y lúcida. Un inquietante, tenebroso e indeleble viaje en el que nunca antes te habías sumergido y una pesadilla convertida en placer culpable. ¿Te atreves a vivir una experiencia de la que no hay vuelta atrás.', '18.00', 1, 10, 'Fisico', 3, 'Tapa Dura', 500, '978-8412638691', NULL, NULL, '../img/Libros/Terror/cruentos.jpg', 0),
(7, 'Cell', 'El día 1 de octubre a las 15:03 se envían mensajes a través de los teléfonos móviles que convierten a todos los que los reciben en zombies asesinos... Se desata una locura criminal y destructiva de la que pocos escaparán, y los que lo logren tendrán que sobrevivir en un mundo totalmente transformado. Terror puro, el retrato de un mundo escalofriante que nunca volverá a ser el mismo.', '2.99', 1, 6, 'Bolsillo', 2, 'Tapa Dura', 20, '978-8483464434', NULL, NULL, '../img/Libros/Terror/cell.jpg', 0),
(8, 'Los mejores cuentos de terror sobrenatural', 'Esta cuidada selección se abre con La leyenda de Sleepy Hollow. una obra maestra de Washington Irving, la increíble historia del jinete sin cabeza que aterroriza sobre su imponente caballo a una tranquila y peculiar población agrícola. También encontrará a Edgar Allan Poe con su Berenice, El pozo y el péndulo...', '4.50', 1, 6, 'Digital', 1, 'Ebook', 500, '978-8416775521', NULL, NULL, '../img/Libros/Terror/los mejores cuentos de terror sobrenatural.jpg', 0),
(9, 'Donde surgen las sombras', 'Álex, un adolescente aficionado a los videojuegos, no parece tener ningún problema... hasta que un día desaparece sin dar explicaciones. Sus amigos inician una búsqueda a contrarreloj salpicada de dificultades y atroces asesinatos. ¿Qué o quién está detrás de esas muertes? Una novela de misterio que destaca la fuerza de la amistad en la superación de dificultades.', '5.99', 1, 1, 'Digital', 3, 'Ebook', 100, '978-8467543223', NULL, NULL, '../img/Libros/Terror/donde surgen las sombras.jpg', 0),
(10, 'El puente de Borgo', 'Fenix, un agente exterminador de humanos reducidos al canibalismo y a la barbarie, recibe un encargo de las Hormas: atrapar vivo a Möh, el devorador de niños, con la anómala finalidad de ahondar en su cerebro para obtener ciertos recuerdos. Mientras tanto, en algún lugar de la misma ciudad, un hombre, incapaz de recordarse, despierta en un contexto extrañamente ingrávido junto a un Vigía, un enviado del Humaniversal que le ayudará a comprender su insólita situación. La peripecia de Fenix y la del hombre sin identidad, culminarán con el misterio que rodea al ingenio científico llamado Puente de Borgo, y un futuro de pesadilla se abrirá ante ambos como la única vía hacia la esperanza.', '5.99', 1, 1, 'Bolsillo', 1, 'Tapa Dura', 100, '978-8419380821', NULL, NULL, '../img/Libros/Terror/el puente de borgo.jpg', 0),
(11, 'Las hijas de la criada', 'Una noche de febrero de 1900, recién estrenado el siglo XX, en el pazo de Espíritu Santo llegan al mundo dos niñas, Clara y Catalina, cuyos destinos ya estaban escritos. Sin embargo, una venganza inesperada sacudirá para siempre sus vidas y las de todos los Valdés.\r\n\r\nDoña Inés, matriarca de la saga y fiel esposa de don Gustavo, deberá sobrevivir al desamor, al dolor del abandono y a las luchas de poder hasta convertir a su verdadera hija en heredera de todo un imperio, en una época en la que a las mujeres no se les permitía ser dueñas de sus vidas.', '22.99', 2, 15, 'Fisico', 1, 'Tapa Dura', 119, '978-8408280170', NULL, NULL, '../img/Libros/Romance/las hijas de la criada.jpg', 0),
(12, '¿Tú lo harías?', 'Adéntrate en esta comedia romántica y verás como las decepciones amorosas no se superan con lágrimas, sino con la seguridad absoluta de que no hay nadie más fuerte que una mujer que aprende a reconstruirse a sí misma.\r\n\r\n¿Tú lo harías? nos presenta a tres mujeres de poco más de treinta años que aparentemente no tienen nada en común.\r\n\r\nÁfrica es periodista, aunque la ilusión de su vida es ser editora.\r\n\r\nGema está especializada en marketing y publicidad y es madre de dos hijos.\r\n\r\n \r\nBelinda es limpiadora en hoteles y hospitales.\r\n\r\nEllas no se conocen de nada, hasta que un buen día coinciden en un local llamado Bébete a Tu Ex. A partir de ese momento forjarán una amistad que las ayudará a hacer frente a las distintas decepciones que han sufrido por amor y, ante una botellita de vino, se retarán a vivir la vida uno o varios puntitos más allá de hasta donde se habían atrevido a hacerlo.\r\n\r\n \r\nEso significará un ¡ADIÓS! a los miedos y vergüenzas, especialmente al qué dirán, y un gran ¡HOLA! a vivir, atreverse, quererse y disfrutar.\r\n\r\nPorque por muchas veces que hagas caer a una mujer en su camino, ella siempre se levantará, se sacudirá el polvo y se hará más fuerte.', '17.99', 2, 8, 'Fisico', 1, 'Tapa Blanda', 500, '978-8408279181', NULL, NULL, '../img/Libros/Romance/y tu lo harias.png\"', 0),
(14, '¿Tú lo harías?', 'Adéntrate en esta comedia romántica y verás como las decepciones amorosas no se superan con lágrimas, sino con la seguridad absoluta de que no hay nadie más fuerte que una mujer que aprende a reconstruirse a sí misma.\r\n\r\n¿Tú lo harías? nos presenta a tres mujeres de poco más de treinta años que aparentemente no tienen nada en común.\r\n \r\nÁfrica es periodista, aunque la ilusión de su vida es ser editora.\r\n \r\nGema está especializada en marketing y publicidad y es madre de dos hijos.\r\n \r\nBelinda es limpiadora en hoteles y hospitales.\r\n\r\nEllas no se conocen de nada, hasta que un buen día coinciden en un local llamado Bébete a Tu Ex. A partir de ese momento forjarán una amistad que las ayudará a hacer frente a las distintas decepciones que han sufrido por amor y, ante una botellita de vino, se retarán a vivir la vida uno o varios puntitos más allá de hasta donde se habían atrevido a hacerlo.\r\n\r\nEso significará un ¡ADIÓS! a los miedos y vergüenzas, especialmente al qué dirán, y un gran ¡HOLA! a vivir, atreverse, quererse y disfrutar.\r\n\r\nPorque por muchas veces que hagas caer a una mujer en su camino, ella siempre se levantará, se sacudirá el polvo y se hará más fuerte.', '9.49', 2, 8, 'Digital', 1, 'Ebook', 480, '978-8408278181', NULL, NULL, '../img/Libros/Romance/y tu lo harias.png\"', 1),
(15, 'Culpa mia', '#CulpaMía\r\n\r\n«La mejor historia de amor que he leído en mi vida.», «Me atrapó con cada palabra.», «¡Me quedé leyendo hasta las 5 de la madrugada!», «Lo mejor que he leído en mucho tiempo.», «Nick es un gran personaje, ¡ojalá fuera real!», «Mercedes Ron no ha creado una historia: ha creado magia.»\r\n(La opinión de los lectores)\r\n\r\nNicholas Leister ha sido creado para amargarme la vida. Alto, ojos azules, pelo negro como la noche... Suena genial ¿verdad? Pues no tanto cuando te enteras de que va a ser tu hermanastro y además representa todo de lo que has estado huyendo desde que tienes uso de razón.\r\n\r\nPeligro fue lo primero que me vino a la cabeza cuando lo conocí y descubrí que mantiene una doble vida oculta de su padre multimillonario.\r\n\r\n¿Cómo terminé cayendo en sus redes? Fácil: con esos ojos es capaz de poner tu mundo patas arriba.\r\n\r\nEn los blogs...\r\n«Una historia apasionante con una protagonista fuerte, decidida, independiente y escenas muy tiernas y conmovedoras que me han conquistado. Este libro es impresionante.»\r\nBlog Entre metáforas\r\n\r\n«Atrapa por su increíble narración, sus potentes protagonistas y su atrayente historia.»\r\nBlog El rincón de Leyna\r\n\r\n«Una historia totalmente preciosa que sienta las bases de una grandísima trilogía.»\r\nBlog It\'s time to magic\r\n\r\n«No te puedes despegar hasta que no lees el último párrafo y piensas ¿cuándo saldrá la segunda parte?»\r\nBlog de Laure Ever\r\n\r\n«Un libro adictivo y que se lee de un tirón. Primera parte de una trilogía queestoy deseando continuar. Súper recomendado para las que les gusta el New Adult.»\r\nBlog El desván de las mil y un\r\n\r\n«Desde el momento que empecé la primera hoja, me atrapó tanto la historia que no pude dejar de leerla hasta el final. El primer libro de una trilogía que estoy deseando continuar no os va decepcionar en absoluto.»\r\nBlog Words of Books\r\n\r\n«Creedme cuando os digo que es una historia muy diferente, innovadora, que todo empieza de una manera muy distinta a otros libros... Es genial y ya.»\r\nBlog Los mundos de blue\r\n\r\n«Me ha gustado mucho. Es inesperado, peligroso y trepidante... Una historia que crea adicción desde la primera hasta la última página. Con unos personajes alocados y muy característicos, una trama envolvente y unos giros de vértigo.»\r\nBlog Viajando a otros mundos', '17.05', 2, 15, 'Fisico', 1, 'Tapa Blanda', 510, '978-8490438664', 'Culpables', 1, '../img/Libros/Romance/culpa mia.jpg', 0),
(16, 'Culpa tuya', '#CulpaTuya\r\n\r\nMás romance, traición y misterio en Culpa tuya, segunda parte de «Culpa Mía», la saga romántica de Mercedes Ron protagonizada por un chico malo con un gran corazón y una chica buena con muchas agallas.\r\n\r\nCuando Noah se enamoró de Nick sabía que su relación no iba a ser fácil: son polos opuestos, fuego y electricidad, y cuando están juntos saltan chispas... en todos los sentidos.\r\n\r\nHasta ahora, la pasión ha sido más fuerte que el orgullo, pero la diferencia de edad, la universidad, las fiestas, sus padres y los fantasmas que acechan a los dos les ponen a prueba una y otra vez, como una bomba de relojería que amenaza con hacerles estallar.\r\n\r\n¿Está Noah realmente preparada para enfrentarse a sus miedos y volver a confiar en alguien?\r\n\r\n¿Podrá Nicholas dejar atrás su pasado y abrir el corazón a una sola persona?', '17.05', 2, 15, 'Fisico', 1, 'Tapa Blanda', 500, '978-8413142029', 'Culpables', 2, '../img/Libros/Romance/culpa tuya.jpg', 0),
(17, 'Culpa nuestra', 'DESCUBRE LA SAGA QUE HA INSPIRADO LA PELÍCULA\r\n\r\n  \r\n¿Hasta dónde están dispuestos a llegar Nick y Noah?\r\n\r\n \r\nDescúbrelo en #CulpaNuestra, la entrega final de la trilogía \"Culpables\".\r\n\r\n \r\nLa relación de Nick y Noah está pasando por su peor momento, y parece que nada podrá volver a ser como antes... Van a tener que pasarpor muchas cosas para finalmente comprender si de verdad están hechos el uno para el otro o si por lo contrario, estar separados es lo que de verdad les conviene.\r\n\r\n \r\nPero ¿acaso se puede olvidar un amor tan fuerte? ¿Cómo pueden borrarse los recuerdos tatuados en el corazón?\r\n\r\n \r\nEl amor no siempre es suficiente y el perdón a veces no basta para solucionar las cosas.\r\n\r\n¿Serán capaces de dejar atrás el pasado y volver a empezar?\r\n\r\nLos lectores opinan sobre \"Culpables\"...\r\n\"Leí Culpa mía por casualidad y ¡¡me quede completamente enganchada!!\"\r\n\r\n \r\n\"¡Me ha dejado sumamente enamorada!\"\r\n\r\n \r\n\"¡Me quede sin palabras!\"\r\n\r\n\"¡Por fin podre leer el final de la serie!\"\r\n\r\n \r\n\"Desde que termine Culpa tuya no he podido dejar de pensar en Nick y Noah.\"', '17.05', 2, 15, 'Fisico', 1, 'Tapa Blanda', 500, '978-8413142036', 'Culpables', 3, '../img/Libros/Romance/culpa nuestra.jpg', 0),
(18, 'Jaque mate al amor', 'De la autora de La hipótesis del amor, una romcom en la que los caminos de dos rivales del ajedrez se cruzan en una competición donde acabarán jugándose el corazón\r\n\r\n\r\n\r\nPara Mallory Greenleaf, el ajedrez ha pasado a mejor vida. Ahora sopesa con cuidado cada decisión que toma: después de que dicho deporte hiciese estragos en su familia hace cuatro años, Mallory se dedica en exclusiva a su madre, a sus hermanas y a un trabajo basura con el que paga las facturas. Al menos, hasta que accede de mala gana a participar en un último torneo benéfico y, sin pretenderlo, machaca al famoso Matarreyes, Nolan Sawyer: el campeón mundial y el tío más malote del ajedrez.\r\n\r\n\r\n\r\nLa derrota de Nolan frente a una donnadie de cam-peón-ato deja de piedra a todo el mundo. Pero lo más desconcertante es que el chico quiere enfrentarse de nuevo a ella. ¿Qué clase de gambito está poniendo Nolan en práctica? Lo más inteligente sería dar media vuelta y marcharse. Abandonar. Dar por finiquitada la partida. Sin embargo, la victoria le brinda la posibilidad de embolsarse unos cuantos premios en metálico, algo que buena falta le hace, y, pese a todo, no puede evitar sentirse atraída por el enigmático estratega...\r\n\r\n\r\n\r\nA medida que escala puestos en la clasificación a toda velocidad, Mallory se las ve y se las desea para mantener a su familia al margen del juego que lo echó todo a perder. Y a medida que su amor por el deporte que ha intentado detestar con todas sus fuerzas se reaviva, no tarda en descubrir que las partidas no se llevan a cabo únicamente sobre el tablero, que estar en el punto de mira es más complicado de lo que imaginaba y que la competencia puede ser feroz (-mente atractiva. E inteligente... Y exasperante...).', '20.00', 2, 11, 'Fisico', 1, 'Tapa Blanda', 120, '978-8418945465', NULL, NULL, '../img/Libros/Romance/jaque mate al amor.jpg', 0),
(19, 'Todo lo que nunca fuimos: Deja que ocurra 1', 'Primera parte de la bilogía \"Deja que ocurra\" de Alice Kellen:\r\n\r\nLeah está rota. Leah ya no pinta. Leah es un espejismo desde el accidente que se llevó a sus padres.\r\n\r\nAxel es el mejor amigo de su hermano mayor y, cuando accede a acogerla en su casa durante unos meses, quiere ayudarla a encontrar y unir los pedazos de la chica llena de color que un día fue. Pero no sabe que ella siempre ha estado enamorada de él, a pesar de que sean casi familia, ni de que toda su vida está a punto de cambiar.\r\n\r\nPorque ella está prohibida, pero le despierta la piel.\r\n\r\nPorque es el mar, noches estrelladas y vinilos de los Beatles.\r\n\r\nPorque a veces basta un «deja que ocurra» para tenerlo todo.', '9.44', 2, 10, 'Bolsillo', 1, 'Tapa Dura', 33, '978-8408221951', 'Deja que ocurra', 1, '../img/Libros/Romance/todo lo que nunca fuimos 1.jpg', 0),
(20, 'Todo lo que somos juntos: Deja que ocurra 2', 'Tras el éxito de Todo lo que nunca fuimos llega el desenlace de la Bilogía «Deja que ocurra». ¿Qué pasará con Axel y Leah?\r\n\r\nHan pasado tres años desde la última vez que se vieron. Ahora, Leah está a punto de cumplir su sueño de exponer en una galería.\r\n\r\nY, pese al pasado, Axel necesita formar parte de un momento como ese.\r\n\r\nCuando sus caminos vuelven a cruzarse, Leah tiene que tomar decisiones que pueden cambiarlo todo, porque, a pesar de lo que ocurrió, los recuerdos de toda su vida siguen ahí; intactos, bonitos, únicos. Colándose en cada grieta que aún no ha cerrado.\r\nPorque él sigue siendo el chico que aún no ha olvidado.\r\nPorque es el mar, noches estrelladas y vinilos de los Beatles.\r\nPorque a veces basta un «deja que ocurra» para tenerlo todo.', '9.44', 2, 10, 'Bolsillo', 1, 'Tapa Dura', 100, '978-8408221968', 'Deja que ocurra', 2, '../img/Libros/Romance/todo lo que somos juntos 2.jpg', 0),
(21, 'Todo lo que nunca fuimos: Deja que ocurra 1', 'Primera parte de la bilogía \"Deja que ocurra\" de Alice Kellen:\r\n\r\nLeah está rota. Leah ya no pinta. Leah es un espejismo desde el accidente que se llevó a sus padres.\r\n\r\nAxel es el mejor amigo de su hermano mayor y, cuando accede a acogerla en su casa durante unos meses, quiere ayudarla a encontrar y unir los pedazos de la chica llena de color que un día fue. Pero no sabe que ella siempre ha estado enamorada de él, a pesar de que sean casi familia, ni de que toda su vida está a punto de cambiar.\r\n\r\nPorque ella está prohibida, pero le despierta la piel.\r\n\r\nPorque es el mar, noches estrelladas y vinilos de los Beatles.\r\n\r\nPorque a veces basta un «deja que ocurra» para tenerlo todo.', '2.84', 2, 10, 'Digital', 1, 'Ebook', 97, '978-8408231951', 'Deja que ocurra', 1, '../img/Libros/Romance/todo lo que nunca fuimos 1.jpg', 0),
(22, 'Todo lo que somos juntos: Deja que ocurra 2', 'Tras el éxito de Todo lo que nunca fuimos llega el desenlace de la Bilogía «Deja que ocurra». ¿Qué pasará con Axel y Leah?\r\n\r\nHan pasado tres años desde la última vez que se vieron. Ahora, Leah está a punto de cumplir su sueño de exponer en una galería.\r\n\r\nY, pese al pasado, Axel necesita formar parte de un momento como ese.\r\n\r\nCuando sus caminos vuelven a cruzarse, Leah tiene que tomar decisiones que pueden cambiarlo todo, porque, a pesar de lo que ocurrió, los recuerdos de toda su vida siguen ahí; intactos, bonitos, únicos. Colándose en cada grieta que aún no ha cerrado.\r\nPorque él sigue siendo el chico que aún no ha olvidado.\r\nPorque es el mar, noches estrelladas y vinilos de los Beatles.\r\nPorque a veces basta un «deja que ocurra» para tenerlo todo.', '5.69', 2, 10, 'Digital', 1, 'Ebook', 100, '978-8408231968', 'Deja que ocurra', 2, '../img/Libros/Romance/todo lo que somos juntos 2.jpg', 0),
(23, 'Una vida en nuestro planeta', '«Tengo 94 años. He tenido una vida extraordinaria. Es solo ahora que aprecio lo extraordinario.\r\nCuando era joven, sentía que estaba en la naturaleza, experimentando el mundo natural intacto, pero era una ilusión. La tragedia de nuestro tiempo ha estado sucediendo a nuestro alrededor, apenas perceptible día a día: la pérdida de los lugares salvajes de nuestro planeta, su biodiversidad.\r\nHe sido testigo de este declive. Una vida en nuestro planeta es mi testimonio y una visión para el futuro. Es la historia de cómo llegamos a cometer esto, nuestro mayor error, y cómo, si actuamos ahora, aún podemos corregirlo.\r\nTenemos una última oportunidad de crear el hogar perfecto para nosotros y restaurar el maravilloso mundo que heredamos.\r\nTodo lo que necesitamos es la voluntad para hacerlo.»', '19.90', 3, 14, 'Fisico', 2, 'Tapa Dura', 119, '978-8491993117', NULL, NULL, '../img/Libros/Ciencia/una vida en nuestro planeta.jpg', 0),
(24, 'Agujeros negros y tiempo curvo', '“Durante treinta años –nos dice Kip S. Thorne, profesor del California Institute of Tecnology- he participado en una gran búsqueda para comprender el legado dejado por Albert Einstein a las generaciones futuras. Esta búsqueda me ha llevado por laberintos de objetos exóticos: agujeros negros, enanas blancas, estrellas de neutrotes, singularidades, ondas gravitatorias, distorsiones del tiempo, agujeros de gusano y máquinas del tiempo.” Muchos investigadores, comenzando por el propio Einstein, se negaban a aceptar algunas de las fantásticas consecuencias que podían deducirse de la teoría de la relatividad. Han sido científicos de una nueva generación, y en especial Roger Penrose y Kip S. Thorne, quienes han llevado esta búsqueda a sus últimas consecuencias. Si los libros de los dos primeros –Historia del tiempo y La nueva mente del emperador- descubrieron al lector medio la nueva imagen del universo, Agujeros negros y tiempo curvo le conducirá adentro y más allá.\r\n\r\nThorne comienza llevándonos a un viaje a los agujeros negros y, desde allí, nos hace seguir el descubrimiento de las nuevas concepciones, desde Einstein hasta nuestros días, en una especie de relato histórico sazonado de anécdotas vividas, a lo largo del cual vamos aprendiendo los conceptos básicos hasta llegar al punto en que agujeros de gusano y máquinas del tiempo nos parecen posibilidades lógicas y comprensibles. Si Stephen Hawking ha calificado este libro como “un relato fascinante”, otro de los protagonistas de esta historia, el gran astrofísico ruso Igor Novikov ha dicho: “es uno de los mejores libros de divulgación científica que he leído: todos cuantos aman los misterios científicos disfrutarán con él”.', '7.49', 3, 14, 'Digital', 3, 'Ebook', 95, '978-8498921557', NULL, NULL, '../img/Libros/Ciencia/Agujeros negros y tiempo curvo.jpg', 0),
(25, 'Las leyes fundamentales de la estupidez humana', '«La humanidad se encuentra –y sobre esto el acuerdo es unánime- en un estado deplorable», nos dice Carlo M. Cipolla, uno de los mayores historiadores del siglo XX. Lo cual se debe en buena medida a la abundancia de los estúpidos, la más peligrosa categoría de seres humanos, que nos rodean por todas partes, dispuestos a hacernos daño (y hacérselo a sí mismos).\r\n\r\nTodo comenzó como un rasgo de humor, asociado a la crítica del fraude científico en Allegro ma non troppo, hasta que sus lectores descubrieron que estas Leyes fundamentales de la estupidez humana no sólo eran una parodia de ciertas formas de análisis sociológico, sino una reflexión llena de lucidez sobre la realidad de los daños que causa “el poder político, económico o burocrático” puesto en manos de los estúpidos. Leído hoy, cuando somos víctimas de la estupidez, repetidamente denunciada, de las políticas de austeridad, el texto de Cipolla cobra una inquietante actualidad.', '12.95', 3, 12, 'Fisico', 4, 'Tapa Blanda', 499, '978-8498925814', NULL, NULL, '../img/Libros/Ciencia/Las leyes fundamentales de la estupidez humana.jpg', 0),
(26, 'Bicicletas para la mente', 'La gran historia que transcurre entre la llegada del ordenador personal y la irrupción de la inteligencia artificial.\r\n\r\nA las puertas de un mundo dominado por la inteligencia artificial y las gafas de «realidad extendida», cabe preguntarse dónde empezó todo, cómo pasamos del pequeño garaje de Palo Alto en el que Hewlett y Packard revolucionaron la informática a un presente en el que no hay nada que pueda concebirse sin chips.\r\nEsta es la fascinante historia del paso de la vida analógica a la digital, una narración plagada de visionarios, creativos y genios que han cambiado nuestra vida cotidiana para siempre: el placer, el trabajo, las relaciones sociales o el aprendizaje. Nada queda ya fuera de nuestras pantallas.', '18.90', 3, 12, 'Fisico', 5, 'Tapa Blanda', 97, ' 978-8411002035', NULL, NULL, '../img/Libros/Ciencia/Bicicletas para la mente.jpg', 1),
(27, 'Bicicletas para la mente', 'La gran historia que transcurre entre la llegada del ordenador personal y la irrupción de la inteligencia artificial.\r\n\r\nA las puertas de un mundo dominado por la inteligencia artificial y las gafas de «realidad extendida», cabe preguntarse dónde empezó todo, cómo pasamos del pequeño garaje de Palo Alto en el que Hewlett y Packard revolucionaron la informática a un presente en el que no hay nada que pueda concebirse sin chips.\r\nEsta es la fascinante historia del paso de la vida analógica a la digital, una narración plagada de visionarios, creativos y genios que han cambiado nuestra vida cotidiana para siempre: el placer, el trabajo, las relaciones sociales o el aprendizaje. Nada queda ya fuera de nuestras pantallas.', '8.99', 3, 12, 'Digital', 2, 'Ebook', 496, ' 978-8411022035', NULL, NULL, '../img/Libros/Ciencia/Bicicletas para la mente.jpg', 0),
(28, 'El lenguaje secreto de los gatos', 'Descendientes de unos tímidos y solitarios gatos salvajes del norte de África, los gatos domésticos han conquistado los hogares de todo el mundo. Pero, ¿cómo han conseguido infiltrarse en nuestras casas y nuestros corazones para convencernos de mantenerlos calientes, alimentados y mimados? Fácil, simplemente aprendieron a hablar con nosotros.\r\n\r\nSarah Brown, reconocida especialista en el comportamiento de los gatos, nos revela en este encantador libro todos los secretos de la comunicación de los gatos y la base científica de su comportamiento.', '19.95', 3, 13, 'Fisico', 4, 'Tapa Blanda', 500, '978-8408277125', NULL, NULL, '../img/Libros/Ciencia/El lenguaje secreto de los gatos.jpg', 0),
(29, '¿Dónde están las llaves?', 'Los misterios de nuestra vida cotidiana resueltos por un neuropsicólogo.\r\n\r\nNuestra vida cotidiana está llena de situaciones que pueden tener una explicación neuropsicológica. Nos referimos a los olvidos involuntarios, los lapsus, las pasiones desbordadas, las fobias y manías e incluso las experiencias que se podrían calificar como «extrañas» (apariciones y alucinaciones). En este libro, Saúl Martínez-Horta ofrece una mirada científica para entender mejor cómo funciona nuestro cerebro.', '8.99', 3, 14, 'Digital', 4, 'Ebook', 100, '978-8408273486', NULL, NULL, '../img/Libros/Ciencia/Donde estan las llaves.jpg', 0),
(30, '321 curiosidades que todo el mundo debería conocer', 'Estas 321 curiosidades sorprendentes sobre animales son un maravilloso compendio de información, datos y sorpresas. Un recorrido por la asombrosa inteligencia, la capacidad de amar, las costumbres, el lenguaje y los lazos familiares de los animales que revela hechos tan asombrosos como que los gorilas construyen una nueva cama en el suelo cada noche o que el colibrí zunzuncito mide unos 5 cm y pesa tan solo 3 gr. O que los elefantes solo duermen 2 h al día y las ballenas jorobadas recorren cada año unos 25 000 km en busca de comida.\r\nMathilda Masters y la ilustradora Louize Perdieus son las creadoras de este variado y entretenido libro que nos recuerda que el conocimiento puede ser algo muy atractivo y divertido y que la lectura puede convertirse en una actividad adictiva.', '25.99', 3, 12, 'Fisico', 6, 'Tapa Dura', 299, '978-8408276722', NULL, NULL, '../img/Libros/Ciencia/321 curiosidades que todo el mundo debería conocer sobre los animales.jpg', 0),
(34, 'La huella de los mapas', 'Los mapas son mucho más que meras representaciones topográficas de un territorio. Son definiciones de nuestra visión del mundo. Nuestro mundo. Porque vivimos en un complejísimo escenario de experiencias, creencias y culturas que conforman las distintas maneras de entender la realidad del ser humano. Cada cultura, cada pueblo, cada civilización se definen a sí mismos a través de su relación con el espacio que los rodea y con el que les queda más lejos. Y esa definición se cristaliza en los mapas. No solo en los mapas que estamos acostumbrados a ver, sino también en representaciones cartográficas mucho más amplias, profundas y complejas.\r\nEsta no es una historia de la cartografía. Ni un libro sobre los mapas más importantes o espectaculares que se han elaborado. Ya se ha escrito mucho y bien al respecto. Lo que aquí encontrarás son evidencias de la importancia de los mapas en la idiosincrasia cultural y mental del ser humano. Tanto en el pasado como en el presente. Tendrás ocasión de comprobar el innegable peso que tienen en nuestra vida, pero también en el de culturas de todo el mundo, desde Australia hasta Colombia, pasando por el continente africano, Europa, Norteamérica y las islas del Pacífico.\r\nEste libro surge de la necesidad de ampliar nuestra concepción de lo cartográfico. Tiene como fin demostrar que los mapas, más allá de sus formas, tradiciones y métodos creativos, están presentes en todas las culturas, a lo largo y ancho del planeta. Que, en términos históricos, sociales, económicos y geopolíticos, estamos hechos de mapas.', '5.99', 3, 12, 'Bolsillo', 2, 'Tapa Dura', 299, '978-8408274605', NULL, NULL, '../img/Libros/Ciencia/La huella de los mapas.jpg', 1),
(35, 'Mi vida es química', 'Las personas tienen una idea preconcebida no solo de la química en sí, sino también de quienes se dedican a ella. «No pareces química», le dicen con frecuencia a Mai Thi Nguyen-Kim, una joven científica autora de este libro y muy popular en YouTube. Pero cuando ella bebe café, se cepilla los dientes o hace deporte, no puede dejar de pensar en los receptores de la adenosina, el fluoruro o las enzimas metabólicas.\r\n\r\nSalvo un par de excepciones, los científicos son vistos como criaturas desconocidas, encerradas en laboratorios y bibliotecas. En Mi vida como química, Mai Thi Nguyen-Kim desmonta esta imagen y comparte con humor y honestidad su día a día. ¿El objetivo? Demostrarnos que la química es realmente todo, desde las moléculas que intervienen en el sueño, el estrés y la temperatura de las cosas, hasta los procesos que participan en el consumo de alcohol, la vida sedentaria, el desorden, la limpieza… Es fascinante ver cómo vive alguien que se dedica a la química, y este libro es una invitación a descubrir el irresistible encanto que esconde esta ciencia.', '19.90', 3, 12, 'Fisico', 3, 'Tapa Blanda', 100, '978-8434432093', NULL, NULL, '../img/Libros/Ciencia/Mi vida es química.jpg', 0),
(36, 'Ortiga y hueso', 'Una historia de fantasía oscura y emocionante sobre la hermandad, las pruebas imposibles y el precio del poder, de la galardonada autora T. Kinsfisher.\r\n	\r\nDespués de años de ver a sus hermanas sufrir a manos de un príncipe maltratador, Marra —la tímida hermana menor, criada en un convento— se da cuenta por fin de que nadie vendrá a rescatarlas Nadie, excepto ella misma.\r\nUna poderosa bruja de tumbas le ofrece a Marra los medios para matar al príncipe, si primero es capaz de completar tres tareas imposibles. Pero, como es habitual en los cuentos de príncipes, brujas e hijas marginadas, lo imposible es sólo el principio.\r\nA la misión de Marra se unen la bruja de tumbas, una renuente hada madrina, un fornido ex caballero y una gallina poseída por un demonio. Juntos, los cinco pretenden ser la mano que se cierre alrededor de la garganta del príncipe y libere por fin a la familia de Marra y a su reino de su tirano gobernante.', '17.95', 4, 15, 'Fisico', 4, 'Tapa Blanda', 500, '978-8412669794', NULL, NULL, '../img/Libros/Fantasia/ortiga y hueso.jpg', 0),
(37, 'El ritmo de la guerra', 'El Ritmo de la Guerraes la esperada cuarta parte de la  decalogía «El Archivo de las Tormentas» y el libro que continúa la historia deEl camino de los reyes, Palabras radiantesyJuramentada.\r\n\r\nHay secretos que hemos guardado mucho tiempo. Vigilantes. Insomnes. Eternos. Y pronto dejarán de ser nuestros.\r\n\r\nLa Una que es Tres busca, sin saberlo, el alma capturada. El spren  aprisionado, olvidado hace mucho tiempo. ¿Puede liberar su propia alma a  tiempo de hallar el conocimiento que condena a todos los pueblos de Roshar?\r\n\r\nEl Soldado Caído acaricia y ama la lanza, incluso mientras el arma  hiende su propia carne. Camina siempre hacia delante, siempre hacia la  oscuridad, sin luz. No puede llevar consigo a nadie, salvo aquello que él mismo puede avivar.\r\n\r\nLa Hermana Derrumbada comprende sus errores y piensa que ella  misma es un error. Parece muy alejada de sus antepasados, pero no  comprende que son quienes la llevan a hombros. Hacia la victoria, y hacia ese silencio, el más importante de todos.\r\n\r\nY la Madre de Máquinas, la más crucial de todos ellos, danza con  mentirosos en un gran baile. Debe desenmascararlos, alcanzar sus  verdades ocultas y entregarlas al mundo. Tiene que reconocer que las peores mentiras son las que se cuenta a sí misma.\r\n\r\nSi lo hace, nuestros secretos por fin se convertirán en verdades.\r\n\r\nLa crítica ha dicho:\r\n«Me encantó este libro... ¿Qué más puedo decir?»\r\nPatrick Rothfuss sobreEl camino de los reyes', '34.99', 4, 17, 'Fisico', 2, 'Tapa Dura', 500, '978-8417347932', NULL, NULL, '../img/Libros/Fantasia/el ritmo de la guerra.jpg', 0),
(38, 'El imperio final', 'El imperio final inicia la saga «Nacidos de la Bruma  [Mistborn]», obra imprescindible del Cosmere, el universo destinado a  dar forma a la serie más extensa y fascinante jamás escrita en el ámbito de la fantasía épica.\r\n\r\nDel autor best seller delNew York Times.\r\n\r\nDurante mil años han caído cenizas del cielo. Durante mil años nada ha  florecido. Durante mil años los skaa han sido esclavizados y viven en la  miseria, sumidos en un miedo inevitable. Durante mil años el Lord  Legislador ha reinado con poder absoluto, dominando gracias al terror, a  sus poderes y a su inmortalidad, ayudado por «obligadores» e «inquisidores», junto a la poderosa magia de la alomancia.\r\n\r\nPero los nobles a menudo han tenido trato sexual con jóvenes skaa y,  aunque la ley lo prohíbe, algunos de sus bastardos han sobrevivido y  heredado los poderes alománticos: son los «nacidos de la bruma» (mistborn).\r\n\r\nAhora, Kelsier, el «superviviente», el único que ha logrado huir de los  Pozos de Hathsin, ha encontrado a Vin, una pobre chica skaa con mucha  suerte... Tal vez los dos, con el mejor equipo criminal jamás reunido,  unidos a la rebelión que los skaa intentan desde hace mil años, logren  cambiar el mundo y acabar con la atroz mano de hierro del Lord Legislador.\r\n\r\nPero, ¿qué pasa si el héroe de la profecía falla?\r\n\r\nDesde 2006, y en solo diez años, Brandon Sanderson se ha consolidado  como el gran renovador de la fantasía del siglo XXI y el autor del  género más prolífico del mundo. Ha logrado ganarse a ocho millones de  lectores, ser publicado en treinta países y convertirse en el heredero de todo un género.', '19.85', 4, 14, 'Fisico', 2, 'Tapa Blanda', 500, '978-8417347291', 'Nacidos de la bruma', 1, '../img/Libros/Fantasia/el imperio final.jpg', 0),
(39, 'El pozo de la ascension', 'El Pozo de la Ascensión es el segundo volumen de la saga  «Nacidos de la Bruma [Mistborn]», una obra iniciada conEl imperio final y  parte imprescindible del Cosmere, el universo destinado a  dar forma a la serie más extensa y fascinante jamás escrita en el ámbito de la fantasía épica.\r\n\r\nDurante mil años nada ha cambiado: han caído las cenizas, los skaa han  sido esclavizados y el Lord Legislador ha dominado el mundo. Pero lo  imposible ha sucedido. El Lord Legislador ha muerto. Sin embargo, vencer  y matarlo fue la parte sencilla. El verdadero desafío será sobrevivir a las consecuencias de su caída.\r\n\r\nTomar el poder tal vez resultó fácil, pero ¿qué ocurre después?, ¿cómo  se utiliza? La tarea de reconstruir el mundo, ahora que Kelsier no está,  ha quedado en manos de Vin. Y las brumas, desde que el Lord Legislador cayó, se han vuelto cada vez más impredecibles...\r\n\r\nA medida que el asedio se intensifica, la antigua leyenda del Pozo de la Ascensión ofrece un único rayo de esperanza.\r\n\r\nEn ese mundo de aventura épica, la estrategia política y religiosa debe  lidiar con los siempre misteriosos poderes de la alomancia...\r\n\r\nDesde 2006, y en solo diez años, Brandon Sanderson se ha consolidado  como el gran renovador de la fantasía del siglo XXI y el autor del  género más prolífico del mundo. Ha logrado ganarse a ocho millones de  lectores, ser publicado en treinta países y convertirse en el heredero de todo un género.', '19.89', 4, 14, 'Fisico', 2, 'Tapa Blanda', 100, '978-8466658904', 'Nacidos de la bruma', 2, '../img/Libros/Fantasia/el pozo de la ascension.jpg', 0),
(40, 'El heroe de las eras', 'El Héroe de las Eras es el tercer volumen de la saga «Nacidos  de la Bruma (Mistborn)». Una obra iniciada conEl imperio final y parte imprescindible del Cosmere, el universo destinado a dar forma a la serie más extensa y fascinante jamás escrita  en el ámbito de la fantasía épica.\r\n\r\nDurante mil años nada ha cambiado: han caído las cenizas, los skaa han  sido esclavizados y el Lord Legislador ha dominado el mundo. Kelsier, el  «superviviente», el único que ha logrado huir de los Pozos de Hathsin,  junto a Vin, una pobre chica skaa, se une a la rebelión. Y por fin lo  imposible sucede: por fin la revolución ha triunfado. Pero acabar con el  Lord Legislador es la parte sencilla. El verdadero desafío consistirá en  sobrevivir a las consecuencias de su caída... sin Kelsier.\r\n\r\nVin y el Rey Elend buscan en los últimos escondites de recursos del Lord  Legislador y, engañado, el Rey libera del Pozo de la Ascensión algo que  debería haber quedado oculto para siempre. Un enorme peligro acecha a la  humanidad, y la verdadera pregunta es si conseguirán detenerlo a tiempo.\r\n\r\nEnEl héroe de las eras se comprende el porqué de la niebla y las  cenizas, las tenebrosas acciones del Lord Legislador y la naturaleza del  Pozo de la Ascensión. Esta aventura lleva a la trilogía a un clímax dramático y sorprendente.\r\n\r\nDesde 2006, y en solo diez años, Brandon Sanderson se ha consolidado  como el gran renovador de la fantasía del siglo XXI y el autor del  género más prolífico del mundo. Ha logrado ganarse a ocho millones de  lectores, ser publicado en treinta países y convertirse en el heredero de todo un género.', '19.85', 4, 14, 'Fisico', 3, 'Tapa Blanda', 100, '978-8466658911', 'Nacidos de la bruma', 3, '../img/Libros/Fantasia/el heroe de las eras.jpg', 0),
(41, 'Aleacion de la ley', 'Aleación de ley es la secuela de la primera trilogía de la saga  «Nacidos de la Bruma [Mistborn]», una obra iniciada conEl imperio final y parte imprescindible del Cosmere, el universo destinado a dar  forma a la serie más extensa y fascinante jamás escrita en el ámbito de la fantasía épica.\r\n\r\nHan pasado trescientos años desde los acontecimientos narrados en la  primera trilogía de la saga, y Scadrial se encuentra ahora cerca de la  modernidad: ferrocarriles, canales, iluminación eléctrica y los primeros  rascacielos invaden el planeta. Aunque la ciencia y la tecnología están  alcanzando nuevos retos, la antigua magia de la alomancia continúa  desempeñando un papel fundamental. En una zona conocida como los Áridos,  existen herramientas cruciales para aquellos hombres y mujeres que  intentan establecer el orden y la justicia. Uno de estos hombres es Lord  Waxillium Ladrian, experto en metales y en el uso de la alomancia y la feruquimia.\r\n\r\nDespués de vivir veinte años en los Áridos, Wax se ha visto obligado,  por una tragedia familiar, a volver a la metrópolis de Elendel. Sin embargo, y a su pesar, deberá guardar las armas y asumir las  obligaciones que exige el hecho de estar rodeado de la clase noble. O al  menos eso cree, ya que aún no sabe que las mansiones y las elegantes  calles arboladas de la ciudad pueden ser incluso más peligrosas que las llanuras de los Aridos. Unskyline metálico de bruma, de ceniza y  vapor conquista el cielo amenazando a todos aquellos que viven y luchan debajo de él.\r\n\r\nDesde 2006, y en solo diez años, Brandon Sanderson se ha consolidado  como el gran renovador de la fantasía del siglo  XXI y el autor del  género más prolífico del mundo. Ha logrado ganarse a ocho millones de  lectores, ser publicado en treinta países  y convertirse en el heredero de todo un género.', '19.85', 4, 14, 'Fisico', 3, 'Tapa Blanda', 100, '978-8466658928', 'Nacidos de la bruma', 4, '../img/Libros/Fantasia/aleacion de la ley.jpg', 0),
(42, 'Princesa de los hielos', 'Existe un Reino una tierra fría e inhóspita, donde una joven princesa guarda un importante secreto. Ahora, alguien desea volver al tiempo de la antigua magia, y sólo Gunnar, el gran lobo blanco, puede defender a la princesa Nives, mostrando así su verdadera naturaleza.', '15.95', 4, 13, 'Fisico', 3, 'Tapa Dura', 500, '978-8408094432', 'Princesas del reino de la fantasia', 1, '../img/Libros/Fantasia/princesa de los hielos.jpg', 0),
(43, 'Princesa de los corales', 'En la antigua ciudad sumergida, la princesa Kalea guarda una estrofa de la Canción del Sueño, versos secretos que unen su destino al de sus hermanas, las otras princesas del Reino de la Fantasía. Un día, llega a la corte el misterioso Kaliq, y la estrofa desaparece, poniendo en peligro el Reino de los Corales.', '15.95', 4, 13, 'Fisico', 6, 'Tapa Dura', 499, '978-8408100119', 'Princesas del reino de la fantasia', 2, '../img/Libros/Fantasia/princesa de los corales.jpg', 0),
(44, 'Princesa del desierto', 'La ciudad de Rocadocre está en plena ebullición: ¡va a empezar el Mercado de las Arenas! Pero, de noche, las estrellas se ocultan en el cielo, y un viento inquieto agita el Desierto de los Susurros. Cuando la prima de la princesa Samah desaparece en la nada, los presagios se convierten en realidad: una terrible amenaza se cierne sobre el reino…', '15.95', 4, 13, 'Fisico', 2, 'Tapa Dura', 500, '978-8408102304', 'Princesas del reino de la fantasia', 3, '../img/Libros/Fantasia/princesa del desierto.jpg', 0),
(45, 'Princesa de los bosques', 'Tambores de guerra rompen el silencio del Bosque Viviente. Los fieros Nai-Lai se han rebelado contra la princesa Yara. Así comienza una asombrosa aventura en la que Yara va a necesitar todo su arrojo para defender el reino de un terrible enemigo.', '15.95', 4, 13, 'Fisico', 1, 'Tapa Dura', 467, '978-8408111504', 'Princesas del reino de la fantasia', 4, '../img/Libros/Fantasia/princesa de los bosques.jpg', 0),
(46, 'Princesa de la oscuridad', 'En el corazón del Reino de la Oscuridad, en un laberinto de grutas excavadas en la roca negra, la vida de la princesa Diamante transcurre aparentemente tranquila. Pero la calma que envuelve el palacio de Tierranegra se ve amenazada por los inquietantes planes de quien desea acabar con la paz de los Cinco Reinos.', '15.95', 4, 13, 'Fisico', 6, 'Tapa Dura', 500, '978-8408013587', 'Princesas del reino de la fantasia', 5, '../img/Libros/Fantasia/princesa de la oscuridad.jpg', 0),
(47, 'El asesino de la montaña', 'La inspectora Leonore Asker es la mejor candidata para dirigir el Departamento de Crímenes Violentos. Pero, cuando la hija de una familia adinerada de Suecia desaparece, sus superiores la apartan del caso y la hacen responsable de la Unidad de Casos Perdidos, un departamento olvidado de dudosa reputación. Humillada, en su nuevo puesto Leo se verá envuelta en una investigación trivial: alguien está alterando las escenas de una gran maqueta ferroviaria. Sin embargo, después de que aparezca en la maqueta una figura idéntica a la de la chica desaparecida, Asker comprende que se enfrentan a un asesino despiadado y solo hay una persona que puede ayudarla: Martin Hill, profesor de arquitectura y experto en exploración urbana.', '21.90', 5, 16, 'Fisico', 3, 'Tapa Blanda', 120, '978-8408284161', NULL, NULL, '../img/Libros/Thriller/el asesino de la montaña.jpg', 0),
(48, 'La asesina inocente', 'México, 1928. Mientras el país despierta con la noticia del atentado contra el presidente Álvaro Obregón, María Teresa Landa solo tiene ojos para el anuncio que destaca la prensa sobre el concurso Señorita México. Impetuosa y descontenta con el papel que esperan de ella, la joven encuentra en el certamen la plataforma perfecta para mostrarle al mundo su valía. La belleza y el desparpajo de la aspirante cautivan al jurado, que decide coronarla por unanimidad. La fama resulta embriagadora, pero tras fracasar en su intento de escalar a Miss Universo, Teresa contrae nupcias con un antiguo pretendiente. Tiempo después aparece en el periódico una nota en la que se acusa a la Señorita México de bigamia. Ella descubre entonces que su marido tiene un pasado desconocido… De los pormenores de este escándalo, y de la tragedia que se suscitará, dará cuenta la protagonista desde la cárcel en una novela cargada de tensión, sensualidad y drama. ¿El mundo está listo para escuchar su versión?', '9.49', 5, 17, 'Digital', 1, 'Ebook', 94, ' 978-6073900539', NULL, NULL, '../img/Libros/Thriller/La asesina inocente.jpg', 1),
(49, 'Más allá del espejo', 'Algo malsano flota todavía en el interior de la Casa Grady. En esa tenebrosa casa, perdida en las lindes de un denso bosque y de cuyas paredes cuelgan tal vez demasiados espejos, ocurrieron hechos atroces. Allí su dueño, John Grady, asesinó a varios niños tras secuestrarlos. Años después, el padre de una de las víctimas, que compró la casa para que nadie olvidara los crímenes cometidos en ella, tiene indicios de que una niña desconocida podría estar en peligro. Y acude a Charlie Parker para que evite una tragedia. El detective, que no duda en aceptar el caso, va en busca de todos los que conocieron a John Grady. Quizá logre así descubrir qué secretos oculta todavía la casa, aunque eso suponga atraerse la ira de esos seres espectrales que acuden siempre a la llamada del Mal.', '6.95', 5, 16, 'Bolsillo', 3, 'Tapa Dura', 100, '978-848383-3698', NULL, NULL, '../img/Libros/Thriller/Más allá del espejo.jpg', 0),
(50, 'Los hombres de la Guadaña', 'Cuando parecía que la vida de Louis y Angel, los amigos del ex policía Charlie Parker, había alcanzado cierta paz y estabilidad, surgen de pronto sombras de su turbio pasado deseosas de saldar cuentas pendientes. No cabe duda de que alguien quiere atentar contra sus vidas. Y, en esta ocasión, prefieren dejar al margen a Parker, que ha perdido su licencia de investigador privado y el permiso de armas y se gana la vida de camarero en un bar. A Louis no le queda más remedio que volver a ponerse en contacto con su viejo mentor, el enigmático Gabriel.... A los quince años, Louis estaba al borde del abismo: había vengado la muerte de su madre y, acusado de asesinato, se encontraba en pleno interrogatorio cuando apareció Gabriel y le ofreció una vía de escape: formar parte de los temibles Hombres de la Guadaña. Ahora, Louis tendrá que librar junto a Angel una encarnizada lucha a vida o muerte.', '20.00', 5, 1, 'Fisico', 5, 'Tapa Blanda', 500, ' 978-8483831342', NULL, NULL, '../img/Libros/Thriller/Los hombres de la Guadaña.jpg', 0),
(51, 'Los hombres de la Guadaña', 'Cuando parecía que la vida de Louis y Angel, los amigos del ex policía Charlie Parker, había alcanzado cierta paz y estabilidad, surgen de pronto sombras de su turbio pasado deseosas de saldar cuentas pendientes. No cabe duda de que alguien quiere atentar contra sus vidas. Y, en esta ocasión, prefieren dejar al margen a Parker, que ha perdido su licencia de investigador privado y el permiso de armas y se gana la vida de camarero en un bar. A Louis no le queda más remedio que volver a ponerse en contacto con su viejo mentor, el enigmático Gabriel.... A los quince años, Louis estaba al borde del abismo: había vengado la muerte de su madre y, acusado de asesinato, se encontraba en pleno interrogatorio cuando apareció Gabriel y le ofreció una vía de escape: formar parte de los temibles Hombres de la Guadaña. Ahora, Louis tendrá que librar junto a Angel una encarnizada lucha a vida o muerte.', '9.95', 5, 1, 'Bolsillo', 2, 'Tapa Dura', 99, ' 978-8683831342', NULL, NULL, '../img/Libros/Thriller/Los hombres de la Guadaña.jpg', 0);
INSERT INTO `libro` (`IdLibro`, `Nombre`, `Descripcion`, `Precio`, `Genero`, `Autor`, `Formato`, `Edicion`, `Tipo`, `Stock`, `ISBN`, `Saga`, `Num_Saga`, `Imagen`, `Populares`) VALUES
(52, 'El ángel negro', 'En este nuevo y estremecedor caso, el detective Charlie Parker se enfrenta a un rompecabezas cuyas piezas parecen difíciles de encajar: una prostituta que desaparece en un sórdido barrio neoyorquino; una colección de misteriosas cajas de plata de origen medieval, dispersas por el mundo, que guardan en su interior un fragmento de un extraño mapa; una subasta de objetos arcanos que suscita una gran expectación en Boston; la profanación de varias iglesias en Francia y la República Checa... Parker debe resolver, además, un conflicto de lealtades. Por un lado, su amigo Louis, antiguo asesino a sueldo, necesita ayuda en la búsqueda de su prima, la prostituta desaparecida en Nueva York; por otro, su mujer, Rachel, ya no resiste la tensión ni la continua amenaza que implica la convivencia con él. Y esta vez el peligro es mayor que nunca, porque Charlie tiene que vérselas con seres dudosamente humanos, seres surgidos de un pasado remoto, la encarnación misma del mal: el ángel', '35.00', 5, 8, 'Fisico', 6, 'Especial', 100, ' 978-848383-0024', NULL, NULL, '../img/Libros/Thriller/El ángel negro.jpg', 0),
(53, 'Aún siguen aquí', 'Un día de junio de 2019 en Londres, a la orilla del río Támesis, aparece una bolsa llena de huesos; son los restos de una mujer que murió años atrás asesinada de un golpe en la cabeza.\r\nEn la bolsa se hallan también las semillas de un árbol poco común que llevan al inspector de policía Samuel Owusu, responsable del caso, a una mansión en Chelsea. Mansión en la que, treinta años antes, fueron hallados tres muertos y un bebé abandonado.\r\nSolo revisitar el pasado conseguirá recomponer las piezas de este rompecabezas familiar y sacar a la luz secretos que quedaron enterrados mucho tiempo atrás.', '18.95', 5, 13, 'Fisico', 2, 'Tapa Blanda', 298, '978-8408281672', NULL, NULL, '../img/Libros/Thriller/Aún siguen aquí.jpg', 0),
(54, 'Los crímenes de Chopin', 'En varias casas de Sevilla se han producido una serie de robos que preocupan a toda la ciudad. El ladrón, al que apodan «Chopin» porque siempre deja una partitura del famoso compositor para firmar el robo, se lleva dinero, joyas y diferentes artículos de valor. Una noche aparece un cadáver en el salón de una de esas viviendas y la tensión aumenta.\r\nNikolai Olejnik es un joven polaco que llegó a España con su abuelo hace varios años. Desde que este murió, está solo y sobrevive a base de delinquir. Fue un niño prodigio en su país y su mayor pasión es tocar el piano. De repente, todo se complica y se convierte en el principal sospechoso de un asesinato. Niko acude al despacho de Celia Mayo, detective privado, a pedirle ayuda y allí conoce a Triana, la hija de Celia. La joven enseguida llama su atención, aunque no es el mejor momento para enamorarse.\r\nBlanca Sanz apenas lleva cinco meses trabajando en el periódico El Guadalquivir cuando recibe una extraña llamada en la que le filtran datos sobre el caso Chopin, que nadie más conoce. Desde ese momento se obsesiona con todo lo relacionado con la investigación e intenta averiguar quién está detrás de aquellos robos.\r\n\r\nIntriga, misterio, amor y crímenes son la base de esta novela ambientada en las enigmáticas calles de Sevilla, en la que el lector formará parte de la investigación. ¿Conseguirás adivinar quién es el culpable?', '18.90', 5, 15, 'Fisico', 3, 'Tapa Blanda', 500, '978-8408257417', 'Chopin', 1, '../img/Libros/Thriller/Los crímenes de Chopin.jpg', 0),
(55, 'La última melodía de Chopin', 'La detective privado Celia Mayo ha desaparecido. Triana y Niko todavía tienen esperanza de encontrarla, aunque saben que las posibilidades son cada vez más escasas. Un día, los jóvenes reciben una llamada anónima que les asegura que está viva. ¿Será esta vez cierto o se trata de una broma de mal gusto?\r\n\r\nMientras tanto, Blanca se recupera de las lesiones que sufrió tras el accidente de helicóptero. Su compañera periodista Luna González está investigando y no parará hasta descubrir lo que ocurrió, aunque eso la ponga en riesgo.\r\n\r\nSevilla se ha convertido en una ciudad peligrosa en la que nadie parece a salvo. Los misterios y las muertes sospechosas se van produciendo y la policía no logra encontrar a los culpables.\r\n\r\n¿Conseguirán averiguar la verdad de esos sucesos?', '18.90', 5, 15, 'Fisico', 3, 'Tapa Blanda', 100, '978-8408271710', 'Chopin', 2, '../img/Libros/Thriller/La última melodía de Chopin.jpg', 0),
(56, 'Los crímenes de Chopin', 'En varias casas de Sevilla se han producido una serie de robos que preocupan a toda la ciudad. El ladrón, al que apodan «Chopin» porque siempre deja una partitura del famoso compositor para firmar el robo, se lleva dinero, joyas y diferentes artículos de valor. Una noche aparece un cadáver en el salón de una de esas viviendas y la tensión aumenta.\r\n\r\nNikolai Olejnik es un joven polaco que llegó a España con su abuelo hace varios años. Desde que este murió, está solo y sobrevive a base de delinquir. Fue un niño prodigio en su país y su mayor pasión es tocar el piano. De repente, todo se complica y se convierte en el principal sospechoso de un asesinato. Niko acude al despacho de Celia Mayo, detective privado, a pedirle ayuda y allí conoce a Triana, la hija de Celia. La joven enseguida llama su atención, aunque no es el mejor momento para enamorarse.\r\n\r\nBlanca Sanz apenas lleva cinco meses trabajando en el periódico El Guadalquivir cuando recibe una extraña llamada en la que le filtran datos sobre el caso Chopin, que nadie más conoce. Desde ese momento se obsesiona con todo lo relacionado con la investigación e intenta averiguar quién está detrás de aquellos robos.\r\n\r\n \r\n\r\nIntriga, misterio, amor y crímenes son la base de esta novela ambientada en las enigmáticas calles de Sevilla, en la que el lector formará parte de la investigación. ¿Conseguirás adivinar quién es el culpable?', '8.99', 5, 15, 'Digital', 1, 'Ebook', 85, '978-8408257517', 'Chopin', 1, '../img/Libros/Thriller/Los crímenes de Chopin.jpg', 0),
(57, 'La última melodía de Chopin', 'La detective privado Celia Mayo ha desaparecido. Triana y Niko todavía tienen esperanza de encontrarla, aunque saben que las posibilidades son cada vez más escasas. Un día, los jóvenes reciben una llamada anónima que les asegura que está viva. ¿Será esta vez cierto o se trata de una broma de mal gusto?\r\n\r\nMientras tanto, Blanca se recupera de las lesiones que sufrió tras el accidente de helicóptero. Su compañera periodista Luna González está investigando y no parará hasta descubrir lo que ocurrió, aunque eso la ponga en riesgo.\r\n\r\nSevilla se ha convertido en una ciudad peligrosa en la que nadie parece a salvo. Los misterios y las muertes sospechosas se van produciendo y la policía no logra encontrar a los culpables.\r\n\r\n¿Conseguirán averiguar la verdad de esos sucesos?', '8.99', 5, 15, 'Digital', 1, 'Ebook', 100, '978-8908271710', 'Chopin', 2, '../img/Libros/Thriller/La última melodía de Chopin.jpg', 0),
(58, 'Katanazo al amor romántico', '¿Tú también estabas esperando a que Lola Vendetta desenvainara la katana de nuevo? Atiende a esto:\r\nResulta que nuestra querida protagonista, en pleno camino para encontrarse a sí misma tras un cambio personal enorme, una separación y, como guinda del pastel, una pandemia mundial, ha topado con un gran monstruo de su pasado que no le permite conectar con ella misma. Parece que nuestra protagonista vivió una historia de abuso que todavía no ha contado. Algo que ha cerrado bajo llave, que no ha contado jamás y que la ha ido erosionando.\r\nEsa historia la tiene detenida en el tiempo, sin poder evolucionar y no podrá recuperarse a sí misma sin desentrañar todo el dolor que se ha acumulado en su pasado. Tendrá que aprender nuevas herramientas y, quizás, volver a empuñar las antiguas. No sé si me explico...', '16.95', 6, 1, 'Fisico', 2, 'Tapa Blanda', 496, '978-8411403719', NULL, NULL, '../img/Libros/Comic y Manga/Katanazo al amor romántico.jpg', 1),
(59, 'Marvel. Superhéroes unidos', '¡Un recopilatorio esencial para los fans de Marvel!\r\n\r\nEmbárcate en este emocionante recopilatorio de historias de superhéroes, en el que podrás defender las calles de Nueva York junto a Spider-Man, presenciar los enfrentamientos más épicos de los Vengadores y acompañar a los Guardianes de la Galaxia en sus emocionantes peripecias intergalácticas.\r\nCon más de 50 historias increíbles, este libro te transportará a un universo lleno de acción y aventuras sin límites. Además, encontrarás fichas con información detallada sobre los superhéroes más emblemáticos y, por supuesto, algún que otro supervillano que desafiará su valentía.', '24.95', 6, 11, 'Fisico', 6, 'Tapa Dura', 500, '978-8418610-530', NULL, NULL, '../img/Libros/Comic y Manga/Marvel. Superhéroes unidos.jpg', 0),
(60, 'My Hero Academia Nº1', 'Estamos en un mundo donde abundan los superhéroes (y los supervillanos). Los mejores humanos son entrenados en la Academia de Héroes para optimizar sus poderes.\r\n\r\nEntre la minoría normal, sin poder alguno, aparece Izuku Midoriya, dispuesto a ser una excepción y formarse en la Academia.', '8.00', 6, 8, 'Fisico', 3, 'Tapa Blanda', 900, '978-8416693504', 'My Hero Academia', 1, '../img/Libros/Comic y Manga/My Hero Academia1.jpg', 0),
(61, 'My Hero Academia Nº2', '¡Bienvenidos a la Academia de Héroes!\r\n\r\nEstamos en un mundo donde abundan los superhéroes (y los supervillanos). Los mejores humanos son entrenados en la Academia de Héroes para optimizar sus poderes. Entre la minoria normal, sin poder alguno, aparece Izuku Midoriya, dispuesto a ser una excepción y formarse en la Academia para convertirse en un héroe.', '8.00', 6, 8, 'Fisico', 3, 'Tapa Blanda', 499, '978-8416693511', 'My Hero Academia', 2, '../img/Libros/Comic y Manga/My Hero Academia2.jpg', 0),
(62, 'My Hero Academia Nº 3', 'Las clases han empezado, estás preparado?\r\n\r\n¡Me da igual que sean de la Alianza de villanos o qué, pero han venido a matar a All Might! ¿Que Deku está en un aprieto? ¡Bah! ¿¡Pero qué se han creído todos!? ¡Aplastaré a todos los que me estorben! ¡Plus ultra (más allá)!', '8.00', 6, 8, 'Fisico', 4, 'Tapa Blanda', 500, '978-8416816613', 'My Hero Academia', 3, '../img/Libros/Comic y Manga/My Hero Academia3.jpg', 0),
(63, 'SuperLopez. Sueños Frikis', 'La última aventura de Superlópez transcurre en el mundo de «espada y brujería». Última aventura de Superlópez, el personaje más popular de Jan, que comenzó su andadura en 1973. Todo llega a su final, pero nos queda un legado de 87 álbumes que son historia del cómic de nuestro país. La fantasía más épica de Superlópez entre magos, castillos, trolls, dragones y toda la temática propia del mundo de «espada y brujería».Superlópez se tropieza con Mayra, una joven universitaria que sufre el acoso de un grupo de compañeros con un líder, Roland, de corte machista. Mayra sueña con unas duras situaciones, de la mano de un Superlópez en el papel de Mago, dentro de un universo de espada y brujería, que le enseñan a afrontar los problemas con decisión.', '15.90', 6, 16, 'Bolsillo', 3, 'Tapa Blanda', 100, '978-8402425331', NULL, NULL, '../img/Libros/Comic y Manga/SuperLopez. Sueños Frikis.jpg', 0),
(64, 'Lazarus', 'FOREVER CARLYLE ERA EL LAZARUS DE LA FAMILIA CARLYLE HASTA AHORA\r\n\r\nCuando Forever descubrió la verdad sobre sus orígenes, se pusieron en marcha una serie de acontecimientos que parecían conducir inexorablemente a la separación definitiva entre ella y su familia. Además, la alianza secreta de Forever con su hermana JOHANNA iba a alterar para siempre los planes de su padre, Malcolm, mientras la Guerra del Cónclave sigue arrasando el mundo.\r\nMientras las hermanas ponen en marcha un plan para derrotar al principal enemigo y antiguo aliado de los Carlyle, Jakob Hock, los esqueletos de su familia empiezan a salir.\r\n\r\nPero antes de que Forever pueda asestar su golpe mortal, debe liberar a su hermana menor, Ocho, la octava Forever Carlyle genéticamente modificada y la siguiente iteración del programa Lazarus de la Familia, o el ciclo de violencia no acabará nunca.', '5.50', 6, 6, 'Digital', 1, 'Ebook', 476, ' 978-8467963090', NULL, NULL, '../img/Libros/Comic y Manga/Lazarus.jpg\"', 0),
(65, 'DEATH NOTE BLACK EDITION', 'Death Note supuso toda una revolución en el manga: el protagonista, tras encontrar un objeto mágico de inmenso poder, lo utiliza no para hacer el bien sino para convertirse en el gobernante supremo del mundo. Esta historia atípica, un verdadero thriller en viñetas, es un clásico moderno del manga, y como tal, ¡merece una edición a su altura! De los autores de BAKUMAN.', '30.99', 6, 10, 'Fisico', 1, 'Especial', 49, ' 978-8467963045', NULL, NULL, '../img/Libros/Comic y Manga/DEATH NOTE BLACK EDITION.jpg', 0),
(66, 'Cardcaptor Sakura 1', 'SAKURA NO ES LA ÚNICA QUE BUSCA LAS CARTAS DE CLOW... Cerberos, el guardián de las cartas de Clow, le encomienda a Sakura Kinomoto la tarea de reunirlas de nuevo. Si ya de por sí era una tarea complicada, ¡la llegada de Syaoran Li la dificultará aún más! Y parece ser que no solo será su rival con las cartas, sino también en el amor... ¡Por fin en España la edición definitiva de este clásico moderno del manga!!', '10.90', 6, 13, 'Fisico', 3, 'Tapa Blanda', 500, '978-8467963038', 'Cardcaptor Sakura', 1, '../img/Libros/Comic y Manga/CARDCAPTOR SAKURA1.jpg', 0),
(67, 'Cardcaptor Sakura 2', 'SAKURA NO ES LA ÚNICA QUE BUSCA LAS CARTAS DE CLOW... Cerberos, el guardián de las cartas de Clow, le encomienda a Sakura Kinomoto la tarea de reunirlas de nuevo. Si ya de por sí era una tarea complicada, ¡la llegada de Syaoran Li la dificultará aún más! Y parece ser que no solo será su rival con las cartas, sino también en el amor... ¡Por fin en España la edición definitiva de este clásico moderno del manga!!', '10.90', 6, 13, 'Fisico', 2, 'Tapa Blanda', 500, '978-8467963021', 'Cardcaptor Sakura', 2, '../img/Libros/Comic y Manga/CARDCAPTOR SAKURA2.jpg', 0),
(68, 'Jujutsu Kaisen', '¡LLEGA JUJUTSU KAISEN, EL SHÔNEN QUE ESTÁ CAUSANDO FUROR EN JAPÓN! Yûji Itadori es un estudiante con unas habilidades físicas excepcionales.odos los días, como rutina, va al hospital a visitar su abuelo enfermo y decide apuntarse al club de ocultismoel instituto para no dar un palo al agua... Sin embargo, unuen día el sello del talismán que se hallaba escondido en sunstituto se rompe, y comienzan a aparecer unos monstruos.nte este giro de los acontecimientos, Itadori decide adentrarsen el instituto para salvar a sus compañeros. ¿Qué leeparará el destino?', '9.00', 6, 17, 'Fisico', 4, 'Tapa Blanda', 120, ' 978-8467961119', NULL, NULL, '../img/Libros/Comic y Manga/Jujutsu Kaisen.jpg', 0),
(69, 'Calma tu puta cabeza', 'Un método provocador que ha conquistado a más de 5 millones de lectores para encontrar de una vez por todas la felicidad superando el estrés y la ansiedad.\r\n\r\nHaz que tu cerebro trabaje a tu favor, no en tu contra, y encuentra de una vez por todas la felicidad.\r\n\r\n \r\nNuestros cerebros hacen todo lo posible por ayudarnos, pero a veces pueden comportarse como unos verdaderos imbéciles. Se empeñan en atraparnos, iniciando una discusión estéril, convirtiéndonos en adictos o encerrándonos en nosotros mismos. Y, por mucho que les pedimos que dejen de hacerlo, parece que tienen voluntad propia. Pues bien, para eso está este libro.\r\n\r\n \r\nCon humor, paciencia y algunas palabrotas, la doctora Faith G. Harper comparte sus conocimientos sobre la ciencia que explica lo que sucede dentro de nuestro cerebro y nos ayuda a reentrenarlo para que este responda a la vida cotidiana sin incendiarlo todo a su paso. Si estás trabajando para lidiar con el estrés, la ansiedad, la depresión y los viejos traumas o si, sencillamente, quieres ser capaz de responder de manera más mesurada y relajada a ciertas situaciones, este libro puede ayudarte a juntar las piezas y a recuperar tu vida y tu cabeza.', '17.90', 7, 6, 'Fisico', 3, 'Tapa Dura', 500, '978-8419812223', NULL, NULL, '../img/Libros/Autoayuda y Espiritualidad/Calma tu pta cabeza.jpg\"', 0),
(70, 'Pensar bien, sentirse bien', 'Un clásico que ha cambiado la vida a miles de personas.\r\n\r\nSi bien es cierto que la mente es la causa de nuestro sufrimiento, también lo es que somos capaces de revertir el proceso mental negativo. La mente humana no es exacta ni infalible a la hora de procesar la información, pero, afortunadamente, tenemos la facultad de darnos cuenta de nuestros errores y desaprender lo que aprendimos.\r\n\r\n \r\nWalter Riso nos ofrece en este libro una propuesta seria y fundamentada para empezar a pensar en uno mismo de una manera más racional y saludable, y lograr el desarrollo pleno de nuestro potencial humano.\r\n\r\n \r\n«Walter Riso es un divulgador de primer orden que, en este libro, clarifica con sencillez los procesos de la mente que causan el sufrimiento inútil.» Francesc Miralles', '7.95', 7, 14, 'Digital', 3, 'Ebook', 99, '978-8408282884', NULL, NULL, '../img/Libros/Autoayuda y Espiritualidad/Pensar bien, sentirse bien.jpg', 0),
(71, 'Por si las voces vuelven', 'Un sorprendente testimonio sobre la locura. Un relato en primera persona sobre lo que supone perderse y tener que reconstruirse desde cero.\r\n\r\n  \r\nHace unos años me rompí por completo. Tanto como para que tuvieran que atarme a la cama de un hospital psiquiátrico para evitar que pudiera hacerme daño.\r\n\r\n \r\nNo tengo ni idea de cuándo empezó a formarse mi locura.\r\n\r\n \r\nA lo mejor nací genéticamente predispuesto.\r\n\r\n \r\nA lo mejor fui macerando una depresión al callarme ciertas cosas por no preocupar a los demás.\r\n\r\n \r\nO a lo mejor simplemente hay cerebros que de la noche a la mañana hacen crec y se acabó.\r\n\r\n \r\nCuando cuentas abiertamente que se te ha pirado la cabeza la gente enseguida le pone el sello de tabú. Aunque este libro lo he escrito para mí, por si las voces vuelven, es para cualquiera que haya pasado o esté pasando por algo parecido, y así romper de una vez por todas el estigma de las enfermedades mentales. Pero si simplemente te apetece jugar a ver el mundo como yo lo vi mientras perdí el contacto con la realidad, este libro también es para ti.\r\n\r\n \r\nSi escuchas bien las voces, descubrirás cosas fascinantes como esta:\r\n\r\n \r\nNO NECESITAS LLEGAR A TOCAR FONDO PARA RECONSTRUIRTE DESDE CERO.\r\n\r\n \r\n¿Empezamos?\r\n\r\n  \r\n«Crudo, directo, valiente. Muy muy recomendable.» Ana Pastor.\r\n\r\n \r\n«Creo firmemente que todo el mundo debería leer este libro. Tiene tanta verdad y es tan arrollador que te atrapa desde la primera página hasta la última.» Cristina Pedroche.\r\n\r\n \r\n«Por si las voces vuelven, mejor leer a Ángel Martín.» Alejandro Sanz.\r\n\r\n \r\n«Es un viaje al fondo de la mente, de una mente que ahora conozco y antes desconocía. Mi más profunda admiración.» Miki Nadal.\r\n\r\n \r\n«Te sientes reconocido en muchos pasajes. Un libro que te sorprenderá para bien.» Carles Francino, La ventana.\r\n\r\n \r\n«Clarividencia, control, omnisciencia, hablar con muertos, descifrar el universo? Leyendo su libro casi dan ganas de estar loco.» Luz Sánchez-Mellado, El País.\r\n\r\n \r\n«Un relato brutalmente descarnado, emotivo, aterrador y a la vez desternillante sobre la locura.» Javier Gallego Crudo.\r\n\r\n \r\n«Un relato en primera persona y sin dramatismo con un poso más de ayudar a alguien que esté pasando por su situación que de crear un relato amarillista sobre las enfermedades mentales. El último bestseller de 2021.» Paula Corroto, El Confidencial.', '7.95', 7, 15, 'Bolsillo', 2, 'Tapa Blanda', 117, '978-8408282907', NULL, NULL, '../img/Libros/Autoayuda y Espiritualidad/Por si las voces vuelven.jpg', 0),
(72, '12 rules for life (edición en inglés)', 'he #1 Sunday Times bestseller from \'the most influential public intellectual in the Western world right now\' (New York Times) - now in paperback.\r\n\r\nHow should we live properly in a world of chaos and uncertainty?\r\n\r\nJordan Peterson has helped millions of people, young and old, men and women, aim at a life of responsibility and meaning. Now he can help you.\r\n\r\nDrawing on his own work as a clinical psychologist and on lessons from humanity\'s oldest myths and stories, Peterson offers twelve profound and realistic principles to live by. After all, as he reminds us, we each have a vital role to play in the unfolding destiny of the world.\r\n\r\nDeep, rewarding and enlightening, 12 Rules for Life is a lifeboat built solidly for stormy seas: ancient wisdom applied to our contemporary problems.', '15.90', 7, 11, 'Fisico', 2, 'Tapa Blanda', 96, '978-0141988511', NULL, NULL, '../img/Libros/Autoayuda y Espiritualidad/12 rules for life.jpg', 0),
(73, 'Cuentos de risa para leer sin prisa', '¿Qué pasa si mezclas un príncipe feísimo, un gato electrónico, una huelga en un museo, una casa caracol, un rey Midas de pacotilla y una historia muy extraña? Pues una colección de desternillantes cuentos al más puro estilo de Juan Muñoz, creador de personajes como el pirata Garrapata y fray Perico y su borrico.', '12.50', 8, 17, 'Fisico', 3, 'Tapa Dura', 500, '978-8411820011', NULL, NULL, '../img/Libros/Infantiles/Cuentos de risa para leer sin prisa.jpg', 0),
(74, 'El Diario Mágico de Anna Kadabra ', '¡Atención, aprendiz! Tienes entre las manos mi Diario Mágico… y absolutamente secreto. Ábrelo en un lugar seguro si quieres descubrir mis hechizos y pociones más disparatados, además de un montón de juegos, chistes, recetas, manualidades e historias del Club de la Luna Llena. Pero ten mucho cuidado…\r\n\r\n¡Que no caiga en manos de los Cazabrujas!', '17.95', 8, 16, 'Fisico', 3, 'Tapa Dura', 500, '978-8408249160', NULL, NULL, '../img/Libros/Infantiles/diario magico de anna kadabra.png', 0),
(75, 'Nos tratamos bien', 'Un nuevo libro Lucía Serrano, autora súper ventas, sobre la amistad, el respeto y la importancia de tratarnos bien. Eres una persona única en el mundo. Las niñas y los niños de tu clase también lo son. Puede que te guste algo y que a otra persona no le guste nada. Hay quienes cantan muy bien. Y quienes son increíbles leyendo en voz alta, o corriendo muy rápido¡Somos diferentes! Pero ¿sabes qué tenemos en común? Que a todas las personas nos gusta que nos traten bien. Y para ello hay ciertas cosas que debemos saber. Con este libro aprenderás que TRATARNOS BIEN es la norma más importante del planeta Tierra.', '14.95', 8, 16, 'Fisico', 1, 'Tapa Dura', 300, '978-8448865207', NULL, NULL, '../img/Libros/Infantiles/Nos tratamos bien.jpg', 0),
(76, 'Bluey. Abuelitas', 'Disfruta de las sorprendentes y divertidas aventuras de BLUEY, la serie de animación más vista del mundo en Disney+ que ha cautivado a todas las familias. ¡Qué guay es ser una abuela! Blue y Bingo se lo pasan en grande jugando a las abuelitas. Se echan una cabezadita, se resbalan ¡y hacen el baile del hilo dental! Pero ¿las abuelas pueden hacer el baile del hilo dental? Bluey cree que no, pero Bingo cree que sí. Solo hay una manera de averiguarlo: llamar a la abuela Nana y preguntarle. Diviértete con Bluey, Bingo y la Nana en una nueva sorprendente historia de la serie de televisión favorita de los más pequeños y que ha enamorado a todas las familias. Un cuento entretenido e ideal para que los niños y niñas a partir de 4 años no se aburran.*Los libros de Bluey, la serie de animación ganadora de un Emmy©, engancha a los pequeños, emociona a los mayores y trasmite valores positivos para toda la familia.*Lee, piértete y aprende la importancia del juego en familia, de saber escuchar y de ir todos a una. *Repleto de ilustraciones a color, este libro es la lectura perfecta para los fans de la aclamada serie de televisión que ya triunfa en todo el mundo. *Leer alimenta la imaginación y la creatividad, favorece la concentración y ayuda a mejorar algunas habilidades sociales como la empatía.La crítica ha dicho:«Entrego mis armas ante Bluey. La mejor serie para preescolar que me he encontrado en mucho tiempo».El Hematocrítico «Bluey, la serie de apariencia infantil que engancha a los adultos».El Mundo «El culto a Bluey: cómo un dibujo animado infantil se ha convertido en la biblia de la paternidad moderna».The Guardian«Los libros de Bluey son historias igual de imaginativas, vibrantes, tiernas y pedagógicas como las que podemos ver en televisión».Silvia Díaz, Bebés y más', '8.95', 8, 6, 'Fisico', 3, 'Tapa Dura', 300, '978-8448865108', NULL, NULL, '../img/Libros/Infantiles/bluey abuelitas.png', 0),
(77, 'Princesas. Viste a las princesas con imanes', 'Las Princesas Disney tienen un vestido para cada ocasión. Vístelas con la ropa adecuada según el escenario o inventa nuevos looks dejando volar tu imaginación. Con las piezas imantadas, podrás vestirlas una y otra vez.', '11.95', 8, 15, 'Fisico', 2, 'Tapa Dura', 500, '978-8418335952', NULL, NULL, '../img/Libros/Infantiles/Princesas. Viste a las princesas con imanes.jpg', 0),
(78, 'Las Ratitas', 'Continúan las aventuras de Las Ratitas, el canal infantil más seguido de YouTubeClaudia y Gisele empiezan las vacaciones de Navidad. ¡Qué ilusión! Una tarde van al circo con sus amigos, pero se llevan una sorpresa desagradable: ¡hay animales enjaulados! ¡Y todos están muy tristes! Las Ratitas y sus amigos no entienden por qué los animales tienen que trabajar en vez de estar en la naturaleza. Por eso proponen al director del circo hacer una función diferente y muy especial. ¿Conseguirán convencer al director de que no necesita animales para que el espectáculo sea un éxito? ¿Lograrán Claudia, Gisele y sus amigos salvar a los animales? ¡Descúbrelo en esta increíble aventura de Las Ratitas! Temas: - Primeros lectores- Libros familiares- Libros infantiles de aventura- Jóvenes influencers- Ficción para niños- Explorar el mundo- Libros ilustrados infantiles La serie perfecta para fans de:  - Itarte Vlogs Family- Anna Kadabra- El mundo de Indy- El club de Ela Top - Hermanos Tremending', '14.95', 8, 6, 'Fisico', 3, 'Tapa Dura', 500, '978-8408276968', NULL, NULL, '../img/Libros/Infantiles/Las Ratitas.jpg', 0),
(79, 'Caperucita roja', 'Los cuentos clásicos de siempre en una colección de libros troquelados infantiles. Con unas grandes y atractivas ilustraciones, y un texto muy sencillo, para que los primeros lectores disfruten y aprendan con sus relatos preferidos. ¡No te pierdas Caperucita!', '2.99', 8, 17, 'Fisico', 2, 'Tapa Blanda', 50, '978-8467784527', NULL, NULL, '../img/Libros/Infantiles/Caperucita roja.jpg', 0),
(80, 'El Pollo Pepe + muñeco', 'Este set contiene el libro con pop-ups favorito de los niños de 1 y 2 años y un muñeco del pollo Pepe, su personaje favorito', '18.95', 8, 16, 'Fisico', 6, 'Tapa Dura', 500, '978-8467559163', NULL, NULL, '../img/Libros/Infantiles/El Pollo Pepe + muñeco.jpg', 0),
(81, 'Diario de Greg 1 - Un pringao total', 'El primer libro del diario más tronchante y desternillante, Diario de Greg. Un auténtico fenómeno mundial. Ser casi adolescente puede ser un fastidio. Nadie lo sabe mejor que Greg Heffley, inmerso en el duro ambiente del instituto, donde los chicos bajitos que aún no han pegado el estirón tienen que compartir los pasillos con grandullones que ya se afeitan dos veces al día.«En primer lugar, quiero dejar una cosa bien clara: esto no es un diario. Ya sé lo que pone en la portada. Mira que cuando Mamá lo fue a comprar le pedí DE MANERA ESPECÍFICA que si compraba una libreta no tuviera el rotulito de diario». Greg Heffley tiene 12 años y su madre le compra un diario que abarcará un curso escolar: de septiembre a junio. Conoceremos a Greg a través de las hilarantes y enternecedoras desventuras que narra e ilustra en su libreta. Estamos ante un retrato cómico de la vida, la voz y las costumbres de los niños preadolescentes. Este debut hará a todo el mundo troncharse de risa.', '15.00', 8, 11, 'Fisico', 4, 'Tapa Dura', 100, '978-8498672220', NULL, NULL, '../img/Libros/Infantiles/Diario de Greg 1 - Un pringao total.jpg', 1),
(82, 'Las aventuras de Dani y Evan. El tesoro del T-Rex ', '¡Skuiter ha desaparecido! Rápidamente se ponen todos a buscarlo hasta que descubren que& ¡ha ido al santuario! Dani, Evan, Bizcoché, Julián y Maribel viajan hasta el Jurásico para buscar a su amigo. ¿Estará en peligro? Pero cuando llegan, descubren que algo terrible sucede en el mundo secreto de los dinosaurios. Y la única forma de salvarlo es encontrar la cueva del T-Rex dorado.', '12.95', 8, 14, 'Fisico', 3, 'Tapa Dura', 100, '978-8408252559', NULL, NULL, '../img/Libros/Infantiles/Las aventuras de Dani y Evan. El tesoro del T-Rex dorado.jpg', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE `pedido` (
  `IdPedido` int(11) NOT NULL,
  `Fecha` date DEFAULT NULL,
  `Usuario` int(11) DEFAULT NULL,
  `PrecioTotal` decimal(10,2) DEFAULT NULL,
  `Reembolso` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `pedido`
--

INSERT INTO `pedido` (`IdPedido`, `Fecha`, `Usuario`, `PrecioTotal`, `Reembolso`) VALUES
(1, '2024-02-01', 1, '5.99', 0),
(2, '2024-02-02', 1, '71.78', 0),
(3, '2024-02-06', 1, '56.89', 0),
(4, '2024-02-06', 1, '55.69', 0),
(5, '2024-02-08', 12, '351.88', 0),
(6, '2024-02-08', 12, '104.39', 0),
(7, '2024-02-09', 25, '383.00', 0),
(8, '2024-02-09', 25, '196.64', 0),
(9, '2024-02-09', 25, '45.91', 0),
(10, '2024-02-09', 25, '16.98', 0),
(11, '2024-02-09', 25, '36.99', 0),
(12, '2024-02-12', 10, '585.19', 1),
(13, '2024-02-12', 26, '45.80', 0),
(14, '2024-02-12', 26, '37.43', 0),
(15, '2024-02-12', 26, '143.84', 0),
(16, '2024-02-12', 27, '12.95', 0),
(17, '2024-02-12', 27, '25.44', 0),
(18, '2024-02-12', 28, '23.49', 1),
(19, '2024-02-12', 28, '663.47', 0),
(20, '2024-02-12', 28, '16.98', 0),
(21, '2024-02-12', 10, '7.99', 0),
(22, '2024-02-13', 10, '79.74', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidolibro`
--

CREATE TABLE `pedidolibro` (
  `IdPedidoLibro` int(11) NOT NULL,
  `Pedido` int(11) NOT NULL,
  `Libro` int(11) NOT NULL,
  `Unidades` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `pedidolibro`
--

INSERT INTO `pedidolibro` (`IdPedidoLibro`, `Pedido`, `Libro`, `Unidades`) VALUES
(1, 1, 34, 1),
(2, 2, 27, 2),
(3, 2, 23, 1),
(4, 2, 58, 2),
(5, 3, 58, 2),
(6, 3, 11, 1),
(7, 4, 2, 1),
(8, 4, 72, 3),
(9, 5, 3, 19),
(10, 6, 48, 1),
(11, 6, 14, 10),
(12, 7, 71, 3),
(13, 7, 64, 23),
(14, 7, 48, 5),
(15, 7, 3, 10),
(16, 8, 24, 4),
(17, 8, 3, 9),
(18, 9, 70, 1),
(19, 9, 14, 4),
(20, 10, 14, 1),
(21, 10, 24, 1),
(22, 11, 21, 3),
(23, 11, 14, 3),
(24, 12, 2, 1),
(25, 12, 45, 34),
(26, 12, 43, 1),
(27, 12, 53, 1),
(28, 13, 61, 1),
(29, 13, 26, 2),
(30, 14, 51, 1),
(31, 14, 14, 1),
(32, 14, 12, 1),
(33, 15, 27, 1),
(34, 15, 56, 15),
(35, 16, 25, 1),
(36, 17, 45, 1),
(37, 17, 14, 1),
(38, 18, 64, 1),
(39, 18, 12, 1),
(40, 19, 65, 1),
(41, 19, 19, 67),
(42, 20, 27, 1),
(43, 20, 2, 1),
(44, 21, 2, 1),
(45, 22, 72, 1),
(46, 22, 30, 1),
(47, 22, 26, 1),
(48, 22, 53, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `IdUsuario` int(11) NOT NULL,
  `Nombre` varchar(30) NOT NULL,
  `Clave` varchar(20) NOT NULL,
  `Saldo` decimal(10,2) NOT NULL,
  `Correo` varchar(50) NOT NULL,
  `Telefono` varchar(25) NOT NULL,
  `Direccion` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`IdUsuario`, `Nombre`, `Clave`, `Saldo`, `Correo`, `Telefono`, `Direccion`) VALUES
(1, 'Pedro', '1234', '1809.65', 'cristinabrcjs@gmail.com', '620402364', 10),
(2, 'Sandra', '1234', '1000.00', 'sandrita00@gmail.com', '665482105', 4),
(3, 'Alicia', '1234', '2000.00', 'alicia2001@gmail.com', '662473155', 1),
(4, 'Juan', '1234', '3000.00', 'juan@gmail.com', '663490154', 3),
(5, 'Cristopher', '1234', '3000.00', 'cristopher2001@gmail.com', '662843951', 6),
(6, 'Raquel', '1234', '2000.00', 'raquelperez@gmail.com', '667910224', 5),
(10, 'Pepita', '1234', '358.98', 'pepita@gmail.com', '925 35 82 68', 58),
(11, 'Pepe', '1234', '0.00', 'pepe@gmail.com', '', NULL),
(12, 'inesit', '1234', '1787.77', 'inesi@gmail.com', '666777888999', 11),
(25, 'alex', '1234', '11590.48', 'alexi@gmail.com', '66677888', 57),
(26, 'Pepe', '1234', '1856.16', 'pepe@gmail.com', '', 59),
(27, 'Pepee', '1234', '61.61', 'pepita@gmail.com', '', 60),
(28, 'Andrea', '1234', '2999319.55', 'andrea@gmail.com', '', 61);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuariodireccion`
--

CREATE TABLE `usuariodireccion` (
  `IdUserDir` int(11) NOT NULL,
  `Usuario` int(11) NOT NULL,
  `Direccion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuariodireccion`
--

INSERT INTO `usuariodireccion` (`IdUserDir`, `Usuario`, `Direccion`) VALUES
(8, 1, 8),
(9, 1, 9),
(10, 1, 10),
(11, 12, 11),
(12, 12, 12),
(13, 12, 13),
(14, 12, 14),
(17, 12, 17),
(56, 5, 6),
(58, 6, 5),
(60, 5, 3),
(62, 3, 1),
(64, 2, 4),
(67, 10, 58),
(68, 26, 59),
(69, 27, 60),
(70, 28, 61),
(71, 28, 62);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `autor`
--
ALTER TABLE `autor`
  ADD PRIMARY KEY (`IdAutor`);

--
-- Indices de la tabla `direccion`
--
ALTER TABLE `direccion`
  ADD PRIMARY KEY (`IdDireccion`);

--
-- Indices de la tabla `genero`
--
ALTER TABLE `genero`
  ADD PRIMARY KEY (`IdGenero`);

--
-- Indices de la tabla `libro`
--
ALTER TABLE `libro`
  ADD PRIMARY KEY (`IdLibro`),
  ADD UNIQUE KEY `ISBN` (`ISBN`),
  ADD KEY `Genero` (`Genero`),
  ADD KEY `Autor` (`Autor`);

--
-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`IdPedido`),
  ADD KEY `Usuario` (`Usuario`);

--
-- Indices de la tabla `pedidolibro`
--
ALTER TABLE `pedidolibro`
  ADD PRIMARY KEY (`IdPedidoLibro`),
  ADD KEY `Libro` (`Libro`),
  ADD KEY `Pedido` (`Pedido`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`IdUsuario`),
  ADD KEY `Direccion` (`Direccion`);

--
-- Indices de la tabla `usuariodireccion`
--
ALTER TABLE `usuariodireccion`
  ADD PRIMARY KEY (`IdUserDir`),
  ADD KEY `Usuario` (`Usuario`),
  ADD KEY `Direccion` (`Direccion`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `autor`
--
ALTER TABLE `autor`
  MODIFY `IdAutor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `direccion`
--
ALTER TABLE `direccion`
  MODIFY `IdDireccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT de la tabla `genero`
--
ALTER TABLE `genero`
  MODIFY `IdGenero` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `libro`
--
ALTER TABLE `libro`
  MODIFY `IdLibro` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;

--
-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `IdPedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `pedidolibro`
--
ALTER TABLE `pedidolibro`
  MODIFY `IdPedidoLibro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `IdUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `usuariodireccion`
--
ALTER TABLE `usuariodireccion`
  MODIFY `IdUserDir` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `libro`
--
ALTER TABLE `libro`
  ADD CONSTRAINT `libro_ibfk_1` FOREIGN KEY (`Genero`) REFERENCES `genero` (`IdGenero`),
  ADD CONSTRAINT `libro_ibfk_2` FOREIGN KEY (`Autor`) REFERENCES `autor` (`IdAutor`);

--
-- Filtros para la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`Usuario`) REFERENCES `usuario` (`IdUsuario`);

--
-- Filtros para la tabla `pedidolibro`
--
ALTER TABLE `pedidolibro`
  ADD CONSTRAINT `pedidolibro_ibfk_1` FOREIGN KEY (`Pedido`) REFERENCES `pedido` (`IdPedido`),
  ADD CONSTRAINT `pedidolibro_ibfk_2` FOREIGN KEY (`Libro`) REFERENCES `libro` (`IdLibro`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`Direccion`) REFERENCES `direccion` (`IdDireccion`);

--
-- Filtros para la tabla `usuariodireccion`
--
ALTER TABLE `usuariodireccion`
  ADD CONSTRAINT `usuariodireccion_ibfk_1` FOREIGN KEY (`Usuario`) REFERENCES `usuario` (`IdUsuario`),
  ADD CONSTRAINT `usuariodireccion_ibfk_2` FOREIGN KEY (`Direccion`) REFERENCES `direccion` (`IdDireccion`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
