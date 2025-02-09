SELECT 'IN empty set',count() FROM system.numbers WHERE number IN (SELECT toUInt64(1) WHERE 0);
SELECT 'IN non-empty set',count() FROM (SELECT number FROM system.numbers LIMIT 10) t1 WHERE t1.number IN (SELECT toUInt64(1) WHERE 1);
SELECT 'NOT IN empty set',count() FROM (SELECT number FROM system.numbers LIMIT 10) WHERE number NOT IN (SELECT toUInt64(1) WHERE 0);

SELECT 'INNER JOIN empty set',count() FROM system.numbers INNER JOIN (SELECT toUInt64(1) AS x WHERE 0) ON system.numbers.number = x;
SELECT 'INNER JOIN non-empty set',count() FROM (SELECT number FROM system.numbers LIMIT 10) t1 INNER JOIN (SELECT toUInt64(1) AS x WHERE 1) ON t1.number = x;

SELECT 'RIGHT JOIN empty set',count() FROM system.numbers RIGHT JOIN (SELECT toUInt64(1) AS x WHERE 0) ON system.numbers.number = x;
SELECT 'RIGHT JOIN non-empty set',count() FROM (SELECT number FROM system.numbers LIMIT 10) t1 RIGHT JOIN (SELECT toUInt64(1) AS x WHERE 1) ON t1.number = x;

SELECT 'LEFT JOIN empty set',count() FROM (SELECT number FROM system.numbers LIMIT 10) t1 LEFT JOIN (SELECT toUInt64(1) AS x WHERE 0) ON t1.number = x;
SELECT 'LEFT JOIN non-empty set',count() FROM (SELECT number FROM system.numbers LIMIT 10) t1 LEFT JOIN (SELECT toUInt64(1) AS x WHERE 1) ON t1.number = x;

SELECT 'IN empty set not in WHERE clause',avg(number IN (SELECT toUInt64(1) WHERE 0)) FROM system.numbers;
SELECT 'IN empty set not in WHERE clause',avg(number IN (SELECT toUInt64(1) WHERE 0) AND number > 1) FROM system.numbers;
SELECT 'IN non-empty set not in WHERE clause',avg(number IN (SELECT toUInt64(1) WHERE 1)) FROM (SELECT number FROM system.numbers limit 10);
SELECT 'NOT IN empty set not in WHERE clause',avg(number NOT IN (SELECT toUInt64(1) WHERE 0)) FROM (SELECT number FROM system.numbers LIMIT 10);

SELECT 'multiple sets IN empty set OR IN non-empty set',count() FROM (SELECT number FROM system.numbers LIMIT 10) WHERE number IN (SELECT toUInt64(1) WHERE 0) OR number IN (SELECT toUInt64(1) WHERE 1);
SELECT 'multiple sets IN empty set OR NOT IN non-empty set',count() FROM (SELECT number FROM system.numbers LIMIT 10) WHERE number IN (SELECT toUInt64(1) WHERE 0) OR number NOT IN (SELECT toUInt64(1) WHERE 1);
SELECT 'multiple sets NOT IN empty set AND IN non-empty set',count() FROM (SELECT number FROM system.numbers LIMIT 10) WHERE number NOT IN (SELECT toUInt64(1) WHERE 0) AND number IN (SELECT toUInt64(1) WHERE 1);
SELECT 'multiple sets INNER JOIN empty set AND IN empty set',count() FROM system.numbers INNER JOIN (SELECT toUInt64(1) AS x WHERE 0) ON system.numbers.number = x WHERE system.numbers.number IN (SELECT toUInt64(1) WHERE 0);
SELECT 'multiple sets INNER JOIN empty set AND IN non-empty set',count() FROM (SELECT number FROM system.numbers LIMIT 10) t1 INNER JOIN (SELECT toUInt64(1) AS x WHERE 0) ON t1.number = x WHERE t1.number IN (SELECT toUInt64(1) WHERE 1);
SELECT 'multiple sets INNER JOIN non-empty set AND IN non-empty set',count() FROM (SELECT number FROM system.numbers LIMIT 10) t1 INNER JOIN (SELECT toUInt64(1) AS x WHERE 1) ON t1.number = x WHERE t1.number IN (SELECT toUInt64(1) WHERE 1);

SELECT number FROM system.numbers WHERE NOT ignore(number IN (SELECT toUInt64(1) WHERE 0));
