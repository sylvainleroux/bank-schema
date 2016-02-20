-- direction: down
-- backref: 145597306340
-- ref: 145597399530


ALTER TABLE `bank`.`operation`
  ADD COLUMN `montant` decimal(15,2) NULL AFTER `libelle`,
  ADD COLUMN `month_bank` INT(11) NULL AFTER `month`,
  ADD COLUMN `month_adjusted` INT(11) NULL AFTER `month_bank`,
  DROP INDEX `UNIQUE` ,
  ADD UNIQUE INDEX `UNIQUE` (`compte` ASC, `date_operation` ASC, `date_valeur` ASC, `libelle` ASC, `montant`),
  ADD INDEX `YEAR_MONTH_CATEGO` (`year` ASC, `month_adjusted` ASC, `catego` ASC);
