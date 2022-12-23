use vaxchi;

CREATE TABLE IF NOT EXISTS `vaxchi`.`dim_zipcode` (
  `zipcode_id` SMALLINT(3) NOT NULL AUTO_INCREMENT,
  `zipcode` INT NOT NULL,
  `population` INT NULL,
  `city` CHAR(7) NOT NULL,
  `state` CHAR(2) NOT NULL,
  PRIMARY KEY (`zipcode_id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `vaxchi`.`dim_ccvi` (
  `ccvi_id` SMALLINT(3) NOT NULL AUTO_INCREMENT,
  `zipcode_id` SMALLINT(3) NOT NULL,
  `ccvi_score` FLOAT NOT NULL,
  `ccvi_category` CHAR(6) NOT NULL,
  PRIMARY KEY (`ccvi_id`),
  INDEX `fk_dim_ccvi_dim_zipcode1_idx` (`zipcode_id` ASC) VISIBLE,
  CONSTRAINT `fk_dim_ccvi_dim_zipcode1`
    FOREIGN KEY (`zipcode_id`)
    REFERENCES `vaxchi`.`dim_zipcode` (`zipcode_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

DROP TABLE `vaxchi`.`dim_test_loc`;

CREATE TABLE IF NOT EXISTS `vaxchi`.`dim_test_loc` (
  `test_facility_id` SMALLINT(4) NOT NULL AUTO_INCREMENT,
  `zipcode_id` SMALLINT(3) NOT NULL,
  `facility_test_name` VARCHAR(500) NOT NULL,
  `address_test` VARCHAR(45) NOT NULL,
  `phone_test` VARCHAR(45) NULL,
  `web_site_test` VARCHAR(500) NULL,
  INDEX `fk_dim_test_loc_dim_zipcode1_idx` (`zipcode_id` ASC) VISIBLE,
  PRIMARY KEY (`test_facility_id`),
  CONSTRAINT `fk_dim_test_loc_dim_zipcode1`
    FOREIGN KEY (`zipcode_id`)
    REFERENCES `vaxchi`.`dim_zipcode` (`zipcode_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDBdate;

CREATE TABLE IF NOT EXISTS `vaxchi`.`dim_vax_loc` (
  `vax_facility_id` SMALLINT(4) NOT NULL AUTO_INCREMENT,
  `zipcode_id` SMALLINT(3) NOT NULL,
  `facility_vax_name` VARCHAR(45) NOT NULL,
  `address_vax` VARCHAR(45) NOT NULL,
  `website_vax` VARCHAR(45) NULL,
  `phone_vax` INT NULL,
  INDEX `fk_dim_vac_loc_dim_zipcode1_idx` (`zipcode_id` ASC) VISIBLE,
  PRIMARY KEY (`vax_facility_id`),
  CONSTRAINT `fk_dim_vac_loc_dim_zipcode1`
    FOREIGN KEY (`zipcode_id`)
    REFERENCES `vaxchi`.`dim_zipcode` (`zipcode_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

ALTER TABLE vaxchi.dim_vax_loc
MODIFY COLUMN phone_vax VARCHAR(45);

ALTER TABLE vaxchi.dim_vax_loc
MODIFY COLUMN website_vax VARCHAR(500);

ALTER TABLE vaxchi.dim_vax_loc
MODIFY COLUMN facility_vax_name VARCHAR(500);

CREATE TABLE IF NOT EXISTS `vaxchi`.`dim_date` (
  `date_id` SMALLINT(3) NOT NULL AUTO_INCREMENT,
  `month` VARCHAR(45) NOT NULL,
  `year` INT NOT NULL,
  `full_date` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`date_id`))
ENGINE = InnoDB;

ALTER TABLE `vaxchi`.`dim_date`
MODIFY COLUMN `full_date` VARCHAR(45);


DROP TABLE `vaxchi`.`fact_vaxchi`;

CREATE TABLE IF NOT EXISTS `vaxchi`.`fact_vaxchi` (
  `vaxchi_id` SMALLINT(5) NOT NULL AUTO_INCREMENT,
  `zipcode_id` SMALLINT(3) NOT NULL,
  `date_id` SMALLINT(3) NOT NULL,
  `sum_total_first_doses` INT NOT NULL,
  `sum_total_second_doses` INT NOT NULL,
  `sum_first_doses_5_11` INT NOT NULL,
  `sum_first_doses_12_17` INT NOT NULL,
  `sum_first_doses_18_64` INT NOT NULL,
  `sum_first_doses_65_plus` INT NOT NULL,
  `sum_second_dose_5_11` INT NOT NULL,
  `sum_second_dose_12_17` INT NOT NULL,
  `sum_second_dose_18_64` INT NOT NULL,
  `sum_second_dose_65_plus` INT NOT NULL,
  `sum_covid_cases` INT NULL,
  `sum_covid_tests` INT NULL,
  `sum_covid_deaths` INT NOT NULL,
  PRIMARY KEY (`vaxchi_id`),
  INDEX `fk_fact_vaxchi_dim_zipcode_idx` (`zipcode_id` ASC) VISIBLE,
  INDEX `fk_fact_vaxchi_dim_month1_idx` (`date_id` ASC) VISIBLE,
  CONSTRAINT `fk_fact_vaxchi_dim_zipcode`
    FOREIGN KEY (`zipcode_id`)
    REFERENCES `vaxchi`.`dim_zipcode` (`zipcode_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_vaxchi_dim_month1`
    FOREIGN KEY (`date_id`)
    REFERENCES `vaxchi`.`dim_date` (`date_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
