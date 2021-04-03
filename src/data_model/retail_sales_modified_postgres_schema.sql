
DROP SCHEMA IF EXISTS rsa ;

-- -----------------------------------------------------
-- Schema rsa
-- -----------------------------------------------------
CREATE SCHEMA rsa
    AUTHORIZATION postgres;
	
set schema rsa;

-- -----------------------------------------------------
-- Table rsa.sales_channel
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS rsa.sales_channel (
  sc_channel_sk INT NOT NULL,
  sc_channel_id CHAR(16) NOT NULL,
  sc_channel_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (sc_channel_sk));

CREATE UNIQUE INDEX sc_udx ON rsa.sales_channel (sc_channel_id);
	

-- -----------------------------------------------------
-- Table rsa.customer_address
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS rsa.customer_address (
  ca_address_sk INT NOT NULL,
  ca_address_id CHAR(16) NOT NULL,
  ca_street_number CHAR(10) NULL DEFAULT NULL,
  ca_street_name VARCHAR(60) NULL DEFAULT NULL,
  ca_street_type CHAR(15) NULL DEFAULT NULL,
  ca_suite_number CHAR(10) NULL DEFAULT NULL,
  ca_city VARCHAR(60) NULL DEFAULT NULL,
  ca_county VARCHAR(30) NULL DEFAULT NULL,
  ca_state CHAR(2) NULL DEFAULT NULL,
  ca_zip CHAR(10) NULL DEFAULT NULL,
  ca_country VARCHAR(20) NULL DEFAULT NULL,
  ca_gmt_offset DECIMAL(5,2) NULL DEFAULT NULL,
  ca_location_type CHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (ca_address_sk));

-- -----------------------------------------------------
-- Table rsa.customer_demographics
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS rsa.customer_demographics (
  cd_demo_sk INT NOT NULL,
  cd_gender CHAR(1) NULL DEFAULT NULL,
  cd_marital_status CHAR(1) NULL DEFAULT NULL,
  cd_education_status CHAR(20) NULL DEFAULT NULL,
  cd_purchase_estimate INT NULL DEFAULT NULL,
  cd_credit_rating CHAR(10) NULL DEFAULT NULL,
  cd_dep_count INT NULL DEFAULT NULL,
  cd_dep_employed_count INT NULL DEFAULT NULL,
  cd_dep_college_count INT NULL DEFAULT NULL,
  PRIMARY KEY (cd_demo_sk));

-- -----------------------------------------------------
-- Table rsa.income_band
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS rsa.income_band (
  ib_income_band_sk INT NOT NULL,
  ib_lower_bound INT NULL DEFAULT NULL,
  ib_upper_bound INT NULL DEFAULT NULL,
  PRIMARY KEY (ib_income_band_sk));

-- -----------------------------------------------------
-- Table rsa.household_demographics
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS rsa.household_demographics (
  hd_demo_sk INT NOT NULL,
  hd_income_band_sk INT NULL DEFAULT NULL,
  hd_buy_potential CHAR(15) NULL DEFAULT NULL,
  hd_dep_count INT NULL DEFAULT NULL,
  hd_vehicle_count INT NULL DEFAULT NULL,
  PRIMARY KEY (hd_demo_sk),
  CONSTRAINT hd_ib
    FOREIGN KEY (hd_income_band_sk)
    REFERENCES rsa.income_band (ib_income_band_sk));

CREATE INDEX hd_ib ON rsa.household_demographics (hd_income_band_sk);
-- -----------------------------------------------------
-- Table rsa.customer
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS rsa.customer (
  c_customer_sk INT NOT NULL,
  c_customer_id CHAR(16) NOT NULL,
  c_current_cdemo_sk INT NULL DEFAULT NULL,
  c_current_hdemo_sk INT NULL DEFAULT NULL,
  c_current_addr_sk INT NULL DEFAULT NULL,
  c_salutation CHAR(10) NULL DEFAULT NULL,
  c_first_name CHAR(20) NULL DEFAULT NULL,
  c_last_name CHAR(30) NULL DEFAULT NULL,
  c_preferred_cust_flag CHAR(1) NULL DEFAULT NULL,
  c_birth_day INT NULL DEFAULT NULL,
  c_birth_month INT NULL DEFAULT NULL,
  c_birth_year INT NULL DEFAULT NULL,
  c_birth_country VARCHAR(20) NULL DEFAULT NULL,
  c_login CHAR(13) NULL DEFAULT NULL,
  c_email_address CHAR(50) NULL DEFAULT NULL,
  c_last_review_date_sk INT NULL DEFAULT NULL,
  PRIMARY KEY (c_customer_sk),
  CONSTRAINT c_a
    FOREIGN KEY (c_current_addr_sk)
    REFERENCES rsa.customer_address (ca_address_sk),
  CONSTRAINT c_cd
    FOREIGN KEY (c_current_cdemo_sk)
    REFERENCES rsa.customer_demographics (cd_demo_sk),
  CONSTRAINT c_hd
    FOREIGN KEY (c_current_hdemo_sk)
    REFERENCES rsa.household_demographics (hd_demo_sk));

  CREATE INDEX c_a ON rsa.customer (c_current_addr_sk ASC);
  CREATE INDEX c_cd ON rsa.customer(c_current_cdemo_sk ASC);
  CREATE INDEX c_hd ON rsa.customer(c_current_hdemo_sk ASC);

-- -----------------------------------------------------
-- Table rsa.date_dim
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS rsa.date_dim (
  d_date_sk INT NOT NULL,
  d_date_id CHAR(16) NOT NULL,
  d_date DATE NULL DEFAULT NULL,
  d_month_seq INT NULL DEFAULT NULL,
  d_week_seq INT NULL DEFAULT NULL,
  d_quarter_seq INT NULL DEFAULT NULL,
  d_year INT NULL DEFAULT NULL,
  d_dow INT NULL DEFAULT NULL,
  d_moy INT NULL DEFAULT NULL,
  d_dom INT NULL DEFAULT NULL,
  d_qoy INT NULL DEFAULT NULL,
  d_fy_year INT NULL DEFAULT NULL,
  d_fy_quarter_seq INT NULL DEFAULT NULL,
  d_fy_week_seq INT NULL DEFAULT NULL,
  d_day_name CHAR(9) NULL DEFAULT NULL,
  d_quarter_name CHAR(6) NULL DEFAULT NULL,
  d_holiday CHAR(1) NULL DEFAULT NULL,
  d_weekend CHAR(1) NULL DEFAULT NULL,
  d_following_holiday CHAR(1) NULL DEFAULT NULL,
  d_first_dom INT NULL DEFAULT NULL,
  d_last_dom INT NULL DEFAULT NULL,
  d_same_day_ly INT NULL DEFAULT NULL,
  d_same_day_lq INT NULL DEFAULT NULL,
  d_current_day CHAR(1) NULL DEFAULT NULL,
  d_current_week CHAR(1) NULL DEFAULT NULL,
  d_current_month CHAR(1) NULL DEFAULT NULL,
  d_current_quarter CHAR(1) NULL DEFAULT NULL,
  d_current_year CHAR(1) NULL DEFAULT NULL,
  PRIMARY KEY (d_date_sk));

-- -----------------------------------------------------
-- Table rsa.item
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS rsa.item (
  i_item_sk INT NOT NULL,
  i_item_id CHAR(16) NOT NULL,
  i_rec_start_date DATE NULL DEFAULT NULL,
  i_rec_end_date DATE NULL DEFAULT NULL,
  i_item_desc VARCHAR(200) NULL DEFAULT NULL,
  i_current_price DECIMAL(7,2) NULL DEFAULT NULL,
  i_wholesale_cost DECIMAL(7,2) NULL DEFAULT NULL,
  i_brand_id INT NULL DEFAULT NULL,
  i_brand CHAR(50) NULL DEFAULT NULL,
  i_class_id INT NULL DEFAULT NULL,
  i_class CHAR(50) NULL DEFAULT NULL,
  i_category_id INT NULL DEFAULT NULL,
  i_category CHAR(50) NULL DEFAULT NULL,
  i_manufact_id INT NULL DEFAULT NULL,
  i_manufact CHAR(50) NULL DEFAULT NULL,
  i_size CHAR(20) NULL DEFAULT NULL,
  i_formulation CHAR(20) NULL DEFAULT NULL,
  i_color CHAR(20) NULL DEFAULT NULL,
  i_units CHAR(10) NULL DEFAULT NULL,
  i_container CHAR(10) NULL DEFAULT NULL,
  i_manager_id INT NULL DEFAULT NULL,
  i_product_name CHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (i_item_sk));

-- -----------------------------------------------------
-- Table rsa.promotion
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS rsa.promotion (
  p_promo_sk INT NOT NULL,
  p_promo_id CHAR(16) NOT NULL,
  p_start_date_sk INT NULL DEFAULT NULL,
  p_end_date_sk INT NULL DEFAULT NULL,
  p_item_sk INT NULL DEFAULT NULL,
  p_cost DECIMAL(15,2) NULL DEFAULT NULL,
  p_response_target INT NULL DEFAULT NULL,
  p_promo_name CHAR(50) NULL DEFAULT NULL,
  p_channel_dmail CHAR(1) NULL DEFAULT NULL,
  p_channel_email CHAR(1) NULL DEFAULT NULL,
  p_channel_catalog CHAR(1) NULL DEFAULT NULL,
  p_channel_tv CHAR(1) NULL DEFAULT NULL,
  p_channel_radio CHAR(1) NULL DEFAULT NULL,
  p_channel_press CHAR(1) NULL DEFAULT NULL,
  p_channel_event CHAR(1) NULL DEFAULT NULL,
  p_channel_demo CHAR(1) NULL DEFAULT NULL,
  p_channel_details VARCHAR(100) NULL DEFAULT NULL,
  p_purpose CHAR(15) NULL DEFAULT NULL,
  p_discount_active CHAR(1) NULL DEFAULT NULL,
  PRIMARY KEY (p_promo_sk),
  CONSTRAINT p_end_date
    FOREIGN KEY (p_end_date_sk)
    REFERENCES rsa.date_dim (d_date_sk),
  CONSTRAINT p_i
    FOREIGN KEY (p_item_sk)
    REFERENCES rsa.item (i_item_sk),
  CONSTRAINT p_start_date
    FOREIGN KEY (p_start_date_sk)
    REFERENCES rsa.date_dim (d_date_sk));

CREATE  INDEX p_end_date ON rsa.promotion(p_end_date_sk ASC);
CREATE  INDEX p_i ON rsa.promotion (p_item_sk ASC);
CREATE  INDEX p_start_date ON rsa.promotion(p_start_date_sk ASC);



-- -----------------------------------------------------
-- Table rsa.store
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS rsa.store (
  s_store_sk INT NOT NULL,
  s_store_id CHAR(16) NOT NULL,
  s_rec_start_date DATE NULL DEFAULT NULL,
  s_rec_end_date DATE NULL DEFAULT NULL,
  s_store_name VARCHAR(50) NULL DEFAULT NULL,
  s_number_employees INT NULL DEFAULT NULL,
  s_floor_space INT NULL DEFAULT NULL,
  s_hours CHAR(20) NULL DEFAULT NULL,
  s_manager VARCHAR(40) NULL DEFAULT NULL,
  s_market_id INT NULL DEFAULT NULL,
  s_geography_class VARCHAR(100) NULL DEFAULT NULL,
  s_market_desc VARCHAR(100) NULL DEFAULT NULL,
  s_market_manager VARCHAR(40) NULL DEFAULT NULL,
  s_division_id INT NULL DEFAULT NULL,
  s_division_name VARCHAR(50) NULL DEFAULT NULL,
  s_company_id INT NULL DEFAULT NULL,
  s_company_name VARCHAR(50) NULL DEFAULT NULL,
  s_street_number VARCHAR(10) NULL DEFAULT NULL,
  s_street_name VARCHAR(60) NULL DEFAULT NULL,
  s_street_type CHAR(15) NULL DEFAULT NULL,
  s_suite_number CHAR(10) NULL DEFAULT NULL,
  s_city VARCHAR(60) NULL DEFAULT NULL,
  s_county VARCHAR(30) NULL DEFAULT NULL,
  s_state CHAR(2) NULL DEFAULT NULL,
  s_zip CHAR(10) NULL DEFAULT NULL,
  s_country VARCHAR(20) NULL DEFAULT NULL,
  s_gmt_offset DECIMAL(5,2) NULL DEFAULT NULL,
  s_tax_precentage DECIMAL(5,2) NULL DEFAULT NULL,
  PRIMARY KEY (s_store_sk));

-- -----------------------------------------------------
-- Table rsa.time_dim
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS rsa.time_dim (
  t_time_sk INT NOT NULL,
  t_time_id CHAR(16) NOT NULL,
  t_time INT NULL DEFAULT NULL,
  t_hour INT NULL DEFAULT NULL,
  t_minute INT NULL DEFAULT NULL,
  t_second INT NULL DEFAULT NULL,
  t_am_pm CHAR(2) NULL DEFAULT NULL,
  t_shift CHAR(20) NULL DEFAULT NULL,
  t_sub_shift CHAR(20) NULL DEFAULT NULL,
  t_meal_time CHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (t_time_sk));

-- -----------------------------------------------------
-- Table rsa.store_sales
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS rsa.store_sales (
  ss_sold_date_sk INT NULL DEFAULT NULL,
  ss_sold_time_sk INT NULL DEFAULT NULL,
  ss_item_sk INT NOT NULL,
  ss_customer_sk INT NULL DEFAULT NULL,
  ss_cdemo_sk INT NULL DEFAULT NULL,
  ss_hdemo_sk INT NULL DEFAULT NULL,
  ss_addr_sk INT NULL DEFAULT NULL,
  ss_store_sk INT NULL DEFAULT NULL,
  ss_promo_sk INT NULL DEFAULT NULL,
  ss_order_number INT NOT NULL,
  ss_channel_sk INT NULL,
  ss_quantity INT NULL DEFAULT NULL,
  ss_wholesale_cost DECIMAL(7,2) NULL DEFAULT NULL,
  ss_list_price DECIMAL(7,2) NULL DEFAULT NULL,
  ss_sales_price DECIMAL(7,2) NULL DEFAULT NULL,
  ss_ext_discount_amt DECIMAL(7,2) NULL DEFAULT NULL,
  ss_ext_sales_price DECIMAL(7,2) NULL DEFAULT NULL,
  ss_ext_wholesale_cost DECIMAL(7,2) NULL DEFAULT NULL,
  ss_ext_list_price DECIMAL(7,2) NULL DEFAULT NULL,
  ss_ext_tax DECIMAL(7,2) NULL DEFAULT NULL,
  ss_coupon_amt DECIMAL(7,2) NULL DEFAULT NULL,
  ss_net_paid DECIMAL(7,2) NULL DEFAULT NULL,
  ss_net_paid_inc_tax DECIMAL(7,2) NULL DEFAULT NULL,
  ss_net_profit DECIMAL(7,2) NULL DEFAULT NULL,
  PRIMARY KEY (ss_item_sk, ss_order_number),
  CONSTRAINT ss_a
    FOREIGN KEY (ss_addr_sk)
    REFERENCES rsa.customer_address (ca_address_sk),
  CONSTRAINT ss_c
    FOREIGN KEY (ss_customer_sk)
    REFERENCES rsa.customer (c_customer_sk),
  CONSTRAINT ss_cd
    FOREIGN KEY (ss_cdemo_sk)
    REFERENCES rsa.customer_demographics (cd_demo_sk),
  CONSTRAINT ss_d
    FOREIGN KEY (ss_sold_date_sk)
    REFERENCES rsa.date_dim (d_date_sk),
  CONSTRAINT ss_hd
    FOREIGN KEY (ss_hdemo_sk)
    REFERENCES rsa.household_demographics (hd_demo_sk),
  CONSTRAINT ss_i
    FOREIGN KEY (ss_item_sk)
    REFERENCES rsa.item (i_item_sk),
  CONSTRAINT ss_p
    FOREIGN KEY (ss_promo_sk)
    REFERENCES rsa.promotion (p_promo_sk),
  CONSTRAINT ss_s
    FOREIGN KEY (ss_store_sk)
    REFERENCES rsa.store (s_store_sk),
  CONSTRAINT ss_t
    FOREIGN KEY (ss_sold_time_sk)
    REFERENCES rsa.time_dim (t_time_sk),
  CONSTRAINT ss_ch
    FOREIGN KEY (ss_channel_sk)
    REFERENCES rsa.sales_channel (sc_channel_sk)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT);

CREATE INDEX ss_a ON rsa.store_sales(ss_addr_sk ASC);
CREATE  INDEX ss_cd ON rsa.store_sales(ss_cdemo_sk ASC);
CREATE  INDEX ss_c ON rsa.store_sales(ss_customer_sk ASC);
CREATE  INDEX ss_hd ON rsa.store_sales(ss_hdemo_sk ASC);
CREATE  INDEX ss_p ON rsa.store_sales(ss_promo_sk ASC);
CREATE  INDEX ss_d ON rsa.store_sales(ss_sold_date_sk ASC);
CREATE  INDEX ss_t ON rsa.store_sales(ss_sold_time_sk ASC);
CREATE  INDEX ss_s ON rsa.store_sales(ss_store_sk ASC);
CREATE  INDEX sc_uix ON rsa.sales_channel (sc_channel_sk ASC);

