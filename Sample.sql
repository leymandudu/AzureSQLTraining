SELECT * FROM table_1;

CREATE TABLE sampleTable (
    id int IDENTITY(1,1),
    fname VARCHAR(30),
    lname VARCHAR(30)
);

-- Inserting data into sampleTable
INSERT INTO sampleTable
VALUES ('Idowu', 'NULL'),
('Abass', 'Adekunle'),
('Hamdan', 'Adewuyi'),
('NULL', 'Abiola'),
('Haneef', 'Adewuyi');