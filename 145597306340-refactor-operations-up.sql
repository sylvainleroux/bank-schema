-- direction: up
-- backref: 145487256030
-- ref: 145597306340

ALTER TABLE `bank`.`operation`
ADD COLUMN `debit` DECIMAL(15,2) NOT NULL DEFAULT 0 AFTER `month_adjusted`,
ADD COLUMN `credit` DECIMAL(15,2) NOT NULL DEFAULT 0 AFTER `debit`,
ADD COLUMN `month` VARCHAR(45) NULL AFTER `credit`,
ADD INDEX `YEAR_MONTH_CATEGO_N` (`year` ASC, `month` ASC, `catego` ASC);

update bank.operation
  set credit = if (montant > 0, montant, 0),
  debit = if (montant < 0, -montant, 0),
  month = month_adjusted;
