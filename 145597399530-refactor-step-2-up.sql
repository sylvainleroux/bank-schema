-- direction: up
-- backref: 145597306340
-- ref: 145597399530

ALTER TABLE `bank`.`operation`
DROP COLUMN `month_adjusted`,
DROP COLUMN `month_bank`,
DROP COLUMN `montant`,
DROP INDEX `UNIQUE` ,
ADD UNIQUE INDEX `UNIQUE` (`compte` ASC, `date_operation` ASC, `date_valeur` ASC, `libelle` ASC, `debit` ASC, `credit` ASC),
DROP INDEX `YEAR_MONTH_CATEGO` ;
