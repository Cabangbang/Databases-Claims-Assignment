set serveroutput on
DECLARE
    temp_staff_name staff.staff_name%TYPE:='&STAFF_NAME';
    temp_staff_no staff.staff_no%TYPE:='&STAFF_NO';
    temp_staff_role staff.staff_role%TYPE:='&STAFF_ROLE';
    temp_staffint integer;

BEGIN
    if (temp_staff_no != 1) THEN
        INSERT INTO staff(staff_no, staff_name, staff_role) VALUES (temp_staff_no,temp_staff_name,temp_staff_role);
    ELSE
        if (temp_staffint = 0) then
            DBMS_OUTPUT.PUT_LINE('Does not exist');
        end if;
    end if;
end;

--pl/sql add data into staff table