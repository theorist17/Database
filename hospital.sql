use hospital;
select * from patients;
select * from doctors;
select * from tests;
select * from rooms;
select * from appointments;
select * from checkups;
select * from stays;
SELECT * FROM doctors WHERE doctorID = 1;

SELECT * FROM patients WHERE patientID = 9203221234567;
SELECT *
FROM appointments a
INNER JOIN patients p
WHERE p.patientID = a.patientID and p.patientID = 9203221234567;

SELECT  *, 'appointment' as Source
FROM appointments
where hasPaid = 0 and patientID = 9203221234567
union 
SELECT *, 'checkup' as Source
FROM checkups 
where hasPaid = 0 and patientID = 9203221234567
union
SELECT *, 'stay' as Source
FROM stays 
where hasPaid = 0 and patientID = 9203221234567;

select * from appointments;

SELECT  *, '진료' as Source
FROM appointments
where hasPaid = 0 and ? <= timeStart and timeEnd <= ?
UNION
SELECT *, '검사' as Source
FROM checkups 
where hasPaid = 0  and ? <= timeStart and timeEnd <= ?
UNION
SELECT *, '입원' as Source
FROM checkups 
where hasPaid = 0  and ? <= timeStart and timeEnd <= ?;








