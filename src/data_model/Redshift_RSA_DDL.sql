-- Create RSA tables in Redshift schmema
-- Copy the contents to the Redshift Query Editor and run

DROP SCHEMA rsa CASCADE;

CREATE SCHEMA IF NOT EXISTS rsa;
	
--DROP TABLE rsa.customer	
CREATE TABLE IF NOT EXISTS rsa.customer	
(	
  c_customer_sk INTEGER NOT NULL  ENCODE az64
 ,c_customer_id CHAR(16) NOT NULL  ENCODE lzo	
 ,c_current_cdemo_sk INTEGER   ENCODE az64	
 ,c_current_hdemo_sk INTEGER   ENCODE az64	
 ,c_current_addr_sk INTEGER   ENCODE az64	
 ,c_salutation CHAR(10)  DEFAULT NULL::bpchar ENCODE lzo	
 ,c_first_name CHAR(20)  DEFAULT NULL::bpchar ENCODE lzo	
 ,c_last_name CHAR(30)  DEFAULT NULL::bpchar ENCODE lzo	
 ,c_preferred_cust_flag CHAR(1)  DEFAULT NULL::bpchar ENCODE lzo	
 ,c_birth_day INTEGER   ENCODE az64	
 ,c_birth_month INTEGER   ENCODE az64	
 ,c_birth_year INTEGER   ENCODE az64	
 ,c_birth_country VARCHAR(20)  DEFAULT NULL::character varying ENCODE lzo	
 ,c_login CHAR(13)  DEFAULT NULL::bpchar ENCODE lzo	
 ,c_email_address CHAR(50)  DEFAULT NULL::bpchar ENCODE lzo	
 ,c_last_review_date_sk INTEGER   ENCODE az64	
 ,PRIMARY KEY (c_customer_sk)	
)	
DISTSTYLE AUTO;
	

--DROP TABLE rsa.customer_address	
CREATE TABLE IF NOT EXISTS rsa.customer_address	
(	
  ca_address_sk INTEGER NOT NULL  ENCODE az64
 ,ca_address_id CHAR(16) NOT NULL  ENCODE lzo	
 ,ca_street_number CHAR(10)  DEFAULT NULL::bpchar ENCODE lzo	
 ,ca_street_name VARCHAR(60)  DEFAULT NULL::character varying ENCODE lzo	
 ,ca_street_type CHAR(15)  DEFAULT NULL::bpchar ENCODE lzo	
 ,ca_suite_number CHAR(10)  DEFAULT NULL::bpchar ENCODE lzo	
 ,ca_city VARCHAR(60)  DEFAULT NULL::character varying ENCODE lzo	
 ,ca_county VARCHAR(30)  DEFAULT NULL::character varying ENCODE lzo	
 ,ca_state CHAR(2)  DEFAULT NULL::bpchar ENCODE lzo	
 ,ca_zip CHAR(10)  DEFAULT NULL::bpchar ENCODE lzo	
 ,ca_country VARCHAR(20)  DEFAULT NULL::character varying ENCODE lzo	
 ,ca_gmt_offset NUMERIC(5,2)  DEFAULT (NULL::numeric)::numeric(18,0) ENCODE az64	
 ,ca_location_type CHAR(20)  DEFAULT NULL::bpchar ENCODE lzo	
 ,PRIMARY KEY (ca_address_sk)	
)	
DISTSTYLE AUTO;
	
ALTER TABLE rsa.customer_address owner to awsuser;	
--DROP TABLE rsa.customer_demographics	

CREATE TABLE IF NOT EXISTS rsa.customer_demographics	
(	
  cd_demo_sk INTEGER NOT NULL  ENCODE az64
 ,cd_gender CHAR(1)  DEFAULT NULL::bpchar ENCODE lzo	
 ,cd_marital_status CHAR(1)  DEFAULT NULL::bpchar ENCODE lzo	
 ,cd_education_status CHAR(20)  DEFAULT NULL::bpchar ENCODE lzo	
 ,cd_purchase_estimate INTEGER   ENCODE az64	
 ,cd_credit_rating CHAR(10)  DEFAULT NULL::bpchar ENCODE lzo	
 ,cd_dep_count INTEGER   ENCODE az64	
 ,cd_dep_employed_count INTEGER   ENCODE az64	
 ,cd_dep_college_count INTEGER   ENCODE az64	
 ,PRIMARY KEY (cd_demo_sk)	
)	
DISTSTYLE AUTO;	
	
ALTER TABLE rsa.customer_demographics owner to awsuser;

--DROP TABLE rsa.date_dim	
CREATE TABLE IF NOT EXISTS rsa.date_dim	
(	
  d_date_sk INTEGER NOT NULL  ENCODE az64
 ,d_date_id CHAR(16) NOT NULL  ENCODE lzo	
 ,d_date DATE   ENCODE az64	
 ,d_month_seq INTEGER   ENCODE az64	
 ,d_week_seq INTEGER   ENCODE az64	
 ,d_quarter_seq INTEGER   ENCODE az64	
 ,d_year INTEGER   ENCODE az64	
 ,d_dow INTEGER   ENCODE az64	
 ,d_moy INTEGER   ENCODE az64	
 ,d_dom INTEGER   ENCODE az64	
 ,d_qoy INTEGER   ENCODE az64	
 ,d_fy_year INTEGER   ENCODE az64	
 ,d_fy_quarter_seq INTEGER   ENCODE az64	
 ,d_fy_week_seq INTEGER   ENCODE az64	
 ,d_day_name CHAR(9)  DEFAULT NULL::bpchar ENCODE lzo	
 ,d_quarter_name CHAR(6)  DEFAULT NULL::bpchar ENCODE lzo	
 ,d_holiday CHAR(1)  DEFAULT NULL::bpchar ENCODE lzo	
 ,d_weekend CHAR(1)  DEFAULT NULL::bpchar ENCODE lzo	
 ,d_following_holiday CHAR(1)  DEFAULT NULL::bpchar ENCODE lzo	
 ,d_first_dom INTEGER   ENCODE az64	
 ,d_last_dom INTEGER   ENCODE az64	
 ,d_same_day_ly INTEGER   ENCODE az64	
 ,d_same_day_lq INTEGER   ENCODE az64	
 ,d_current_day CHAR(1)  DEFAULT NULL::bpchar ENCODE lzo	
 ,d_current_week CHAR(1)  DEFAULT NULL::bpchar ENCODE lzo	
 ,d_current_month CHAR(1)  DEFAULT NULL::bpchar ENCODE lzo	
 ,d_current_quarter CHAR(1)  DEFAULT NULL::bpchar ENCODE lzo	
 ,d_current_year CHAR(1)  DEFAULT NULL::bpchar ENCODE lzo	
 ,PRIMARY KEY (d_date_sk)	
)	
DISTSTYLE AUTO;	
	
ALTER TABLE rsa.date_dim owner to awsuser;


--DROP TABLE rsa.household_demographics	
CREATE TABLE IF NOT EXISTS rsa.household_demographics	
(	
  hd_demo_sk INTEGER NOT NULL  ENCODE az64
 ,hd_income_band_sk INTEGER   ENCODE az64	
 ,hd_buy_potential CHAR(15)  DEFAULT NULL::bpchar ENCODE lzo	
 ,hd_dep_count INTEGER   ENCODE az64	
 ,hd_vehicle_count INTEGER   ENCODE az64	
 ,PRIMARY KEY (hd_demo_sk)	
)	
DISTSTYLE AUTO;	
	
--DROP TABLE rsa.income_band	
CREATE TABLE IF NOT EXISTS rsa.income_band	
(	
  ib_income_band_sk INTEGER NOT NULL  ENCODE az64
 ,ib_lower_bound INTEGER   ENCODE az64	
 ,ib_upper_bound INTEGER   ENCODE az64	
 ,PRIMARY KEY (ib_income_band_sk)	
)	
DISTSTYLE AUTO;	
	
ALTER TABLE rsa.income_band owner to awsuser;

--DROP TABLE rsa.item	
CREATE TABLE IF NOT EXISTS rsa.item	
(	
  i_item_sk INTEGER NOT NULL  ENCODE az64
 ,i_item_id CHAR(16) NOT NULL  ENCODE lzo	
 ,i_rec_start_date DATE   ENCODE az64	
 ,i_rec_end_date DATE   ENCODE az64	
 ,i_item_desc VARCHAR(200)  DEFAULT NULL::character varying ENCODE lzo	
 ,i_current_price NUMERIC(7,2)  DEFAULT (NULL::numeric)::numeric(18,0) ENCODE az64	
 ,i_wholesale_cost NUMERIC(7,2)  DEFAULT (NULL::numeric)::numeric(18,0) ENCODE az64	
 ,i_brand_id INTEGER   ENCODE az64	
 ,i_brand CHAR(50)  DEFAULT NULL::bpchar ENCODE lzo	
 ,i_class_id INTEGER   ENCODE az64	
 ,i_class CHAR(50)  DEFAULT NULL::bpchar ENCODE lzo	
 ,i_category_id INTEGER   ENCODE az64	
 ,i_category CHAR(50)  DEFAULT NULL::bpchar ENCODE lzo	
 ,i_manufact_id INTEGER   ENCODE az64	
 ,i_manufact CHAR(50)  DEFAULT NULL::bpchar ENCODE lzo	
 ,i_size CHAR(20)  DEFAULT NULL::bpchar ENCODE lzo	
 ,i_formulation CHAR(20)  DEFAULT NULL::bpchar ENCODE lzo	
 ,i_color CHAR(20)  DEFAULT NULL::bpchar ENCODE lzo	
 ,i_units CHAR(10)  DEFAULT NULL::bpchar ENCODE lzo	
 ,i_container CHAR(10)  DEFAULT NULL::bpchar ENCODE lzo	
 ,i_manager_id INTEGER   ENCODE az64	
 ,i_product_name CHAR(50)  DEFAULT NULL::bpchar ENCODE lzo	
 ,PRIMARY KEY (i_item_sk)	
)	
DISTSTYLE AUTO;	
	
ALTER TABLE rsa.item owner to awsuser;

--DROP TABLE rsa.promotion	
CREATE TABLE IF NOT EXISTS rsa.promotion	
(	
  p_promo_sk INTEGER NOT NULL  ENCODE az64
 ,p_promo_id CHAR(16) NOT NULL  ENCODE lzo	
 ,p_start_date_sk INTEGER   ENCODE az64	
 ,p_end_date_sk INTEGER   ENCODE az64	
 ,p_item_sk INTEGER   ENCODE az64	
 ,p_cost NUMERIC(15,2)  DEFAULT (NULL::numeric)::numeric(18,0) ENCODE az64	
 ,p_response_target INTEGER   ENCODE az64	
 ,p_promo_name CHAR(50)  DEFAULT NULL::bpchar ENCODE lzo	
 ,p_channel_dmail CHAR(1)  DEFAULT NULL::bpchar ENCODE lzo	
 ,p_channel_email CHAR(1)  DEFAULT NULL::bpchar ENCODE lzo	
 ,p_channel_catalog CHAR(1)  DEFAULT NULL::bpchar ENCODE lzo	
 ,p_channel_tv CHAR(1)  DEFAULT NULL::bpchar ENCODE lzo	
 ,p_channel_radio CHAR(1)  DEFAULT NULL::bpchar ENCODE lzo	
 ,p_channel_press CHAR(1)  DEFAULT NULL::bpchar ENCODE lzo	
 ,p_channel_event CHAR(1)  DEFAULT NULL::bpchar ENCODE lzo	
 ,p_channel_demo CHAR(1)  DEFAULT NULL::bpchar ENCODE lzo	
 ,p_channel_details VARCHAR(100)  DEFAULT NULL::character varying ENCODE lzo	
 ,p_purpose CHAR(15)  DEFAULT NULL::bpchar ENCODE lzo	
 ,p_discount_active CHAR(1)  DEFAULT NULL::bpchar ENCODE lzo	
 ,PRIMARY KEY (p_promo_sk)	
)	
DISTSTYLE AUTO;	
	

--DROP TABLE rsa.sales_channel	
CREATE TABLE IF NOT EXISTS rsa.sales_channel

(	
  sc_channel_sk INTEGER NOT NULL  ENCODE az64
 ,sc_channel_id CHAR(16) NOT NULL  ENCODE lzo	
 ,sc_channel_name VARCHAR(45) NOT NULL  ENCODE lzo	
 ,PRIMARY KEY (sc_channel_sk)	
)	
DISTSTYLE AUTO;	
	
ALTER TABLE rsa.sales_channel owner to awsuser;

--DROP TABLE rsa.store	
CREATE TABLE IF NOT EXISTS rsa.store	
(	
  s_store_sk INTEGER NOT NULL  ENCODE az64
 ,s_store_id CHAR(16) NOT NULL  ENCODE lzo	
 ,s_rec_start_date DATE   ENCODE az64	
 ,s_rec_end_date DATE   ENCODE az64	
 ,s_store_name VARCHAR(50)  DEFAULT NULL::character varying ENCODE lzo	
 ,s_number_employees INTEGER   ENCODE az64	
 ,s_floor_space INTEGER   ENCODE az64	
 ,s_hours CHAR(20)  DEFAULT NULL::bpchar ENCODE lzo	
 ,s_manager VARCHAR(40)  DEFAULT NULL::character varying ENCODE lzo	
 ,s_market_id INTEGER   ENCODE az64	
 ,s_geography_class VARCHAR(100)  DEFAULT NULL::character varying ENCODE lzo	
 ,s_market_desc VARCHAR(100)  DEFAULT NULL::character varying ENCODE lzo	
 ,s_market_manager VARCHAR(40)  DEFAULT NULL::character varying ENCODE lzo	
 ,s_division_id INTEGER   ENCODE az64	
 ,s_division_name VARCHAR(50)  DEFAULT NULL::character varying ENCODE lzo	
 ,s_company_id INTEGER   ENCODE az64	
 ,s_company_name VARCHAR(50)  DEFAULT NULL::character varying ENCODE lzo	
 ,s_street_number VARCHAR(10)  DEFAULT NULL::character varying ENCODE lzo	
 ,s_street_name VARCHAR(60)  DEFAULT NULL::character varying ENCODE lzo	
 ,s_street_type CHAR(15)  DEFAULT NULL::bpchar ENCODE lzo	
 ,s_suite_number CHAR(10)  DEFAULT NULL::bpchar ENCODE lzo	
 ,s_city VARCHAR(60)  DEFAULT NULL::character varying ENCODE lzo	
 ,s_county VARCHAR(30)  DEFAULT NULL::character varying ENCODE lzo	
 ,s_state CHAR(2)  DEFAULT NULL::bpchar ENCODE lzo	
 ,s_zip CHAR(10)  DEFAULT NULL::bpchar ENCODE lzo	
 ,s_country VARCHAR(20)  DEFAULT NULL::character varying ENCODE lzo	
 ,s_gmt_offset NUMERIC(5,2)  DEFAULT (NULL::numeric)::numeric(18,0) ENCODE az64	
 ,s_tax_precentage NUMERIC(5,2)  DEFAULT (NULL::numeric)::numeric(18,0) ENCODE az64	
 ,PRIMARY KEY (s_store_sk)	
)	
DISTSTYLE AUTO;	
	
ALTER TABLE rsa.store owner to awsuser;	

--DROP TABLE rsa.store_sales	
CREATE TABLE IF NOT EXISTS rsa.store_sales	
(	
  ss_sold_date_sk INTEGER   ENCODE az64
 ,ss_sold_time_sk INTEGER   ENCODE az64	
 ,ss_item_sk INTEGER NOT NULL  ENCODE az64	
 ,ss_customer_sk INTEGER   ENCODE az64	
 ,ss_cdemo_sk INTEGER   ENCODE az64	
 ,ss_hdemo_sk INTEGER   ENCODE az64	
 ,ss_addr_sk INTEGER   ENCODE az64	
 ,ss_store_sk INTEGER   ENCODE az64	
 ,ss_promo_sk INTEGER   ENCODE az64	
 ,ss_order_number INTEGER NOT NULL  ENCODE az64	
 ,ss_channel_sk INTEGER   ENCODE az64	
 ,ss_quantity INTEGER   ENCODE az64	
 ,ss_wholesale_cost NUMERIC(7,2)  DEFAULT (NULL::numeric)::numeric(18,0) ENCODE az64	
 ,ss_list_price NUMERIC(7,2)  DEFAULT (NULL::numeric)::numeric(18,0) ENCODE az64	
 ,ss_sales_price NUMERIC(7,2)  DEFAULT (NULL::numeric)::numeric(18,0) ENCODE az64	
 ,ss_ext_discount_amt NUMERIC(7,2)  DEFAULT (NULL::numeric)::numeric(18,0) ENCODE az64	
 ,ss_ext_sales_price NUMERIC(7,2)  DEFAULT (NULL::numeric)::numeric(18,0) ENCODE az64	
 ,ss_ext_wholesale_cost NUMERIC(7,2)  DEFAULT (NULL::numeric)::numeric(18,0) ENCODE az64	
 ,ss_ext_list_price NUMERIC(7,2)  DEFAULT (NULL::numeric)::numeric(18,0) ENCODE az64	
 ,ss_ext_tax NUMERIC(7,2)  DEFAULT (NULL::numeric)::numeric(18,0) ENCODE az64	
 ,ss_coupon_amt NUMERIC(7,2)  DEFAULT (NULL::numeric)::numeric(18,0) ENCODE az64	
 ,ss_net_paid NUMERIC(7,2)  DEFAULT (NULL::numeric)::numeric(18,0) ENCODE az64	
 ,ss_net_paid_inc_tax NUMERIC(7,2)  DEFAULT (NULL::numeric)::numeric(18,0) ENCODE az64	
 ,ss_net_profit NUMERIC(7,2)  DEFAULT (NULL::numeric)::numeric(18,0) ENCODE az64	
 ,PRIMARY KEY (ss_item_sk, ss_order_number)	
)	
DISTSTYLE AUTO;	
	

--DROP TABLE rsa.time_dim	
CREATE TABLE IF NOT EXISTS rsa.time_dim	
(	
  t_time_sk INTEGER NOT NULL  ENCODE az64
 ,t_time_id CHAR(16) NOT NULL  ENCODE lzo	
 ,t_time INTEGER   ENCODE az64	
 ,t_hour INTEGER   ENCODE az64	
 ,t_minute INTEGER   ENCODE az64	
 ,t_second INTEGER   ENCODE az64	
 ,t_am_pm CHAR(2)  DEFAULT NULL::bpchar ENCODE lzo	
 ,t_shift CHAR(20)  DEFAULT NULL::bpchar ENCODE lzo	
 ,t_sub_shift CHAR(20)  DEFAULT NULL::bpchar ENCODE lzo	
 ,t_meal_time CHAR(20)  DEFAULT NULL::bpchar ENCODE lzo	
 ,PRIMARY KEY (t_time_sk)	
)	
DISTSTYLE AUTO;	
	
ALTER TABLE rsa.time_dim owner to awsuser;

ALTER TABLE rsa.customer owner to awsuser;	

ALTER TABLE rsa.customer ADD FOREIGN KEY (c_current_addr_sk) REFERENCES rsa.customer_address(ca_address_sk);	
ALTER TABLE rsa.customer ADD FOREIGN KEY (c_current_cdemo_sk) REFERENCES rsa.customer_demographics(cd_demo_sk);	
ALTER TABLE rsa.customer ADD FOREIGN KEY (c_current_hdemo_sk) REFERENCES rsa.household_demographics(hd_demo_sk);	

ALTER TABLE rsa.household_demographics owner to awsuser;	
ALTER TABLE rsa.household_demographics ADD FOREIGN KEY (hd_income_band_sk) REFERENCES rsa.income_band(ib_income_band_sk);

ALTER TABLE rsa.promotion owner to awsuser;	
ALTER TABLE rsa.promotion ADD FOREIGN KEY (p_end_date_sk) REFERENCES rsa.date_dim(d_date_sk);	
ALTER TABLE rsa.promotion ADD FOREIGN KEY (p_item_sk) REFERENCES rsa.item(i_item_sk);	
ALTER TABLE rsa.promotion ADD FOREIGN KEY (p_start_date_sk) REFERENCES rsa.date_dim(d_date_sk);	

ALTER TABLE rsa.store_sales owner to awsuser;	
ALTER TABLE rsa.store_sales ADD FOREIGN KEY (ss_addr_sk) REFERENCES rsa.customer_address(ca_address_sk);	
ALTER TABLE rsa.store_sales ADD FOREIGN KEY (ss_customer_sk) REFERENCES rsa.customer(c_customer_sk);	
ALTER TABLE rsa.store_sales ADD FOREIGN KEY (ss_cdemo_sk) REFERENCES rsa.customer_demographics(cd_demo_sk);	
ALTER TABLE rsa.store_sales ADD FOREIGN KEY (ss_sold_date_sk) REFERENCES rsa.date_dim(d_date_sk);	
ALTER TABLE rsa.store_sales ADD FOREIGN KEY (ss_hdemo_sk) REFERENCES rsa.household_demographics(hd_demo_sk);	
ALTER TABLE rsa.store_sales ADD FOREIGN KEY (ss_item_sk) REFERENCES rsa.item(i_item_sk);	
ALTER TABLE rsa.store_sales ADD FOREIGN KEY (ss_store_sk) REFERENCES rsa.store(s_store_sk);	
ALTER TABLE rsa.store_sales ADD FOREIGN KEY (ss_sold_time_sk) REFERENCES rsa.time_dim(t_time_sk);
