MERGE (s1_String:EN {id:'s1_String'}) ON CREATE SET s1_String.hasName='String', s1_String.hasPotency=1;
WITH 1 AS _
MATCH (x:EN {id:'s1_String'}), (y:EN {id:'mm_PDT'}) MERGE (x)-[:hasDeclaredType]->(y);


CREATE (uac:AC {id:'AC_userAddAttr',
                kind:'UserEdit',
                op:'addAttribute',
                target:'s1_Person',
                attrName:'name',
                attrType:'String',
                ts:timestamp()});


MATCH (c:EN {id:'s1_Person'})
MATCH (c)<-[:isConnectedTo]-(:PA {hasName:'ct_class'})<-[:hasRole]-(ct:EN)-[:hasDeclaredType]->(:EN {id:'mm_CTR'})
MATCH (ct)-[:hasRole]->(:PA {hasName:'ct_table'})-[:isConnectedTo]->(t:EN)
MATCH (p:EN {id:'s1_String'})
WHERE NOT EXISTS {
  MATCH (a:EN)-[:hasDeclaredType]->(:EN {id:'mm_Attr'})
  MATCH (a)-[:hasRole]->(:PA {hasName:'attrs'})-[:isConnectedTo]->(c)
  MATCH (a)-[:hasAttribute]->(an:AT {name:'name', hasValue:'name'})
}
WITH c, t, p, 'name' AS an, 'String' AS tn

CREATE (h1:AC {id:'AC_createNameAttr', kind:'Create', target:'Attribute', name:'name', is_primary:false, ts:timestamp()})
CREATE (s1_name:EN {id:'s1_name', hasName:'name', hasPotency:1})
CREATE (s1_name)-[:hasDeclaredType]->(:EN {id:'mm_Attr'})
WITH c, t, p, an, tn, h1, s1_name
MATCH (mmAttr:EN {id:'mm_Attr'}) MERGE (s1_name)-[:hasDeclaredType]->(mmAttr)
WITH c, t, p, an, tn, h1, s1_name
CREATE (s1_name)-[:hasAttribute]->(:AT {id:'s1_name.is_primary', name:'is_primary', hasValue:false})
CREATE (s1_name)-[:hasAttribute]->(:AT {id:'s1_name.name',       name:'name',       hasValue:'name'})
CREATE (s1_name)-[:hasRole]->(:PA {id:'s1_name.attrs', hasName:'attrs'})-[:isConnectedTo]->(c)
CREATE (s1_name)-[:hasRole]->(:PA {id:'s1_name.type',  hasName:'type'})-[:isConnectedTo]->(p)

CREATE (h2:AC {id:'AC_createNameCol', kind:'Create', target:'Column', name:'name', type:'String', ts:timestamp()})
CREATE (h1)-[:follows]->(h2)
CREATE (t1_nameCol:EN {id:'t1_nameCol', hasName:'nameCol', hasPotency:1})
WITH c, t, p, an, tn, h1, h2, s1_name, t1_nameCol
MATCH (mmCol:EN {id:'mm_Col'}) MERGE (t1_nameCol)-[:hasDeclaredType]->(mmCol)
WITH c, t, p, an, tn, h1, h2, s1_name, t1_nameCol
CREATE (t1_nameCol)-[:hasAttribute]->(:AT {id:'t1_nameCol.type', name:'type', hasValue:'String'})
CREATE (t1_nameCol)-[:hasAttribute]->(:AT {id:'t1_nameCol.name', name:'name', hasValue:'name'})
CREATE (t1_nameCol)-[:hasRole]->(:PA {id:'t1_nameCol.cols', hasName:'cols'})-[:isConnectedTo]->(t)

CREATE (h3:AC {id:'AC_createAcrName', kind:'Create', target:'AttrColRel', ts:timestamp()})
CREATE (h2)-[:follows]->(h3)
CREATE (acr_name:EN {id:'acr_name', hasName:'acr_name', hasPotency:1})
WITH s1_name, t1_nameCol, acr_name
MATCH (mmACR:EN {id:'mm_ACR'}) MERGE (acr_name)-[:hasDeclaredType]->(mmACR)
WITH s1_name, t1_nameCol, acr_name
CREATE (acr_name)-[:hasRole]->(:PA {id:'acr_name.ac_attr', hasName:'ac_attr'})-[:isConnectedTo]->(s1_name)
CREATE (acr_name)-[:hasRole]->(:PA {id:'acr_name.ac_col',  hasName:'ac_col'})-[:isConnectedTo]->(t1_nameCol);


MATCH (row:EN)-[:hasDeclaredType]->(t1_PeT:EN {id:'t1_PeT'})
WITH row
CALL (row) {
  WITH row
  CREATE (cell:AT {id:row.id+'.name', name:'name', hasValue:null})
  CREATE (row)-[:hasAttribute]->(cell)
  CREATE (lift:AC {id:'AC_addCell_'+row.id, kind:'Create', target:'cell', row:row.id, ts:timestamp()})
  RETURN cell, lift
}
RETURN count(*) AS o2_cells_added;


MATCH (uac:AC {id:'AC_userAddAttr'}), (h1:AC {id:'AC_createNameAttr'})
MERGE (uac)-[:follows]->(h1);


MATCH (n) WHERE n:EN OR n:RE OR n:PA OR n:AT
RETURN count(n) AS R_after_create;

MATCH (a:AC) RETURN count(a) AS AC_nodes_total;
