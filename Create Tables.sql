DROP TABLE accident CASCADE CONSTRAINTS;

DROP TABLE claimant CASCADE CONSTRAINTS;

DROP TABLE claims CASCADE CONSTRAINTS;

DROP TABLE expert_report CASCADE CONSTRAINTS;

DROP TABLE expert_witness CASCADE CONSTRAINTS;

DROP TABLE payment CASCADE CONSTRAINTS;

DROP TABLE staff CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE accident (
    accident_key  INTEGER NOT NULL,
    a_date        DATE,
    a_description VARCHAR2(30),
    a_location    VARCHAR2(50),
    staff_no      INTEGER NOT NULL
);

ALTER TABLE accident ADD CONSTRAINT accident_pk PRIMARY KEY ( accident_key );

CREATE TABLE claimant (
    claimant_id INTEGER NOT NULL,
    cl_name     CHAR(20),
    cl_addr     VARCHAR2(20),
    cl_dob      DATE
);

ALTER TABLE claimant ADD CONSTRAINT claimant_pk PRIMARY KEY ( claimant_id );

CREATE TABLE claims (
    natureofclaim VARCHAR2(30),
    repoerted_on  DATE,
    c_state       CHAR(1),
    cl_key        INTEGER NOT NULL,
    accident_key  INTEGER NOT NULL,
    claimant_id   INTEGER NOT NULL
);

ALTER TABLE claims ADD CONSTRAINT claims_pk PRIMARY KEY ( cl_key );

CREATE TABLE expert_report (
    daterequested DATE,
    datesubmitted DATE,
    reportcontent VARCHAR2(30),
    expertid      INTEGER NOT NULL,
    cl_key        INTEGER NOT NULL
);

CREATE TABLE expert_witness (
    expertid    INTEGER NOT NULL,
    e_name      CHAR(20),
    e_addr      VARCHAR2(30),
    e_expertise CHAR(20)
);

ALTER TABLE expert_witness ADD CONSTRAINT expert_witness_pk PRIMARY KEY ( expertid );

CREATE TABLE payment (
    payment_no INTEGER DEFAULT NULL NOT NULL,
    p_date     DATE,
    p_amount   NUMBER,
    p_reason   VARCHAR2(20),
    chequeno   INTEGER,
    cl_key     INTEGER NOT NULL
);

ALTER TABLE payment ADD CONSTRAINT payment_pk PRIMARY KEY ( payment_no );

CREATE TABLE staff (
    staff_no   INTEGER NOT NULL,
    staff_name CHAR(20),
    staff_role CHAR(20)
);

ALTER TABLE staff ADD CONSTRAINT staff_pk PRIMARY KEY ( staff_no );

ALTER TABLE claims
    ADD CONSTRAINT accident_fk FOREIGN KEY ( accident_key )
        REFERENCES accident ( accident_key );

ALTER TABLE claims
    ADD CONSTRAINT claimant_fk FOREIGN KEY ( claimant_id )
        REFERENCES claimant ( claimant_id );

ALTER TABLE expert_report
    ADD CONSTRAINT claims_fk FOREIGN KEY ( cl_key )
        REFERENCES claims ( cl_key );

ALTER TABLE payment
    ADD CONSTRAINT claims_fkv1 FOREIGN KEY ( cl_key )
        REFERENCES claims ( cl_key );

ALTER TABLE expert_report
    ADD CONSTRAINT expert_witness_fk FOREIGN KEY ( expertid )
        REFERENCES expert_witness ( expertid );

ALTER TABLE accident
    ADD CONSTRAINT staff_fk FOREIGN KEY ( staff_no )
        REFERENCES staff ( staff_no );