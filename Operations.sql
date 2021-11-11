-- A-B
--Select staff that are driver minus the ones that are inspectors
SELECT
    staff_name
FROM
    staff
WHERE
    staff_role = 'Driver'
MINUS
( SELECT
    staff_name
FROM
    staff
WHERE
    staff_role = 'Inspector'
);


--A intersects B
DROP VIEW expertwitnesscstate;

CREATE VIEW expertwitnesscstate AS
    SELECT
        expert.e_name,
        claims.c_state
    FROM
             expert_witness expert
        JOIN expert_report exprpt ON expert.expertid = exprpt.expertid
        JOIN claims        claims ON exprpt.cl_key = claims.cl_key;
  
 --Select all Expert Witness that has a R and S claim state 
SELECT
    e_name
FROM
    expertwitnesscstate
WHERE
    c_state = 'R'
INTERSECT
SELECT
    e_name
FROM
    expertwitnesscstate
WHERE
    c_state = 'S';

    
-- A union B
DROP VIEW expertwitnesscstate;

CREATE VIEW expertwitnesscstate AS
    SELECT
        expert.e_name,
        claims.c_state
    FROM
             expert_witness expert
        JOIN expert_report exprpt ON expert.expertid = exprpt.expertid
        JOIN claims        claims ON exprpt.cl_key = claims.cl_key;

--Select all Expert Witness that has a R or a C claim state. 
SELECT
    e_name
FROM
    expertwitnesscstate
WHERE
    c_state = 'R'
UNION
SELECT
    e_name
FROM
    expertwitnesscstate
WHERE
    c_state = 'C';
    
--A XOR B
DROP VIEW staffnatureofaccident;

CREATE VIEW staffnatureofaccident AS
    SELECT
        staff.staff_name,
        staff.staff_role,
        claims.natureofclaim
    FROM
             staff staff
        JOIN accident accident ON staff.staff_no = accident.staff_no
        JOIN claims   claims ON accident.accident_key = claims.accident_key;


--Select every staff that is a driver and had a medical claim
--or Select every staff that is not a driver and does not have a medical claim.
SELECT
    staff_name
FROM
    staffnatureofaccident
WHERE
    ( staff_role = 'Driver'
      AND natureofclaim = 'Medical' )
    OR ( staff_role != 'Driver'
         AND natureofclaim != 'Medical' ); 


-- A-¬A
--Select the report content from Expert Witness with ID not equal to 1
SELECT
    reportcontent
FROM
    expert_report
WHERE
    expertid != 1;

--inner join, left join, full join
SELECT
    *
FROM
         claims
    INNER JOIN payment ON payment.cl_key = claims.cl_key;

SELECT
    *
FROM
    claims
    LEFT JOIN payment ON payment.cl_key = claims.cl_key;

SELECT
    *
FROM
    staff
    FULL OUTER JOIN accident ON staff.staff_no = accident.staff_no; 

--Aggregation

--average payment
SELECT
    AVG(MAX(p_amount))
FROM
    payment
GROUP BY
    payment_no;
--counting the amount of reports by expert witness
SELECT
    COUNT(reportcontent)
FROM
    expert_report
GROUP BY
    expertid;
    
-- Correlated subquery
DROP VIEW claimantpayment;

CREATE VIEW claimantpayment AS
    SELECT
        claimant.cl_name,
        payment.p_amount
    FROM
             claimant
        JOIN claims  claims ON claims.claimant_id = claimant.claimant_id
        JOIN payment payment ON claims.cl_key = payment.cl_key;

SELECT
    cl_name,
    p_amount
FROM
    claimantpayment
WHERE
    p_amount >= (
        SELECT
            AVG(p_amount)
        FROM
            claimantpayment
    );