CREATE TABLE Authentication (
    login_id    VARCHAR(50)  PRIMARY KEY,
    password    VARCHAR(255) NOT NULL         
);

CREATE TABLE Staff (
    staff_id    INT          PRIMARY KEY AUTO_INCREMENT,
    name        VARCHAR(100) NOT NULL,
    login_id    VARCHAR(50)  UNIQUE NOT NULL,
    CONSTRAINT fk_staff_auth FOREIGN KEY (login_id)
        REFERENCES Authentication(login_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Publisher (
    publisher_id    INT          PRIMARY KEY AUTO_INCREMENT,
    name            VARCHAR(150) NOT NULL,
    year_of_pub     YEAR         NOT NULL
);

CREATE TABLE Books (
    ISBN            VARCHAR(20)    PRIMARY KEY,
    title           VARCHAR(255)   NOT NULL,
    auth_no         VARCHAR(100)   NOT NULL,
    category        VARCHAR(100),
    price           DECIMAL(10,2)  NOT NULL,
    publisher_id    INT            NOT NULL,
    CONSTRAINT fk_books_publisher FOREIGN KEY (publisher_id)
        REFERENCES Publisher(publisher_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Books (
    ISBN            VARCHAR(20)    PRIMARY KEY,
    title           VARCHAR(255)   NOT NULL,
    auth_no         VARCHAR(100)   NOT NULL,
    category        VARCHAR(100),
    price           DECIMAL(10,2)  NOT NULL,
    publisher_id    INT            NOT NULL,
    CONSTRAINT fk_books_publisher FOREIGN KEY (publisher_id)
        REFERENCES Publisher(publisher_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Reports (
    report_id       INT         PRIMARY KEY AUTO_INCREMENT,
    reg_no          VARCHAR(50) NOT NULL,
    book_no         VARCHAR(20) NOT NULL,
    issue_return    ENUM('Issue','Return') NOT NULL,
    report_date     DATE        NOT NULL DEFAULT (CURRENT_DATE),
    staff_id        INT         NOT NULL,
    CONSTRAINT fk_reports_books FOREIGN KEY (book_no)
        REFERENCES Books(ISBN)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_reports_staff FOREIGN KEY (staff_id)
        REFERENCES Staff(staff_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Reserve_Return (
    reservation_id  INT          PRIMARY KEY AUTO_INCREMENT,
    user_id         INT          NOT NULL,
    ISBN            VARCHAR(20)  NOT NULL,
    reserve_date    DATE         NOT NULL DEFAULT (CURRENT_DATE),
    due_date        DATE         NOT NULL,
    return_date     DATE,                    
    staff_id        INT          NOT NULL,
    CONSTRAINT fk_rr_reader FOREIGN KEY (user_id)
        REFERENCES Readers(user_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_rr_books  FOREIGN KEY (ISBN)
        REFERENCES Books(ISBN)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_rr_staff  FOREIGN KEY (staff_id)
        REFERENCES Staff(staff_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE INDEX idx_books_publisher  ON Books(publisher_id);
CREATE INDEX idx_reports_staff    ON Reports(staff_id);
CREATE INDEX idx_reports_book     ON Reports(book_no);
CREATE INDEX idx_rr_user          ON Reserve_Return(user_id);
CREATE INDEX idx_rr_isbn          ON Reserve_Return(ISBN);
CREATE INDEX idx_rr_staff         ON Reserve_Return(staff_id);

INSERT INTO Authentication (login_id, password) VALUES
    ('admin01', 'hashed_pw_1'),
    ('staff02', 'hashed_pw_2'),
    ('staff03', 'hashed_pw_3');
 
INSERT INTO Staff (name, login_id) VALUES
    ('Alice Johnson',  'admin01'),
    ('Bob Smith',      'staff02'),
    ('Carol Williams', 'staff03');
 
INSERT INTO Publisher (name, year_of_pub) VALUES
    ('Pearson Education', 2018),
    ('McGraw-Hill',       2020),
    ('O''Reilly Media',   2022);
 
INSERT INTO Books (ISBN, title, auth_no, category, price, publisher_id) VALUES
    ('978-0-13-110362-7', 'The C Programming Language',  'Kernighan & Ritchie', 'Computer Science', 45.99, 1),
    ('978-0-07-064770-0', 'Database System Concepts',    'Silberschatz',        'Database',         59.99, 2),
    ('978-1-49-195016-0', 'Learning Python',             'Mark Lutz',           'Programming',      49.99, 3),
    ('978-0-13-468599-1', 'Clean Code',                  'Robert C. Martin',    'Software Eng.',    39.99, 1),
    ('978-0-59-651798-1', 'JavaScript: The Good Parts',  'Douglas Crockford',   'Web Dev',          29.99, 3);
 
INSERT INTO Readers (name, email, phone_no, address) VALUES
    ('Tanishq Kr',   'tanishq@email.com', '9876543210', 'Delhi, City'),
    ('Riddhi Kri',  'riddhi@email.com',  '9123456780', 'Gaya Ji, Town'),
    ('Ritesh Raj', 'riteshraj@email.com', '9001234567', 'Saharanpur, Village');
 
INSERT INTO Reports (reg_no, book_no, issue_return, report_date, staff_id) VALUES
    ('REG001', '978-0-13-110362-7', 'Issue',  '2024-01-10', 1),
    ('REG002', '978-0-07-064770-0', 'Issue',  '2024-01-12', 2),
    ('REG001', '978-0-13-110362-7', 'Return', '2024-01-25', 1);
 
INSERT INTO Reserve_Return (user_id, ISBN, reserve_date, due_date, return_date, staff_id) VALUES
    (1, '978-0-13-110362-7', '2024-01-10', '2024-01-24', '2024-01-23', 1),
    (2, '978-0-07-064770-0', '2024-01-12', '2024-01-26', NULL, 2),
    (3, '978-1-49-195016-0', '2024-02-01', '2024-02-15', '2024-02-14', 3);


