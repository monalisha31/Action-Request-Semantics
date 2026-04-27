MATCH (n) DETACH DELETE n;
RETURN 'database cleared' AS status;
