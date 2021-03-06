-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 02, 2018 at 12:44 AM
-- Server version: 10.1.30-MariaDB
-- PHP Version: 7.2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bomber_info`
--

-- --------------------------------------------------------

--
-- Table structure for table `campaigns`
--

CREATE TABLE `campaigns` (
  `pkCampaign` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `description` text NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `campaigns`
--

INSERT INTO `campaigns` (`pkCampaign`, `name`, `date`, `description`, `deleted`) VALUES
(1, 'Schweinfurt-Regensburg mission', '1944-10-14', 'The Schweinfurt-Regensburg mission was a strategic bombing mission during World War II. Carried out by Boeing B-17 Flying Fortress heavy bombers of the U.S. Army Air Forces on August 17, 1943, it was an ambitious plan to cripple the German aircraft industry. --Copied from Wikipedia', 0),
(2, 'test', '1960-10-22', 'stuff did happen', 1),
(3, 'Big Week Day 1', '1944-02-20', 'The Eighth Air Force begins \"Big Week\" attacks on German aircraft plants and airfields. For the first time, over 1,000 bombers are dispatched; 21 bombers and 4 fighters are lost hitting three areas in Germany:      417 B-17s are dispatched to Leipzig-Mockau Airfield, and aviation industry targets at Heiterblick and Abtnaundorf; 239 hit the primary targets, 37 hit Bernburg (Junkers), 44 hit Oschersleben (AGO, prime Fw 190A subcontractor) and 20 hit other targets of opportunity; they claim 14-5-6 Luftwaffe aircraft; seven B-17s are lost, one damaged beyond repair and 161 damaged; casualties are 7 KIA, 17 WIA and 72 MIA.     314 B-17s are dispatched to the Tutow Airfield; 105 hit the primary and immediate area, 76 hit Rostock (Heinkel) and 115 hit other targets of opportunity; they claim 15-15-10 Luftwaffe aircraft; 6 B-17s are lost, 1 damaged beyond repair and 37 damaged; casualties are 3 KIA and 60 MIA.     272 B-24s are dispatched to aviation industry targets at Brunswick, Wilhelmtor and Neupetritor; 76 hit the primary, 87 hit Gotha, 13 hit Oschersleben, 58 hit Helmstedt and 10 hit other targets of opportunity; they claim 36-13-13 Luftwaffe aircraft; 8 B-24s are lost, 3 damaged beyond repair and 37 damaged; casualties are 10 KIA, 10 WIA and 77 MIA.  Missions one and three above are escorted by 94 P-38 Lightnings, 668 Eighth and Ninth Air Force P-47 Thunderbolts and 73 Eighth and Ninth Air Force P-51 Mustangs; they claim 61-7-37 Luftwaffe aircraft; one P-38 Lightning, two P-47 Thunderbolts and one P-51 Mustangs are lost, two P-47 Thunderbolts are damaged beyond repair and 4 other aircraft are damaged; casualties are 4 MIA. German losses amount to 10 Messerschmitt Bf 110s destroyed and three damaged with 10 killed and seven wounded. Total losses included 74 Bf 110s, Fw 190s and Bf 109s and a further 29 damaged', 0);

-- --------------------------------------------------------

--
-- Table structure for table `crews`
--

CREATE TABLE `crews` (
  `pkCrew` int(11) NOT NULL,
  `provisionalWing` varchar(50) NOT NULL,
  `bomberGroup` varchar(50) NOT NULL,
  `trainingSchool` int(11) DEFAULT NULL,
  `sent` int(11) NOT NULL,
  `losses` int(11) NOT NULL,
  `stationedAirfield` varchar(50) NOT NULL,
  `apiName` varchar(50) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `crews`
--

INSERT INTO `crews` (`pkCrew`, `provisionalWing`, `bomberGroup`, `trainingSchool`, `sent`, `losses`, `stationedAirfield`, `apiName`, `deleted`) VALUES
(1, '403d PCBW', '96th Bomb Group', NULL, 21, 0, 'Snetterton Heath', '96th_Test_Wing', 0),
(2, '403d PCBW', '388th Bomb Group', NULL, 21, 1, 'Knettishall', '388th_Operations_Group', 0),
(3, '403d PCBW', '390th Bomb Group ', NULL, 20, 6, 'Framlingham', '390th_Strategic_Missile_Wing', 0),
(4, '401st PCBW', '94th Bomb Group', NULL, 21, 1, 'Bury St. Edmunds', '94th_Operations_Group', 0),
(5, '401st PCBW', '385th Bomb Group', NULL, 21, 3, 'Great Ashfield', '385th_Air_Expeditionary_Group', 0),
(6, '402nd PCBW', '95th Bomb Group ', NULL, 21, 4, 'Horham', '95th_Air_Base_Wing', 0),
(7, '402nd PCBW', '100th Bomb Group', NULL, 21, 9, 'Thorpe Abbotts', '100th_Air_Refueling_Wing', 0),
(9, 'Test', 'qweqw', NULL, 14312, 1231, '1231', NULL, 1),
(10, '2nd PCBW', '389th Bomb Group', NULL, 19, 1, 'Hethel', '389th_Bombardment_Squadron', 0),
(11, '14th PCBW', '392th Bomb Group', NULL, 23, 2, ' Wendling', '392d_Air_Expeditionary_Group', 0),
(12, '2nd PCBW', '445th Bomb Group', NULL, 21, 0, 'Tibenham', '445th_Operations_Group', 0),
(13, '20th PCBW', '446th Bomb Group', NULL, 15, 3, 'Bungay', '446th_Operations_Group', 0);

-- --------------------------------------------------------

--
-- Table structure for table `crewspercampaign`
--

CREATE TABLE `crewspercampaign` (
  `pkCrewsPerCampaign` int(11) NOT NULL,
  `crewID` int(11) NOT NULL,
  `campaignID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `crewspercampaign`
--

INSERT INTO `crewspercampaign` (`pkCrewsPerCampaign`, `crewID`, `campaignID`) VALUES
(31, 4, 1),
(32, 5, 1),
(33, 6, 1),
(34, 7, 1),
(36, 2, 1),
(37, 3, 1),
(39, 13, 3),
(40, 12, 3),
(42, 10, 3),
(44, 1, 1),
(45, 11, 3);

-- --------------------------------------------------------

--
-- Table structure for table `feed_event`
--

CREATE TABLE `feed_event` (
  `id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `creator_id` int(11) NOT NULL,
  `item_1_id` int(11) DEFAULT NULL,
  `item_2_id` int(11) DEFAULT NULL,
  `item_3_id` int(11) DEFAULT NULL,
  `data_1` text,
  `data_2` text,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `feed_event`
--

INSERT INTO `feed_event` (`id`, `type`, `creator_id`, `item_1_id`, `item_2_id`, `item_3_id`, `data_1`, `data_2`, `date_created`) VALUES
(1, 'add_campaign', 1, 2, 0, 0, NULL, NULL, '2018-04-08 18:43:57'),
(2, 'edit_campaign', 1, 2, 0, 0, 'Old date: 2222-02-22 / Old description: nothing / ', 'New date: 1960-10-22 / New description: stuff did happen / ', '2018-04-08 18:44:34'),
(3, 'delete_campaign', 1, 2, 0, 0, NULL, NULL, '2018-04-08 19:01:09'),
(6, 'add_crew', 2, 9, 0, 0, NULL, NULL, '2018-04-13 02:09:15'),
(7, 'delete_crew', 2, 9, 0, 0, NULL, NULL, '2018-04-13 02:09:50'),
(8, 'visit_page', -1, -2, 0, 0, 'Home', NULL, '2018-04-29 00:46:57'),
(9, 'visit_page', -1, -2, 0, 0, 'Home', NULL, '2018-04-30 23:57:36'),
(10, 'visit_page', -1, -2, 0, 0, 'Home', NULL, '2018-05-01 00:37:47'),
(11, 'visit_page', -1, -2, 0, 0, 'Home', NULL, '2018-05-01 00:50:58'),
(12, 'visit_page', -1, -2, 0, 0, 'Home', NULL, '2018-05-01 00:53:24'),
(13, 'visit_page', -1, -2, 0, 0, 'Home', NULL, '2018-05-01 00:53:53'),
(14, 'visit_page', -1, 1, 0, 0, 'Campaigns', NULL, '2018-05-01 01:06:34'),
(15, 'visit_page', -1, 1, 0, 0, 'Crews', NULL, '2018-05-01 01:06:36'),
(16, 'visit_page', -1, 1, 0, 0, 'Campaigns', NULL, '2018-05-01 01:08:39'),
(17, 'visit_page', -1, 1, 0, 0, 'Campaigns', NULL, '2018-05-01 01:08:50'),
(18, 'visit_page', -1, 1, 0, 0, 'Campaigns', NULL, '2018-05-01 01:10:04'),
(19, 'add_campaign', 1, 3, 0, 0, NULL, NULL, '2018-05-01 01:15:23'),
(20, 'visit_page', -1, 1, 0, 0, 'Campaigns', NULL, '2018-05-01 01:15:46'),
(21, 'visit_page', -1, 1, 0, 0, 'Campaigns', NULL, '2018-05-01 01:15:48'),
(22, 'visit_page', -1, 1, 0, 0, 'Campaigns', NULL, '2018-05-01 01:17:38'),
(23, 'visit_page', -1, 1, 0, 0, 'Crews', NULL, '2018-05-01 01:17:39'),
(24, 'add_crew', 1, 10, 0, 0, NULL, NULL, '2018-05-01 01:34:09'),
(25, 'add_crew', 1, 11, 0, 0, NULL, NULL, '2018-05-01 01:35:07'),
(26, 'add_crew', 1, 12, 0, 0, NULL, NULL, '2018-05-01 01:36:14'),
(27, 'add_crew', 1, 13, 0, 0, NULL, NULL, '2018-05-01 01:37:24'),
(28, 'visit_page', -1, 1, 0, 0, 'Campaigns', NULL, '2018-05-01 02:11:27'),
(29, 'visit_page', -1, 1, 0, 0, 'Crews', NULL, '2018-05-01 02:11:27'),
(30, 'visit_page', -1, 1, 0, 0, 'People', NULL, '2018-05-01 02:11:28'),
(31, 'visit_page', -1, 1, 0, 0, 'Dashboard', NULL, '2018-05-01 02:11:29'),
(32, 'visit_page', -1, 1, 0, 0, 'Campaigns', NULL, '2018-05-01 02:11:32'),
(33, 'visit_page', -1, 1, 0, 0, 'Crews', NULL, '2018-05-01 02:49:31'),
(34, 'visit_page', -1, 1, 0, 0, 'Crews', NULL, '2018-05-01 02:49:48'),
(35, 'visit_page', -1, 1, 0, 0, 'Crews', NULL, '2018-05-01 02:51:43'),
(36, 'visit_page', -1, 1, 0, 0, 'Crews', NULL, '2018-05-01 02:52:27'),
(37, 'visit_page', -1, 1, 0, 0, 'Crews', NULL, '2018-05-01 02:52:56'),
(38, 'visit_page', -1, 1, 0, 0, 'Campaigns', NULL, '2018-05-01 02:58:42'),
(39, 'visit_page', -1, 1, 0, 0, 'Crews', NULL, '2018-05-01 02:58:44'),
(40, 'visit_page', -1, 1, 0, 0, 'Dashboard', NULL, '2018-05-01 02:58:46'),
(41, 'visit_page', -1, 1, 0, 0, 'Home', NULL, '2018-05-01 02:58:48'),
(42, 'visit_page', -1, 1, 0, 0, 'Home', NULL, '2018-05-01 02:58:50'),
(43, 'visit_page', -1, 1, 0, 0, 'Home', NULL, '2018-05-01 02:58:52'),
(44, 'visit_page', -1, 1, 0, 0, 'Campaigns', NULL, '2018-05-01 03:00:20'),
(45, 'visit_page', -1, 1, 0, 0, 'Crews', NULL, '2018-05-01 03:00:21'),
(46, 'visit_page', -1, -2, 0, 0, 'Home', NULL, '2018-05-01 13:54:33'),
(47, 'visit_page', -1, 1, 0, 0, 'Campaigns', NULL, '2018-05-01 13:54:44'),
(48, 'visit_page', -1, 1, 0, 0, 'Crews', NULL, '2018-05-01 13:54:55'),
(49, 'visit_page', -1, 1, 0, 0, 'Crews', NULL, '2018-05-01 13:54:58'),
(50, 'visit_page', -1, 1, 0, 0, 'Dashboard', NULL, '2018-05-01 13:55:04'),
(51, 'visit_page', -1, 1, 0, 0, 'Home', NULL, '2018-05-01 14:03:59'),
(52, 'visit_page', -1, 1, 0, 0, 'Home', NULL, '2018-05-01 14:59:12'),
(53, 'visit_page', -1, 1, 0, 0, 'Home', NULL, '2018-05-01 14:59:43'),
(54, 'visit_page', -1, 1, 0, 0, 'Home', NULL, '2018-05-01 15:00:05'),
(55, 'visit_page', -1, 1, 0, 0, 'Home', NULL, '2018-05-01 15:02:05'),
(56, 'visit_page', -1, 1, 0, 0, 'Home', NULL, '2018-05-01 15:02:09'),
(57, 'visit_page', -1, 1, 0, 0, 'Home', NULL, '2018-05-01 15:02:20'),
(58, 'visit_page', -1, 1, 0, 0, 'Home', NULL, '2018-05-01 15:02:36'),
(59, 'visit_page', -1, 1, 0, 0, 'Home', NULL, '2018-05-01 15:02:47'),
(60, 'visit_page', -1, 1, 0, 0, 'Home', NULL, '2018-05-01 15:02:59'),
(61, 'visit_page', -1, 1, 0, 0, 'Home', NULL, '2018-05-01 15:03:22'),
(62, 'visit_page', -1, 1, 0, 0, 'Home', NULL, '2018-05-01 15:03:38'),
(63, 'visit_page', -1, 1, 0, 0, 'Home', NULL, '2018-05-01 15:03:52'),
(64, 'visit_page', -1, 1, 0, 0, 'Home', NULL, '2018-05-01 15:04:13'),
(65, 'visit_page', -1, 1, 0, 0, 'Home', NULL, '2018-05-01 15:04:20'),
(66, 'visit_page', -1, 1, 0, 0, 'Home', NULL, '2018-05-01 17:49:50'),
(67, 'visit_page', -1, -2, 0, 0, 'Home', NULL, '2018-05-01 17:54:30'),
(68, 'visit_page', -1, -2, 0, 0, 'Home', NULL, '2018-05-01 17:54:35'),
(69, 'visit_page', -1, 1, 0, 0, 'Home', NULL, '2018-05-01 17:59:17'),
(70, 'visit_page', -1, -2, 0, 0, 'Home', NULL, '2018-05-01 19:56:00'),
(71, 'visit_page', -1, 1, 0, 0, 'Campaigns', NULL, '2018-05-01 19:56:08'),
(72, 'visit_page', -1, 1, 0, 0, 'Crews', NULL, '2018-05-01 19:56:13'),
(73, 'visit_page', -1, 1, 0, 0, 'Dashboard', NULL, '2018-05-01 19:56:20'),
(74, 'visit_page', -1, 1, 0, 0, 'Campaigns', NULL, '2018-05-01 19:56:29'),
(75, 'visit_page', -1, 1, 0, 0, 'Crews', NULL, '2018-05-01 19:56:34'),
(76, 'visit_page', -1, 1, 0, 0, 'Home', NULL, '2018-05-01 19:56:49'),
(77, 'visit_page', -1, 1, 0, 0, 'Campaigns', NULL, '2018-05-01 19:57:11'),
(78, 'visit_page', -1, 1, 0, 0, 'Crews', NULL, '2018-05-01 19:57:13'),
(79, 'visit_page', -1, 1, 0, 0, 'Dashboard', NULL, '2018-05-01 19:57:18'),
(80, 'visit_page', -1, 1, 0, 0, 'Campaigns', NULL, '2018-05-01 19:57:51'),
(81, 'visit_page', -1, -2, 0, 0, 'Home', NULL, '2018-05-01 22:38:54'),
(82, 'visit_page', -1, 1, 0, 0, 'Campaigns', NULL, '2018-05-01 22:39:50'),
(83, 'visit_page', -1, 1, 0, 0, 'Crews', NULL, '2018-05-01 22:39:53'),
(84, 'visit_page', -1, 1, 0, 0, 'Crews', NULL, '2018-05-01 22:40:05'),
(85, 'visit_page', -1, 1, 0, 0, 'Crews', NULL, '2018-05-01 22:42:07');

-- --------------------------------------------------------

--
-- Table structure for table `people`
--

CREATE TABLE `people` (
  `pkPerson` int(11) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `birthdate` date NOT NULL,
  `deathdate` date DEFAULT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `people`
--

INSERT INTO `people` (`pkPerson`, `firstName`, `lastName`, `birthdate`, `deathdate`, `description`) VALUES
(1, 'Curtis', 'LeMay', '1961-06-30', '1965-01-31', 'When the U.S. entered World War II in December 1941 after the Japanese attack on Pearl Harbor, LeMay was a major in the United States Army Air Forces (he had been a first lieutenant as recently as 1940), and the commander of a newly created B-17 Flying Fortress unit, the 305th Bomb Group. --Copied from Wikipedia');

-- --------------------------------------------------------

--
-- Table structure for table `relationships`
--

CREATE TABLE `relationships` (
  `id` int(11) NOT NULL,
  `follower_id` int(11) NOT NULL,
  `followee_id` int(11) NOT NULL,
  `follows` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `trainingschool`
--

CREATE TABLE `trainingschool` (
  `pkSchool` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `description` text NOT NULL,
  `levelNumber` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `trainingschool`
--

INSERT INTO `trainingschool` (`pkSchool`, `name`, `duration`, `description`, `levelNumber`) VALUES
(1, 'The College Training', '5 months', 'The five-month college course for future Aircrew members taught them the fundamentals and skills which they would later develop to a much higher level at the specialized schools.  \r\n\r\n \r\n\r\nThe course was given at more than 150 leading colleges throughout the nation, and consisted of approximately 700 concentrated hours of academic and military instruction. Students received instruction in mathematics, physics, current history, geography and English under the instructors at the institution.  \r\n\r\n \r\n\r\nA staff of Air Force officers and enlisted men was charged with the responsibility for their military indoctrination. Under them the students received thorough schooling in the customs, courtesies and regulations of the service, as well as military drill and discipline.  \r\n\r\n \r\n\r\nIn addition, each student received approximately ten hours of dual instruction in light airplanes, during which he learned elementary flight maneuvers, landing and traffic procedure.  \r\n\r\n \r\n\r\nFor five months the future aircrew members studied and practiced. Students, in military uniform, marched in formation to and from their classes. There were a lot of text books to read – many things to learn in addition to the regular academic subjects: civil air regulations, first aid, how to give artificial respiration, proper use of the gas mask, and 280 hours of military indoctrination. At day’s end, they stood retreat as the flag was lowered.  \r\n\r\n \r\n\r\nMail call, chow time and relaxing following a hard day’s work may have been the most enjoyable times at the College Training Detachment. \r\n\r\n \r\n\r\nThe five months passed quickly, and then it was time to report to the Classification Center.  \r\n\r\n--Copied from www.wingsofhonor.org', 1),
(2, 'Classification Center', 'Two to Four Weeks', 'In the Classification Center would-be airmen spent from two to four weeks undergoing extensive physical and mental testing, test they had never heard of, or imagined. Developed by leading psychologists, these tests would determine with great accuracy their aptitude for aircrew training.  \r\n\r\n \r\n\r\nSome tests were given in a classroom with hundreds of young men writing the answers to examination questions designed to show the cadet’s present mental status, as well as his potential for absorbing facts and training.  \r\n\r\n \r\n\r\nIn another area cadets would be confronted with a battery of mechanical tests which tested their physical reactions and coordination.  At the end of the tests, each cadet was classified for the job, bombardier, navigator or pilot, based on their background, training, aptitudes and preference.  \r\n\r\n \r\n\r\nGraduates from Classification were appointed as Aviation Cadets and went immediately to pilot, bombardier, or navigator Pre-flight Schools.  \r\n\r\n--Copied from www.wingsofhonor.org', 2),
(3, 'Pre-Flight School', 'Nine Weeks', 'In Pre-flight, for nine weeks the Aviation Cadets received intensive training in strict discipline, military customs, courtesies and drill. He received his first introduction to courses in aircraft and naval vessel identification, studied code, navigation and meteorology, and learned about oxygen in a low-pressure chamber. The academic program included extensive studies in mathematics, physics, military law, citizenship, national policy, organization of the United States Government, the Air Corps, the Army, current events, and types of Air Forces equipment and armament. \r\nHe learned to fire the 45 caliber pistol, and how to field-strip a Tommy gun, spent hours a day at exercise and tough commando training, ate like a horse, and emerged physically fit, and eager to fly.  \r\nEach four and one-half weeks, a new group was sent in from the Classification Center to the Pre-Flight Pilot School and each class moved up. The upper class members would have their first actual practice in some of their training as they took charge of the new pilot students and got the new group settled. As the new group began their nine weeks\' course, the upper class moved into the final phase of their training before graduating to the Primary School.\r\n\r\n--Copied from www.wingsofhonor.org', 3),
(4, 'Primary Flying School', NULL, 'Primary Schools of the AAF Training Command were operated by civilian contractors who provided food, housing, and flying and ground school instruction for the cadet. The cadet\'s military training, as at college, was taken care of by a staff of Air Corps officers, who, in addition to \"keeping him on the ball,\" saw to it that his flying proficiency was up to standard. Then, after 65 hours in the air, and three times that many in classrooms, he was ready to go on to another step toward his coveted silver wings. \r\nIn Primary, a civilian instructor took the four or five cadets assigned to him to the flying line, pointed to a light, highly maneuverable craft, and said: \"Mister, that\'s an airplane; I teach you to fly that.\"  The planes were usually Stearman PT-13s or PT-17s, Fairchild PT-19s, PT-23s, or PT-26s or Ryan PT-22s.  \r\nFirst the cadet had to learn how to don a parachute, which was an art in itself.  He then climbed into the rear cockpit and sat down to look it over.  \r\nThere was no fancy communication system between the cadet and the instructor. Gosport tubes, which were rubber tubes through which the instructor could talk, provided one-way communications. There was no way for the cadet to talk back.   \r\nThe flight training began slowly, but accelerated to a rapid pace;  thirty minutes the first day, then an hour, then longer, and after from eight to twelve hours of dual instruction, the cadet could get into the airplane, take off, circle the field, make an approach, and land -- by himself. He learned about \"stages\", and traffic patterns. He would take the plane up and bring if down countless times.  \r\nThen he would receive hours of instruction in acrobatic maneuvers, map reading and cross-country flying.  Finally he was ready to go up alone and do chandelles, lazy-eights, loops, slow rolls, snap rolls and spins.  After a flight in the airplane, demonstrating to a “check pilot” that his performance was satisfactory commensurate with his level of training, the cadet was ready to go to Basic School.  \r\nA considerable number of all who entered the Primary Flying Schools never realized the dream of earning their “wings,” since they \"washed-out\" for lack of \"inherent flying ability.\" Thousands, however, did make the grade.\r\n--Copied from www.wingsofhonor.org', 4),
(5, 'Basic Flying School', NULL, 'In Primary the cadet learned to get off the ground, back down again, to fly straight and level. \r\nThe cadet goes to Basic and finds the cockpit of a BT-13 looks like the Grand Canyon full of alarm clocks. Soon, however, these instruments and the two-way radios became old familiar friends. In 70 hours of Basic he flies formations, learns maneuvers and the accurate precision flying of the airplane.  \r\nBy this time also, he has learned that there is such a thing as \"flaps,\" and has learned how to use them. With his hair standing on end he perceives there are times to use flaps and times not to use flaps.  \r\nAt Basic he makes his first sundown trek to the flight line, and, after many anxious moments, and by the light of the moon (if he is lucky) he shoves his plane up toward the constellations and realizes he is making his first night flight.  He makes night landings, starting on a floodlighted field and ending in semi-darkness.  \r\nIn Ground School, the cadet rehearses sending and receiving radio code and using blinker signals. He draws weather maps, interprets weather reports, studies cloud formations and \"fronts,\" and learns how to plot a course on the Sectional Chart and use a plotter and hand-held mechanical computer.  \r\nLink Trainer practice is emphasized and to supplement it, he takes cross-country navigation flights and \"team\" instrument rides in which one student, with a hood pulled over the cockpit, actually flies blind while a classmate in the front seat keeps his eyes alert for passing aircraft.  \r\nAfter that comes instrument training, and more night flights.  His time is taken up concentrating on navigation problems to prepare him for cross-country flights. \r\nHe is quite busy getting a firm hand on his tricky BT…. getting ready for the final check-ride before moving on to Advanced Flying School.   \r\nIn addition to more difficult flying technique, the cadet experiences an even harder military routine, his memory, constantly being polished up on matters of military discipline. \r\nAt the conclusion of Basic, the cadet is classified on the basis of his own preference and recommendations of his instructors as either a fighter pilot or for bomber training. If the former, he will go to a Single-Engine Advanced Training School. If he shows more aptitude for larger craft, he will go to Advanced Twin-Engine School.  \r\n--Copied from www.wingsofhonor.org', 5),
(6, 'Advanced Flying School', NULL, 'At the Advanced Single-Engine School the cadet becomes one of the Eagle\'s brood. He is strictly on his own. Soon he will be in a single-seater that moves like lightning and deals death the some way.He gets many hours flying the trim AT-6, driven by a 600-horsepower engine. He flies ground level and high altitudemissions, using oxygen, learns about dead reckoning, morenavigation and the thrill of combat tactics.  \r\nAnd, most important of all, it is at advanced school that the young pilot learns to shoot. He fires hundreds of rounds on the skeet range learning the rudiments of lead and deflection shooting. He spends many hours in a Link Trainer specially fitted with BB guns,firing at a moving target which speeds on a circular track. Toward the conclusion of his course he goes to a remote range where he spends two weeks shooting with cameras mounted on his airplane, and with actual Machine Gun bullets.  \r\nOn his return from each mission the films which he has taken in dogfights with his fellow cadets are analyzed, and the cadet can seewhether he was hitting or missing, and why.\r\nThe cadet\'s biggest day in advanced training comes when he climbs into the cockpit of a P-40 or P-39 and takes off.When he comes down he is ready and fit for his wings which he receives as he graduates, an Air Forces officer, from advanced school.  \r\nLike the aviation cadet in single engine schools, the eaglet in twin-engine advanced training reports to his field as a good pilot and leaves a first string team member for the Army Air Forces. His first task is to master the intricacies of flying a plane equipped with two sources of power.  \r\nBecause the bomber is essentially a long-range weapon, there is greater concentration on practice missions, navigation and instrument flying. The pilot learns to find his way despite storms, fog, wind or strange terrain.The radio beam becomes another old friend. He spends long hours in the classroom analyzing confidential reports from combat theaters in every part of the world.  \r\n--Copied from www.wingsofhonor.org', 6),
(7, 'Transition Flying School', 'Nine Weeks', 'On graduating from Twin-Engine Advanced School, the young officer, proudly wearing his newly-acquired wings, reports to Transition School, where for nine weeks he learns to fly the bomber which he will shortly use in action.  \r\nThe Flying Fortress, the Liberator, the B-25, or the B-26 becomes as familiar to him as his family\'s front porch at home. He learns to land and fly with one or more of his engines inoperative.He spends scores of hours on long distance navigation missions, flying his bomber through every type of weather to fields a thousand miles away from his home station. He continuously absorbs knowledge about his plane from instructors who have just returned from flying it in combat theaters. \r\n--Copied from www.wingsofhonor.org', 7);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `pkUser` int(11) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `age` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `role` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`pkUser`, `firstName`, `lastName`, `age`, `username`, `password`, `role`) VALUES
(1, 'admin', 'admin', 0, 'admin', 'admin', 0),
(2, 'Lawrence', 'Peczkowski-Soto', 20, 'law', '123', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `campaigns`
--
ALTER TABLE `campaigns`
  ADD PRIMARY KEY (`pkCampaign`);

--
-- Indexes for table `crews`
--
ALTER TABLE `crews`
  ADD PRIMARY KEY (`pkCrew`),
  ADD KEY `fkSchool` (`trainingSchool`);

--
-- Indexes for table `crewspercampaign`
--
ALTER TABLE `crewspercampaign`
  ADD PRIMARY KEY (`pkCrewsPerCampaign`);

--
-- Indexes for table `feed_event`
--
ALTER TABLE `feed_event`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `people`
--
ALTER TABLE `people`
  ADD PRIMARY KEY (`pkPerson`);

--
-- Indexes for table `relationships`
--
ALTER TABLE `relationships`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trainingschool`
--
ALTER TABLE `trainingschool`
  ADD PRIMARY KEY (`pkSchool`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`pkUser`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `campaigns`
--
ALTER TABLE `campaigns`
  MODIFY `pkCampaign` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `crews`
--
ALTER TABLE `crews`
  MODIFY `pkCrew` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `crewspercampaign`
--
ALTER TABLE `crewspercampaign`
  MODIFY `pkCrewsPerCampaign` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `feed_event`
--
ALTER TABLE `feed_event`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `people`
--
ALTER TABLE `people`
  MODIFY `pkPerson` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `relationships`
--
ALTER TABLE `relationships`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trainingschool`
--
ALTER TABLE `trainingschool`
  MODIFY `pkSchool` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `pkUser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `crews`
--
ALTER TABLE `crews`
  ADD CONSTRAINT `fkSchool` FOREIGN KEY (`trainingSchool`) REFERENCES `trainingschool` (`pkSchool`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
