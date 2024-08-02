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
    `houseid` varchar(11) NOT NULL DEFAULT '0',
    `doorstate` int(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `rex_doors` (`doorid`, `houseid`, `doorstate`) VALUES
('3598523785', 'house1', 1),
('2031215067', 'house1', 1),
('1189146288', 'house2', 1),
('906448125', 'house2', 1),
('2821676992', 'house3', 1),
('1510914117', 'house3', 1),
('3549587335', 'house4', 1),
('3000692149', 'house4', 1),
('3782668011', 'house4', 1),
('1928053488', 'house4', 1),
('772977516', 'house5', 1),
('527767089', 'house5', 1),
('3468185317', 'house6', 1),
('2779142555', 'house7', 1),
('1239033969', 'house8', 1),
('1597362984', 'house8', 1),
('1299456376', 'house9', 1),
('2933656395', 'house10', 1),
('3238637478', 'house10', 1),
('3544613794', 'house11', 1),
('1485561723', 'house11', 1),
('1511858696', 'house12', 1),
('1282705079', 'house12', 1),
('2238665296', 'house13', 1),
('2080980868', 'house13', 1),
('2700347737', 'house13', 1),
('2544301759', 'house13', 1),
('3720952508', 'house13', 1),
('350169319', 'house13', 1),
('984852093', 'house14', 1),
('3473362722', 'house14', 1),
('686097120', 'house14', 1),
('3107660458', 'house14', 1),
('3419719645', 'house14', 1),
('3945582303', 'house15', 1),
('862008394', 'house15', 1),
('1661737397', 'house16', 1),
('1574473390', 'house17', 1),
('3731688048', 'house18', 1),
('344028824', 'house18', 1),
('2652873387', 'house19', 1),
('2061942857', 'house19', 1),
('3702071668', 'house20', 1),
('1934463007', 'house21', 1),
('2183007198', 'house22', 1),
('4288310487', 'house22', 1),
('872775928', 'house23', 1),
('2385374047', 'house23', 1),
('2051127971', 'house23', 1),
('3167436574', 'house24', 1),
('1195519038', 'house25', 1),
('2212914984', 'house26', 1),
('562830153', 'house27', 1),
('663425326', 'house27', 1),
('1171581101', 'house28', 1),
('52014802', 'house29', 1),
('4164042403', 'house30', 1),
('2047072501', 'house31', 1),
('2715667864', 'house32', 1),
('1263476860', 'house32', 1),
('1894337720', 'house33', 1),
('120764251', 'house33', 1),
('943176298', 'house34', 1),
('2971757040', 'house35', 1),
('1973911195', 'house36', 1),
('784290387', 'house37', 1),
('843137708', 'house38', 1),
('4275653891', 'house39', 1),
('1431398235', 'house39', 1),
('896012811', 'house40', 1),
('2813949612', 'house40', 1),
('868379185', 'house42', 1),
('640077562', 'house42', 1),
('3045682143', 'house43', 1),
('1915887592', 'house44', 1),
('3324299212', 'house44', 1),
('1180868565', 'house45', 1),
('1535511805', 'house46', 1),
('2395304827', 'house46', 1);
```

# Starting the resource
- add the following to your server.cfg file : ensure rex-houses
