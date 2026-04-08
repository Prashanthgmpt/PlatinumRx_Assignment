CREATE TABLE clinics (
  cid VARCHAR(50),
  clinic_name VARCHAR(100),
  city VARCHAR(50),
  state VARCHAR(50),
  country VARCHAR(50)
);

CREATE TABLE customer (
  uid VARCHAR(50),
  name VARCHAR(100),
  mobile VARCHAR(20)
);

CREATE TABLE clinic_sales (
  oid VARCHAR(50),
  uid VARCHAR(50),
  cid VARCHAR(50),
  amount INT,
  datetime DATETIME,
  sales_channel VARCHAR(50)
);

CREATE TABLE expenses (
  eid VARCHAR(50),
  cid VARCHAR(50),
  description TEXT,
  amount INT,
  datetime DATETIME
);

INSERT INTO clinics VALUES
('c1', 'ABC Clinic', 'Chennai', 'TN', 'India');

INSERT INTO customer VALUES
('u1', 'John', '9999999999');

INSERT INTO clinic_sales VALUES
('o1', 'u1', 'c1', 2000, '2021-11-10', 'online'),
('o2', 'u1', 'c1', 3000, '2021-11-15', 'offline');

INSERT INTO expenses VALUES
('e1', 'c1', 'Medicines', 1000, '2021-11-12');