# RexshackGaming
- discord : https://discord.gg/YUV7ebzkqs
- youtube : https://www.youtube.com/@rexshack/videos
- tebex store : https://rexshackgaming.tebex.io/
- support me : https://ko-fi.com/rexshackgaming

# Dependancies
- rsg-core
- rsg-target
- ox_lib
- rsg-bossmenu

# Installation
- ensure that the dependancies are added and started
- add rsg-houses to your resources folder
- add the sql file "rex-houses.sql" to your database

# Jobs Setup
- ensure the following Jobs have been setup rsg-core/shared/jobs.lua

```lua
    ['govenor1'] = {
        label = 'Govenor New Hanover',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Govenor',
                payment = 100
            },
        },
    },
    ['govenor2'] = {
        label = 'Govenor West Elizabeth',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Govenor',
                payment = 100
            },
        },
    },
    ['govenor3'] = {
        label = 'Govenor New Austin',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Govenor',
                payment = 100
            },
        },
    },
    ['govenor4'] = {
        label = 'Govenor Ambarino',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Govenor',
                payment = 100
            },
        },
    },
    ['govenor5'] = {
        label = 'Govenor Lemoyne',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Govenor',
                payment = 100
            },
        },
    },
```

# sql
```sql
CREATE TABLE IF NOT EXISTS `rex_houses` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `agent` varchar(30) NOT NULL,
    `houseid` varchar(7) NOT NULL DEFAULT '0',
    `citizenid` varchar(50) NOT NULL DEFAULT '0',
    `fullname` varchar(255) NOT NULL DEFAULT '0',
    `owned` tinyint(4) NOT NULL DEFAULT 0,
    `price` int(11) NOT NULL DEFAULT 0,
    `credit` int(11) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `rex_houses` (`id`, `agent`, `houseid`, `citizenid`, `owned`, `price`, `credit`) VALUES
(1, 'newhanover', 'house1', '0', 0, 3000, 0),
(2, 'westelizabeth', 'house2', '0', 0, 4000, 0),
(3, 'newhanover', 'house3', '0', 0, 2000, 0),
(4, 'lemoyne', 'house4', '0', 0, 4000, 0),
(5, 'lemoyne', 'house5', '0', 0, 3000, 0),
(6, 'lemoyne', 'house6', '0', 0, 2000, 0),
(7, 'newaustin', 'house7', '0', 0, 2000, 0),
(8, 'newhanover', 'house8', '0', 0, 4000, 0),
(9, 'newhanover', 'house9', '0', 0, 1000, 0),
(10, 'newhanover', 'house10', '0', 0, 4000, 0),
(11, 'lemoyne', 'house11', '0', 0, 4000, 0),
(12, 'lemoyne', 'house12', '0', 0, 4000, 0),
(13, 'lemoyne', 'house13', '0', 0, 5000, 0),
(14, 'lemoyne', 'house14', '0', 0, 4000, 0),
(15, 'lemoyne', 'house15', '0', 0, 2000, 0),
(16, 'lemoyne', 'house16', '0', 0, 3000, 0),
(17, 'newhanover', 'house17', '0', 0, 3000, 0),
(18, 'newhanover', 'house18', '0', 0, 4000, 0),
(19, 'newhanover', 'house19', '0', 0, 500, 0),
(20, 'ambarino', 'house20', '0', 0, 3000, 0),
(21, 'newhanover', 'house21', '0', 0, 2500, 0),
(22, 'ambarino', 'house22', '0', 0, 2000, 0),
(23, 'ambarino', 'house23', '0', 0, 2500, 0),
(24, 'ambarino', 'house24', '0', 0, 1000, 0),
(25, 'westelizabeth', 'house25', '0', 0, 2000, 0),
(26, 'westelizabeth', 'house26', '0', 0, 3500, 0),
(27, 'westelizabeth', 'house27', '0', 0, 1250, 0),
(28, 'westelizabeth', 'house28', '0', 0, 1500, 0),
(29, 'newaustin', 'house29', '0', 0, 1000, 0),
(30, 'newaustin', 'house30', '0', 0, 4000, 0),
(31, 'newaustin', 'house31', '0', 0, 1500, 0),
(32, 'newaustin', 'house32', '0', 0, 1500, 0),
(33, 'newaustin', 'house33', '0', 0, 1250, 0),
(34, 'ambarino', 'house34', '0', 0, 1000, 0),
(35, 'ambarino', 'house35', '0', 0, 1000, 0),
(36, 'newhanover', 'house36', '0', 0, 2000, 0),
(37, 'ambarino', 'house37', '0', 0, 3000, 0),
(38, 'newhanover', 'house38', '0', 0, 750, 0),
(39, 'newhanover', 'house39', '0', 0, 2000, 0),
(40, 'lemoyne', 'house40', '0', 0, 1300, 0),
(41, 'lemoyne', 'house41', '0', 0, 0, 0),
(42, 'ambarino', 'house42', '0', 0, 2500, 0),
(43, 'newaustin', 'house43', '0', 0, 2500, 0),
(44, 'newhanover', 'house44', '0', 0, 3000, 0),
(45, 'lemoyne', 'house45', '0', 0, 10000, 0),
(46, 'westelizabeth', 'house46', '0', 0, 2000, 0);

CREATE TABLE IF NOT EXISTS `rex_housekeys` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `houseid` varchar(7) NOT NULL DEFAULT '0',
    `citizenid` varchar(50) NOT NULL DEFAULT '0',
    `guest` int(1) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `rex_doors` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `doorid` varchar(11) NOT NULL DEFAULT '0',
    `doorstate` int(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `rex_doors` (`doorid`, `doorstate`) VALUES
('3598523785', 1),
('2031215067', 1),
('1189146288', 1),
('906448125', 1),
('2821676992', 1),
('1510914117', 1),
('3549587335', 1),
('3000692149', 1),
('1928053488', 1),
('772977516', 1),
('527767089', 1),
('3468185317', 1),
('2779142555', 1),
('1239033969', 1),
('1597362984', 1),
('1299456376', 1),
('2933656395', 1),
('3238637478', 1),
('3544613794', 1),
('1485561723', 1),
('1511858696', 1),
('1282705079', 1),
('2238665296', 1),
('2080980868', 1),
('2700347737', 1),
('2544301759', 1),
('3720952508', 1),
('350169319', 1),
('984852093', 1),
('3473362722', 1),
('686097120', 1),
('3107660458', 1),
('3419719645', 1),
('3945582303', 1),
('862008394', 1),
('1661737397', 1),
('1574473390', 1),
('3731688048', 1),
('344028824', 1),
('2652873387', 1),
('2061942857', 1),
('3702071668', 1),
('1934463007', 1),
('2183007198', 1),
('4288310487', 1),
('872775928', 1),
('2385374047', 1),
('2051127971', 1),
('3167436574', 1),
('1195519038', 1),
('2212914984', 1),
('562830153', 1),
('663425326', 1),
('1171581101', 1),
('52014802', 1),
('4164042403', 1),
('2047072501', 1),
('2715667864', 1),
('1263476860', 1),
('1894337720', 1),
('120764251', 1),
('943176298', 1),
('2971757040', 1),
('1973911195', 1),
('784290387', 1),
('843137708', 1),
('4275653891', 1),
('1431398235', 1),
('896012811', 1),
('2813949612', 1),
('868379185', 1),
('640077562', 1),
('3045682143', 1),
('1915887592', 1),
('3324299212', 1),
('1180868565', 1),
('1535511805', 1),
('2395304827', 1);
```

# Starting the resource
- add the following to your server.cfg file : ensure rex-houses
