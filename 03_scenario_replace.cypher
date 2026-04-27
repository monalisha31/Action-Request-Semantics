CREATE (uac:AC {id:'AC_userRename',
                kind:'UserEdit',
                op:'renameAttribute',
                target:'s1_custid',
                fromName:'cust_id',
                toName:'customer_id',
                ts:timestamp()});

MATCH (a:EN {id:'s1_custid'})-[:hasAttribute]->(an:AT {name:'name'})
SET an.hasValue = 'customer_id';


MATCH (rel:EN)-[:hasDeclaredType]->(:EN {id:'mm_ACR'})
MATCH (rel)-[:hasRole]->(:PA {hasName:'ac_attr'})-[:isConnectedTo]->(a:EN)
MATCH (rel)-[:hasRole]->(:PA {hasName:'ac_col'})-[:isConnectedTo]->(col:EN)
MATCH (a)-[:hasAttribute]->(an:AT {name:'name'})
MATCH (col)-[:hasAttribute]->(cn:AT {name:'name'})
WHERE an.hasValue <> cn.hasValue
WITH rel, a, col, an, cn

CREATE (h1:AC {id:'AC_R_replace_name',
               kind:'Replace',
               target:col.id+'.name',
               fromValue:cn.hasValue,
               toValue:an.hasValue,
               ts:timestamp()})
SET cn.hasValue = an.hasValue
WITH h1

MATCH (uac:AC {id:'AC_userRename'})
MERGE (uac)-[:follows]->(h1);


MATCH (row:EN {id:'t2_bobRow'})-[:hasAttribute]->(cell:AT {name:'cust_id'})
RETURN row.id AS row, cell.hasValue AS cell_value, 'O2 no-op' AS status;


MATCH (n) WHERE n:EN OR n:RE OR n:PA OR n:AT
RETURN count(n) AS R_after_replace;

MATCH (a:AC {kind:'Replace'}) RETURN count(a) AS replace_AC_emitted;

MATCH (col:EN {id:'t1_ciCol'})-[:hasAttribute]->(cn:AT {name:'name'})
RETURN col.id AS column, cn.hasValue AS new_name;
