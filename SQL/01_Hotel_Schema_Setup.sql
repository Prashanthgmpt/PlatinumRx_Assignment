-- Create Users Table
CREATE TABLE users (
  user_id VARCHAR(50),
  name VARCHAR(100),
  phone_number VARCHAR(20),
  mail_id VARCHAR(100),
  billing_address TEXT
);

-- Create Bookings Table
CREATE TABLE bookings (
  booking_id VARCHAR(50),
  booking_date DATETIME,
  room_no VARCHAR(50),
  user_id VARCHAR(50)
);

-- Create Items Table
CREATE TABLE items (
  item_id VARCHAR(50),
  item_name VARCHAR(100),
  item_rate INT
);

-- Create Booking Commercials Table
CREATE TABLE booking_commercials (
  id VARCHAR(50),
  booking_id VARCHAR(50),
  bill_id VARCHAR(50),
  bill_date DATETIME,
  item_id VARCHAR(50),
  item_quantity FLOAT
);

-- Insert Sample Data
INSERT INTO users VALUES
('u1', 'John', '9999999999', 'john@mail.com', 'Chennai');

INSERT INTO bookings VALUES
('b1', '2021-11-10 10:00:00', 'r1', 'u1');

INSERT INTO items VALUES
('i1', 'Paratha', 20),
('i2', 'Veg Curry', 80);

INSERT INTO booking_commercials VALUES
('c1', 'b1', 'bill1', '2021-11-10', 'i1', 2),
('c2', 'b1', 'bill1', '2021-11-10', 'i2', 1);