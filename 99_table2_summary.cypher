MATCH (n) WHERE n:EN OR n:RE OR n:PA OR n:AT
RETURN count(n) AS R_structural_nodes;

MATCH (a:AC) RETURN count(a) AS AC_total, collect(a.kind) AS kinds;

MATCH path = (start:AC)-[:follows*]->(end:AC)
WHERE NOT EXISTS { MATCH (:AC)-[:follows]->(start) }
  AND NOT EXISTS { MATCH (end)-[:follows]->(:AC) }
RETURN [n IN nodes(path) | n.id] AS trace, length(path) AS hops
ORDER BY hops DESC LIMIT 5;
