-- Phase 2: Creating Tables and Using JOINs

-- Drop tables if they exist to avoid conflicts
DROP TABLE IF EXISTS shipments;
DROP TABLE IF EXISTS health_facilities;

-- Create health_facilities table
CREATE TABLE health_facilities (
    facility_id SERIAL PRIMARY KEY,
    facility_name VARCHAR(100),
    state VARCHAR(50)
);

-- Insert data into health_facilities
INSERT INTO health_facilities (facility_name, state) VALUES
('Central Clinic', 'California'),
('Westside Hospital', 'Nevada'),
('Eastside Health Center', 'California'),
('Northern Medical', 'Nebraska');

-- Create shipments table
CREATE TABLE shipments (
    shipment_id SERIAL PRIMARY KEY,
    facility_id INT,
    shipment_date DATE,
    test_kits_ordered INT,
    FOREIGN KEY (facility_id) REFERENCES health_facilities(facility_id)
);

-- Insert data into shipments
INSERT INTO shipments (facility_id, shipment_date, test_kits_ordered) VALUES
(1, '2025-05-01', 100),
(1, '2025-05-10', 150),
(2, '2025-05-05', 200);

-- LEFT JOIN example: List all health facilities with their shipments (if any)
SELECT 
  hf.facility_id, 
  hf.facility_name, 
  hf.state, 
  s.shipment_id, 
  s.shipment_date, 
  s.test_kits_ordered
FROM health_facilities hf
LEFT JOIN shipments s ON hf.facility_id = s.facility_id
ORDER BY hf.facility_id;
