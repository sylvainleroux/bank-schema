-- direction: down
-- backref: 145487256030
-- ref: 145592999800

USE `bank`;
CREATE 
     OR REPLACE ALGORITHM = UNDEFINED 
    DEFINER = `sleroux`@`%` 
    SQL SECURITY DEFINER
VIEW `diff` AS
    select 
        `O`.`year` AS `year`,
        `O`.`month_adjusted` AS `month`,
        `O`.`catego` AS `catego`,
        sum((`O`.`montant` * (`O`.`montant` > 0))) AS `ops_credit`,
        sum((-(`O`.`montant`) * (`O`.`montant` < 0))) AS `ops_debit`,
        if((`B`.`credit` > 0), `B`.`credit`, 0) AS `bud_credit`,
        if((`B`.`debit` > 0), `B`.`debit`, 0) AS `bud_debit`,
        if(((`B`.`credit` > 0)
                or (sum((`O`.`montant` * (`O`.`montant` > 0))) > 0)),
            1,
            0) AS `is_credit`
    from
        (`operation` `O`
        left join `budget` `B` ON (((`B`.`year` = `O`.`year`)
            and (`B`.`month` = `O`.`month_adjusted`)
            and (`B`.`catego` = `O`.`catego`))))
    where
        ((`B`.`compte` = _latin1'COURANT')
            or isnull(`B`.`compte`))
    group by `O`.`year` , `O`.`month_adjusted` , `O`.`catego` 
    union all select 
        `B`.`year` AS `year`,
        `B`.`month` AS `month`,
        `B`.`catego` AS `catego`,
        0 AS `0`,
        0 AS `0`,
        `B`.`credit` AS `credit`,
        `B`.`debit` AS `debit`,
        if((`B`.`credit` > 0), 1, 0) AS `is_credit`
    from
        (`budget` `B`
        left join `operation` `O` ON (((`B`.`year` = `O`.`year`)
            and (`B`.`month` = `O`.`month_adjusted`)
            and (`B`.`catego` = `O`.`catego`))))
    where
        isnull(`O`.`catego`)
    group by `B`.`year` , `B`.`month` , `B`.`catego`
    order by `year` , `month` , `is_credit` desc;


