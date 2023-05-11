-- Adminer 4.8.1 MySQL 8.0.30 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `name` varchar(250) NOT NULL,
  `email` varchar(250) NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`),
  KEY `fk_user_comments` (`user_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`),
  CONSTRAINT `fk_user_comments` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `comments` (`id`, `post_id`, `user_id`, `name`, `email`, `content`, `created_at`) VALUES
(55,	6,	NULL,	'Petr',	'dadsadada@seznam.cz',	'Dobrá rada, diky',	'2023-05-11 22:41:53'),
(56,	61,	NULL,	'Eliska',	'Eliska@seznam.cz',	'hele, ja mam radsi ruzovou, ale dobry',	'2023-05-11 22:45:26'),
(57,	61,	NULL,	'Martin Hruška',	'martinhruska003@seznam.cz',	'Za me pekny',	'2023-05-11 22:45:41');

DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `file_name` varchar(255) DEFAULT NULL,
  `image_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `posts` (`id`, `title`, `content`, `created_at`, `file_name`, `image_id`) VALUES
(1,	'Škoda Octavia',	'Škoda Octavia je velmi populární automobil, který se těší značné oblibě díky své spolehlivosti a nízkým provozním nákladům. Nicméně, jako u všech vozidel, existují některé problémy, se kterými majitelé Octavie mohou potkat. Zde jsou některé z nejčastějších problémů s Škodou Octavia:\r\n\r\nProblémy s turbodmychadlem\r\nŠkoda Octavia je často vybavena turbodmychadlem, které je určeno ke zvýšení výkonu a zlepšení výkonu motoru. Nicméně, turbodmychadlo může být náchylné k poruchám, což může vést ke ztrátě výkonu a horšímu chodu motoru. Tyto problémy mohou být způsobeny například vysokým znečištěním nebo nedostatečnou údržbou.\r\n\r\nElektrické problémy\r\nDalším častým problémem u Škody Octavia jsou různé elektrické problémy. Tyto problémy se mohou týkat různých systémů v vozidle, jako například problémy s baterií, startérem, nebo problémy s alternátorem. Opravy těchto problémů obvykle vyžadují pečlivou kontrolu a opravu drátů, spojek a konektorů.\r\n\r\nBrzdový systém\r\nJiným častým problémem u Škody Octavia jsou problémy s brzdovým systémem. Tyto problémy se mohou týkat různých součástí, jako jsou brzdové destičky, brzdové kotouče nebo brzdové hadice. Tyto problémy mohou vést k neefektivnímu brzdění a špatnému řízení vozidla.\r\n\r\nProblémy s vodou\r\nŠkoda Octavia může trpět také problémy s vodou v interiéru vozidla, zejména při silných deštích nebo při jízdě v silném dešti. To může vést k problémům s elektronickými součástmi a kůží, což může způsobit zápach nebo korozi.',	'2022-12-15 09:19:05',	'octavia.jpg',	NULL),
(2,	'Škoda Fabia',	'\r\nŠkoda Fabia je malý automobil, který se těší velké oblibě díky své spolehlivosti a nízkým nákladům na provoz. Nicméně, jako u všech vozidel, existují některé problémy, se kterými majitelé Fabie mohou potkat. Zde jsou některé z nejčastějších problémů s Škodou Fabia:\r\n\r\nElektrické problémy\r\nJeden z nejčastějších problémů, se kterými se majitelé Škody Fabia potýkají, jsou různé elektrické problémy. Tyto problémy se mohou týkat různých součástí, jako jsou baterie, startér, nebo alternátor. Opravy těchto problémů obvykle vyžadují pečlivou kontrolu a opravu drátů, spojek a konektorů.\r\n\r\nBrzdový systém\r\nDalším častým problémem u Škody Fabia jsou problémy s brzdovým systémem. Tyto problémy se mohou týkat různých součástí, jako jsou brzdové kotouče, brzdové destičky nebo brzdové hadice. Tyto problémy mohou vést k neefektivnímu brzdění a špatnému řízení vozidla.\r\n\r\nProblémy s motorem\r\nŠkoda Fabia může trpět také problémy s motorem, které se mohou týkat různých součástí, jako jsou zapalovací svíčky, olejové filtry, nebo termostat. Tyto problémy mohou vést ke ztrátě výkonu motoru, zvýšenému spotřebě paliva a dalším nežádoucím účinkům.\r\n\r\nProblémy s převodovkou\r\nProblémy s převodovkou jsou také poměrně běžné u Škody Fabia. Tyto problémy se mohou týkat různých součástí, jako jsou spojky, převodovky nebo synchronizační kroužky. Tyto problémy mohou vést ke ztrátě výkonu a dalším problémům s řazením.\r\n\r\nProblémy s chlazením\r\nDalším častým problémem u Škody Fabia jsou problémy s chlazením motoru. Tyto problémy se mohou týkat různých součástí, jako jsou chladiče, hadice nebo termostat. Tyto problémy mohou vést k přehřívání motoru, ztrátě výkonu a dalším problémům s chodem motoru.',	'2022-12-15 09:19:05',	'fabia.jpg',	NULL),
(3,	'Škoda Rapid',	'Škoda Rapid je středně velký automobil, který je známý svou spolehlivostí a nízkými náklady na provoz. Nicméně, jako u všech vozidel, existují některé problémy, se kterými majitelé Škody Rapid mohou potkat. Zde jsou některé z nejčastějších problémů s Škodou Rapid:\r\n\r\nProblémy s elektronikou\r\nJeden z nejčastějších problémů, se kterými majitelé Škody Rapid potýkají, jsou různé elektronické problémy. Tyto problémy se mohou týkat různých součástí, jako jsou senzory, počítače, nebo připojení k mobilnímu telefonu. Opravy těchto problémů obvykle vyžadují pečlivou kontrolu a opravu drátů, spojek a konektorů.\r\n\r\nProblémy s brzdovým systémem\r\nDalším častým problémem u Škody Rapid jsou problémy s brzdovým systémem. Tyto problémy se mohou týkat různých součástí, jako jsou brzdové kotouče, brzdové destičky nebo brzdové hadice. Tyto problémy mohou vést k neefektivnímu brzdění a špatnému řízení vozidla.\r\n\r\nProblémy s motorem\r\nŠkoda Rapid může trpět také problémy s motorem, které se mohou týkat různých součástí, jako jsou zapalovací svíčky, olejové filtry, nebo termostat. Tyto problémy mohou vést ke ztrátě výkonu motoru, zvýšenému spotřebě paliva a dalším nežádoucím účinkům.\r\n\r\nProblémy s převodovkou\r\nProblémy s převodovkou jsou také poměrně běžné u Škody Rapid. Tyto problémy se mohou týkat různých součástí, jako jsou spojky, převodovky nebo synchronizační kroužky. Tyto problémy mohou vést ke ztrátě výkonu a dalším problémům s řazením.\r\n\r\nProblémy s voděním\r\nDalším častým problémem u Škody Rapid jsou problémy s voděním. Tyto problémy se mohou týkat různých součástí, jako jsou řízení, ložiska nebo silentbloky. Tyto problémy mohou vést k špatnému ovládání vozidla a horšímu řízení.',	'2022-12-15 09:19:05',	'rapid.jpg',	NULL),
(6,	'Škoda 120',	'Škoda 120 byla poměrně spolehlivým vozidlem, nicméně jako u všech automobilů existují určité problémy, na které majitelé často narazili. Některé z nejčastějších problémů, které majitelé Škody 120 řeší, jsou:\r\n\r\nKarburátor\r\nJedním z největších problémů s Škodou 120 byly problémy s karburátorem. Vzhledem k tomu, že se jedná o vozidlo se starší konstrukcí motoru, karburátor může být náchylný k zanesení nečistotami, což může způsobit problémy s chodem na volnoběh nebo problémy s regulací emisí. V některých případech mohlo být nutné karburátor vyměnit nebo opravit.\r\n\r\nElektrické problémy\r\nJiným běžným problémem, se kterým se majitelé Škody 120 setkávali, byly elektrické problémy. Tyto problémy se mohly týkat různých systémů v vozidle, jako například problémů s baterií, startérem, nebo problémy s alternátorem. Opravy těchto problémů obvykle vyžadovaly pečlivou kontrolu a opravu drátů, spojek a konektorů.\r\n\r\nBrzdy\r\nProblémy s brzdami byly také běžným problémem u Škody 120. Mezi tyto problémy patřilo neefektivní brzdný systém, nebo špatně fungující ruční brzda. Tyto problémy mohly být způsobeny opotřebením brzdových destiček, špatně nastavenými brzdovými válci, nebo špatně nastavenými brzdovými hadicemi. V některých případech mohlo být nutné nahradit celý brzdový systém.\r\n\r\nKoroze\r\nKoroze byla také velkým problémem u Škody 120, zejména na rámu a podvozku vozidla. Tyto oblasti byly náchylné ke korozi v důsledku expozice soli na silnicích během zimních měsíců. Pokud byly poškozeny, mohly způsobit ztrátu stability a řízení vozidla. Opravy koroze byly často drahé a časově náročné.',	'2023-04-30 22:22:18',	'120.jpg',	NULL),
(7,	'Škoda Felicia',	'Škoda Felicia byla vyráběna od roku 1994 do roku 2001 a byla jedním z nejpopulárnějších modelů automobilky Škoda. Přestože byla tato řada aut považována za poměrně spolehlivou a cenově dostupnou, stále existovaly některé problémy, se kterými se majitelé setkávali. Zde je seznam některých z nejčastějších problémů Škody Felicia:\n\nProblémy s elektroinstalací\nJedním z nejvíce diskutovaných problémů Škody Felicia je problém s elektroinstalací. Elektrické problémy se mohou týkat různých oblastí, včetně zesilovače, zapalování a chybného osvětlení. Tyto problémy mohou být způsobeny špatným spojením nebo nesprávnou instalací, což může vést k výpadkům elektrického systému a poruchám funkce různých komponentů.\n\nProblémy s brzdami\nDalším častým problémem u Škody Felicia jsou problémy s brzdovým systémem. Tyto problémy mohou být způsobeny opotřebením brzdových destiček, kotoučů nebo brzdových hadic. Pokud se tento problém neprojeví včas, může to vést k neefektivnímu brzdění a vážným nehodám.\n\nProblémy s motorem\nŠkoda Felicia může trpět také problémy s motorem, jako jsou poruchy spojek, poruchy chlazení, poškození olejového čerpadla nebo selhání předních ložisek motoru. Tyto problémy mohou vést k výpadkům výkonu, zvýšené spotřebě paliva nebo dokonce k selhání motoru.\n\nProblémy s převodovkou\nProblémy s převodovkou jsou také velmi častým problémem u Škody Felicia. Tyto problémy mohou být způsobeny opotřebením spojek, převodových olejů nebo synchronizačních kroužků. Tyto problémy mohou vést ke ztrátě výkonu a dalším problémům s řazením.',	'2023-01-25 14:19:18',	'felicia.jpg',	NULL),
(8,	'Škoda Favorit',	'Škoda Favorit byla vyráběna v letech 1987 až 1995 a byla vůbec prvním modelem, který byl po privatizaci vyráběn pod značkou Škoda Auto. Tento automobil byl velmi oblíbený zejména v zemích bývalého východního bloku, ale i v jiných částech světa. I přestože se jednalo o poměrně spolehlivý vůz, stále se vyskytovaly některé problémy, se kterými se majitelé setkávali. Zde je seznam některých z nejčastějších problémů Škody Favorit:\r\n\r\nProblémy s karoserií a lakem\r\nJedním z nejvýraznějších problémů, se kterými se majitelé Škody Favorit setkávali, byly problémy s karoserií a lakem. V důsledku nedostatečné ochrany proti korozi a nekvalitního laku se karoserie Favoritu často rychle kazila, což mohlo vést k průniku vlhkosti a dalším závažným problémům.\r\n\r\nProblémy s motorem a převodovkou\r\nDalším častým problémem Škody Favorit byly problémy s motorem a převodovkou. Motory Škody Favorit byly často náchylné na poruchy zapalování a chlazení, což mohlo vést k vážným poruchám a selhání motoru. Převodovka se také mohla opotřebovat a vykazovat problémy s řazením, což mohlo vést k neefektivnímu přenosu výkonu.\r\n\r\nProblémy s brzdami\r\nDalším problémem, se kterým se majitelé Škody Favorit mohli setkat, byly problémy s brzdovým systémem. Tyto problémy se často týkaly opotřebení brzdových destiček, kotoučů nebo brzdových hadic, což mohlo vést k neefektivnímu brzdění a vážným nehodám.\r\n\r\nProblémy s elektroinstalací\r\nProblémy s elektroinstalací jsou také poměrně častým problémem Škody Favorit. Tyto problémy mohou být způsobeny špatným spojením nebo nesprávnou instalací, což může vést k výpadkům elektrického systému a poruchám funkce různých komponentů.',	'2023-01-25 14:25:37',	'favorit.jpg',	NULL),
(61,	'Fabie',	'Myslíte, ze je tahle barva dobra?',	'2023-05-11 22:44:44',	'645d6fdc7dd0f.jpeg',	NULL);

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `lastname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `users` (`id`, `username`, `lastname`, `password`, `role`, `created_at`) VALUES
(1,	'admin',	'admin',	'$2y$12$oz3zQsEAniARmjBU.XGRfONACixg9l0P3xG16UElKSZ8aaZg2ipfe',	'admin',	'2023-05-10 17:25:20'),
(22,	'tomas',	'dadad',	'$2y$12$3eqBWukdagODu.KBSho1w.RjtuL/n4RIYVE07Lm3cT9.nymclg08K',	'user',	'2023-05-10 06:35:45'),
(23,	'tomas',	'dad',	'$2y$12$03HCz8v9nhizM0MZRc6b5ulq5tK1Bg8jDLmjoc9TlGkI9mnI7zSI2',	'user',	'2023-05-10 06:37:25'),
(24,	'tomas',	'dad',	'$2y$12$83KuJi6upj35xUwh6d0CBOX3NJX3KVTfYjElH9JxqEOUQtvokQLu6',	'user',	'2023-05-10 06:37:34'),
(25,	'martin',	'hruska',	'$2y$12$oZsK7dMNu2UppG.tQ/WfeeG7v/ZZhAyMHGJzld2jvOPamb.KMCQna',	'user',	'2023-05-10 06:47:20'),
(37,	'sasa',	'sasa',	'$2y$12$N8Jo9SIGypOd.eDKbB3lT.gJ9a8lsTV99YhTs9wwCgy8qysVb2cNy',	'user',	'2023-05-11 20:24:35'),
(38,	'lalas',	'lala',	'$2y$12$2yipuEewYbqO7zvcXWx1IOBwdxY4f1A0TRuI6hoGUguBB6.xFFRXK',	'user',	'2023-05-11 22:33:50'),
(39,	'Petr',	'Landa',	'$2y$12$a7JToahknnffqZ9dM5rWYe8JlSVVi8bMH39/NHpRWQEhk2MzFX4g.',	'user',	'2023-05-11 22:43:33');

-- 2023-05-11 22:47:14
