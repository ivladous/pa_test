CREATE SCHEMA scada;
CREATE TABLE parameters
(
	id SERIAL PRIMARY KEY,
	name VARCHAR(30) NOT NULL
);
INSERT INTO parameters (name) VALUES
('Давление'),
('Скорость'),
('Мощность'),
('Объем'),
('Скорость');
CREATE TABLE scada.values
(
	Time TIMESTAMPTZ,
	Value REAL,
	parameter_id INTEGER REFERENCES scada.parameters
);
CREATE TABLE scada.states
(
	Time TIMESTAMPTZ,
	Value REAL,
	State BOOL,
	parameter_id INTEGER REFERENCES scada.parameters
);