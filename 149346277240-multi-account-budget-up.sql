-- direction: up
-- backref: 148893024530
-- ref: 149346277240


ALTER TABLE `bank`.`budget`
CHANGE COLUMN `compte` `compte` VARCHAR(255) NOT NULL AFTER `month`,
CHANGE COLUMN `credit` `credit` DECIMAL(15,2) NOT NULL DEFAULT '0.00' AFTER `catego`,
CHANGE COLUMN `catego` `catego` VARCHAR(255) NOT NULL ;



ALTER TABLE `bank`.`compte`
DROP COLUMN `courant`,
ADD COLUMN `type` VARCHAR(45) NOT NULL DEFAULT 'CHECKING' AFTER `nom`;


ALTER TABLE `bank`.`budget`
DROP COLUMN `notes`,
DROP COLUMN `id`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`year`, `month`, `compte`, `catego`);
