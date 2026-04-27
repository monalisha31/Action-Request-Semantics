CREATE (mm_Class:EN  {id:'mm_Class',  hasName:'Class',             hasPotency:2});
CREATE (mm_Assoc:EN  {id:'mm_Assoc',  hasName:'Association',       hasPotency:2});
CREATE (mm_Attr:EN   {id:'mm_Attr',   hasName:'Attribute',         hasPotency:2});
CREATE (mm_PDT:EN    {id:'mm_PDT',    hasName:'PrimitiveDataType', hasPotency:2});
CREATE (mm_Table:EN  {id:'mm_Table',  hasName:'Table',             hasPotency:2});
CREATE (mm_FKey:EN   {id:'mm_FKey',   hasName:'FKey',              hasPotency:2});
CREATE (mm_Col:EN    {id:'mm_Col',    hasName:'Column',            hasPotency:2});
CREATE (mm_CTR:EN    {id:'mm_CTR',    hasName:'ClassTableRel',     hasPotency:2});
CREATE (mm_AFR:EN    {id:'mm_AFR',    hasName:'AssocFKeyRel',      hasPotency:2});
CREATE (mm_ACR:EN    {id:'mm_ACR',    hasName:'AttrColRel',        hasPotency:2});

MATCH (a:EN {id:'mm_Attr'})  CREATE (a)-[:hasAttribute]->(:AT {id:'mm_Attr.is_primary', name:'is_primary', hasDataType:'BOOLEAN'});
MATCH (a:EN {id:'mm_Attr'})  CREATE (a)-[:hasAttribute]->(:AT {id:'mm_Attr.name',       name:'name',       hasDataType:'STRING'});
MATCH (c:EN {id:'mm_Col'})   CREATE (c)-[:hasAttribute]->(:AT {id:'mm_Col.type',        name:'type',       hasDataType:'STRING'});
MATCH (c:EN {id:'mm_Col'})   CREATE (c)-[:hasAttribute]->(:AT {id:'mm_Col.name',        name:'name',       hasDataType:'STRING'});

MATCH (r:EN {id:'mm_CTR'}), (s:EN {id:'mm_Class'}) CREATE (r)-[:hasRole]->(:PA {id:'mm_CTR.ct_class', hasName:'ct_class'})-[:isConnectedTo]->(s);
MATCH (r:EN {id:'mm_CTR'}), (t:EN {id:'mm_Table'}) CREATE (r)-[:hasRole]->(:PA {id:'mm_CTR.ct_table', hasName:'ct_table'})-[:isConnectedTo]->(t);
MATCH (r:EN {id:'mm_AFR'}), (s:EN {id:'mm_Assoc'}) CREATE (r)-[:hasRole]->(:PA {id:'mm_AFR.af_assoc', hasName:'af_assoc'})-[:isConnectedTo]->(s);
MATCH (r:EN {id:'mm_AFR'}), (t:EN {id:'mm_FKey'})  CREATE (r)-[:hasRole]->(:PA {id:'mm_AFR.af_fkey',  hasName:'af_fkey'})-[:isConnectedTo]->(t);
MATCH (r:EN {id:'mm_ACR'}), (s:EN {id:'mm_Attr'})  CREATE (r)-[:hasRole]->(:PA {id:'mm_ACR.ac_attr',  hasName:'ac_attr'})-[:isConnectedTo]->(s);
MATCH (r:EN {id:'mm_ACR'}), (t:EN {id:'mm_Col'})   CREATE (r)-[:hasRole]->(:PA {id:'mm_ACR.ac_col',   hasName:'ac_col'})-[:isConnectedTo]->(t);


CREATE (s1_Company :EN {id:'s1_Company',  hasName:'Company',  hasPotency:1});
CREATE (s1_Person  :EN {id:'s1_Person',   hasName:'Person',   hasPotency:1});
CREATE (s1_Customer:EN {id:'s1_Customer', hasName:'Customer', hasPotency:1});
CREATE (s1_employee:EN {id:'s1_employee', hasName:'employee', hasPotency:1});
CREATE (s1_int     :EN {id:'s1_int',      hasName:'int',      hasPotency:1});
CREATE (s1_custid  :EN {id:'s1_custid',   hasName:'cust_id',  hasPotency:1});
CREATE (t1_CoT     :EN {id:'t1_CoT',      hasName:'CompanyT', hasPotency:1});
CREATE (t1_PeT     :EN {id:'t1_PeT',      hasName:'PersonT',  hasPotency:1});
CREATE (t1_CuT     :EN {id:'t1_CuT',      hasName:'CustomerT',hasPotency:1});
CREATE (t1_empFK   :EN {id:'t1_empFK',    hasName:'empFK',    hasPotency:1});
CREATE (t1_ciCol   :EN {id:'t1_ciCol',    hasName:'ciCol',    hasPotency:1});
CREATE (ctr_Company :EN {id:'ctr_Company',  hasName:'ctr_Company',  hasPotency:1});
CREATE (ctr_Person  :EN {id:'ctr_Person',   hasName:'ctr_Person',   hasPotency:1});
CREATE (ctr_Customer:EN {id:'ctr_Customer', hasName:'ctr_Customer', hasPotency:1});
CREATE (afr_emp     :EN {id:'afr_emp',      hasName:'afr_emp',      hasPotency:1});
CREATE (acr_custid  :EN {id:'acr_custid',   hasName:'acr_custid',   hasPotency:1});

MATCH (x:EN {id:'s1_Company'}),  (y:EN {id:'mm_Class'}) CREATE (x)-[:hasDeclaredType]->(y);
MATCH (x:EN {id:'s1_Person'}),   (y:EN {id:'mm_Class'}) CREATE (x)-[:hasDeclaredType]->(y);
MATCH (x:EN {id:'s1_Customer'}), (y:EN {id:'mm_Class'}) CREATE (x)-[:hasDeclaredType]->(y);
MATCH (x:EN {id:'s1_employee'}), (y:EN {id:'mm_Assoc'}) CREATE (x)-[:hasDeclaredType]->(y);
MATCH (x:EN {id:'s1_int'}),      (y:EN {id:'mm_PDT'})   CREATE (x)-[:hasDeclaredType]->(y);
MATCH (x:EN {id:'s1_custid'}),   (y:EN {id:'mm_Attr'})  CREATE (x)-[:hasDeclaredType]->(y);
MATCH (x:EN {id:'t1_CoT'}),      (y:EN {id:'mm_Table'}) CREATE (x)-[:hasDeclaredType]->(y);
MATCH (x:EN {id:'t1_PeT'}),      (y:EN {id:'mm_Table'}) CREATE (x)-[:hasDeclaredType]->(y);
MATCH (x:EN {id:'t1_CuT'}),      (y:EN {id:'mm_Table'}) CREATE (x)-[:hasDeclaredType]->(y);
MATCH (x:EN {id:'t1_empFK'}),    (y:EN {id:'mm_FKey'})  CREATE (x)-[:hasDeclaredType]->(y);
MATCH (x:EN {id:'t1_ciCol'}),    (y:EN {id:'mm_Col'})   CREATE (x)-[:hasDeclaredType]->(y);
MATCH (x:EN {id:'ctr_Company'}), (y:EN {id:'mm_CTR'})   CREATE (x)-[:hasDeclaredType]->(y);
MATCH (x:EN {id:'ctr_Person'}),  (y:EN {id:'mm_CTR'})   CREATE (x)-[:hasDeclaredType]->(y);
MATCH (x:EN {id:'ctr_Customer'}),(y:EN {id:'mm_CTR'})   CREATE (x)-[:hasDeclaredType]->(y);
MATCH (x:EN {id:'afr_emp'}),     (y:EN {id:'mm_AFR'})   CREATE (x)-[:hasDeclaredType]->(y);
MATCH (x:EN {id:'acr_custid'}),  (y:EN {id:'mm_ACR'})   CREATE (x)-[:hasDeclaredType]->(y);

MATCH (x:EN {id:'s1_custid'}) CREATE (x)-[:hasAttribute]->(:AT {id:'s1_custid.is_primary', name:'is_primary', hasValue:true});
MATCH (x:EN {id:'s1_custid'}) CREATE (x)-[:hasAttribute]->(:AT {id:'s1_custid.name',       name:'name',       hasValue:'cust_id'});
MATCH (x:EN {id:'t1_ciCol'})  CREATE (x)-[:hasAttribute]->(:AT {id:'t1_ciCol.type',        name:'type',       hasValue:'int'});
MATCH (x:EN {id:'t1_ciCol'})  CREATE (x)-[:hasAttribute]->(:AT {id:'t1_ciCol.name',        name:'name',       hasValue:'cust_id'});

MATCH (s:EN {id:'s1_Customer'}), (p:EN {id:'s1_Person'})  CREATE (s)-[:hasRole]->(:PA {id:'s1_Customer.parent', hasName:'parent'})-[:isConnectedTo]->(p);
MATCH (a:EN {id:'s1_employee'}), (c:EN {id:'s1_Company'}) CREATE (a)-[:hasRole]->(:PA {id:'s1_employee.src',  hasName:'src'})-[:isConnectedTo]->(c);
MATCH (a:EN {id:'s1_employee'}), (p:EN {id:'s1_Person'})  CREATE (a)-[:hasRole]->(:PA {id:'s1_employee.dest', hasName:'dest'})-[:isConnectedTo]->(p);
MATCH (a:EN {id:'s1_custid'}),   (c:EN {id:'s1_Customer'})CREATE (a)-[:hasRole]->(:PA {id:'s1_custid.attrs', hasName:'attrs'})-[:isConnectedTo]->(c);
MATCH (a:EN {id:'s1_custid'}),   (i:EN {id:'s1_int'})     CREATE (a)-[:hasRole]->(:PA {id:'s1_custid.type',  hasName:'type'})-[:isConnectedTo]->(i);

MATCH (f:EN {id:'t1_empFK'}), (c:EN {id:'t1_CoT'}) CREATE (f)-[:hasRole]->(:PA {id:'t1_empFK.fkeys', hasName:'fkeys'})-[:isConnectedTo]->(c);
MATCH (f:EN {id:'t1_empFK'}), (p:EN {id:'t1_PeT'}) CREATE (f)-[:hasRole]->(:PA {id:'t1_empFK.refs',  hasName:'refs'})-[:isConnectedTo]->(p);
MATCH (c:EN {id:'t1_ciCol'}), (t:EN {id:'t1_CuT'}) CREATE (c)-[:hasRole]->(:PA {id:'t1_ciCol.cols', hasName:'cols'})-[:isConnectedTo]->(t);
MATCH (c:EN {id:'t1_ciCol'}), (t:EN {id:'t1_CuT'}) CREATE (c)-[:hasRole]->(:PA {id:'t1_ciCol.pkey', hasName:'pkey'})-[:isConnectedTo]->(t);

MATCH (r:EN {id:'ctr_Company'}),  (s:EN {id:'s1_Company'}),  (t:EN {id:'t1_CoT'}) CREATE (r)-[:hasRole]->(:PA {id:'ctr_Company.ct_class', hasName:'ct_class'})-[:isConnectedTo]->(s), (r)-[:hasRole]->(:PA {id:'ctr_Company.ct_table', hasName:'ct_table'})-[:isConnectedTo]->(t);
MATCH (r:EN {id:'ctr_Person'}),   (s:EN {id:'s1_Person'}),   (t:EN {id:'t1_PeT'}) CREATE (r)-[:hasRole]->(:PA {id:'ctr_Person.ct_class',  hasName:'ct_class'})-[:isConnectedTo]->(s), (r)-[:hasRole]->(:PA {id:'ctr_Person.ct_table',  hasName:'ct_table'})-[:isConnectedTo]->(t);
MATCH (r:EN {id:'ctr_Customer'}), (s:EN {id:'s1_Customer'}), (t:EN {id:'t1_CuT'}) CREATE (r)-[:hasRole]->(:PA {id:'ctr_Customer.ct_class',hasName:'ct_class'})-[:isConnectedTo]->(s), (r)-[:hasRole]->(:PA {id:'ctr_Customer.ct_table',hasName:'ct_table'})-[:isConnectedTo]->(t);
MATCH (r:EN {id:'afr_emp'}),      (s:EN {id:'s1_employee'}), (t:EN {id:'t1_empFK'}) CREATE (r)-[:hasRole]->(:PA {id:'afr_emp.af_assoc', hasName:'af_assoc'})-[:isConnectedTo]->(s), (r)-[:hasRole]->(:PA {id:'afr_emp.af_fkey', hasName:'af_fkey'})-[:isConnectedTo]->(t);
MATCH (r:EN {id:'acr_custid'}),   (s:EN {id:'s1_custid'}),   (t:EN {id:'t1_ciCol'}) CREATE (r)-[:hasRole]->(:PA {id:'acr_custid.ac_attr', hasName:'ac_attr'})-[:isConnectedTo]->(s), (r)-[:hasRole]->(:PA {id:'acr_custid.ac_col', hasName:'ac_col'})-[:isConnectedTo]->(t);


CREATE (s2_acme  :EN {id:'s2_acme',   hasName:'acme',   hasPotency:0});
CREATE (s2_alice :EN {id:'s2_alice',  hasName:'alice',  hasPotency:0});
CREATE (s2_bob   :EN {id:'s2_bob',    hasName:'bob',    hasPotency:0});
CREATE (s2_emp1  :EN {id:'s2_emp1',   hasName:'emp1',   hasPotency:0});
CREATE (t2_acmeRow :EN {id:'t2_acmeRow',  hasName:'acmeRow',  hasPotency:0});
CREATE (t2_aliceRow:EN {id:'t2_aliceRow', hasName:'aliceRow', hasPotency:0});
CREATE (t2_bobRow  :EN {id:'t2_bobRow',   hasName:'bobRow',   hasPotency:0});
CREATE (t2_empFK1  :EN {id:'t2_empFK1',   hasName:'empFK1',   hasPotency:0});
CREATE (dctr_acme  :EN {id:'dctr_acme',   hasName:'dctr_acme',   hasPotency:0});
CREATE (dctr_alice :EN {id:'dctr_alice',  hasName:'dctr_alice',  hasPotency:0});
CREATE (dctr_bob   :EN {id:'dctr_bob',    hasName:'dctr_bob',    hasPotency:0});
CREATE (dafr_emp1  :EN {id:'dafr_emp1',   hasName:'dafr_emp1',   hasPotency:0});
CREATE (dacr_custid:EN {id:'dacr_custid', hasName:'dacr_custid', hasPotency:0});

MATCH (x:EN {id:'s2_acme'}),    (y:EN {id:'s1_Company'})  CREATE (x)-[:hasDeclaredType]->(y);
MATCH (x:EN {id:'s2_alice'}),   (y:EN {id:'s1_Person'})   CREATE (x)-[:hasDeclaredType]->(y);
MATCH (x:EN {id:'s2_bob'}),     (y:EN {id:'s1_Customer'}) CREATE (x)-[:hasDeclaredType]->(y);
MATCH (x:EN {id:'s2_emp1'}),    (y:EN {id:'s1_employee'}) CREATE (x)-[:hasDeclaredType]->(y);
MATCH (x:EN {id:'t2_acmeRow'}), (y:EN {id:'t1_CoT'})      CREATE (x)-[:hasDeclaredType]->(y);
MATCH (x:EN {id:'t2_aliceRow'}),(y:EN {id:'t1_PeT'})      CREATE (x)-[:hasDeclaredType]->(y);
MATCH (x:EN {id:'t2_bobRow'}),  (y:EN {id:'t1_CuT'})      CREATE (x)-[:hasDeclaredType]->(y);
MATCH (x:EN {id:'t2_empFK1'}),  (y:EN {id:'t1_empFK'})    CREATE (x)-[:hasDeclaredType]->(y);
MATCH (x:EN {id:'dctr_acme'}),  (y:EN {id:'ctr_Company'}) CREATE (x)-[:hasDeclaredType]->(y);
MATCH (x:EN {id:'dctr_alice'}), (y:EN {id:'ctr_Person'})  CREATE (x)-[:hasDeclaredType]->(y);
MATCH (x:EN {id:'dctr_bob'}),   (y:EN {id:'ctr_Customer'})CREATE (x)-[:hasDeclaredType]->(y);
MATCH (x:EN {id:'dafr_emp1'}),  (y:EN {id:'afr_emp'})     CREATE (x)-[:hasDeclaredType]->(y);
MATCH (x:EN {id:'dacr_custid'}),(y:EN {id:'acr_custid'})  CREATE (x)-[:hasDeclaredType]->(y);

MATCH (x:EN {id:'s2_bob'})      CREATE (x)-[:hasAttribute]->(:AT {id:'s2_bob.cust_id',     name:'cust_id',  hasValue:42});
MATCH (x:EN {id:'t2_acmeRow'})  CREATE (x)-[:hasAttribute]->(:AT {id:'t2_acmeRow.objectId', name:'objectId', hasValue:1});
MATCH (x:EN {id:'t2_aliceRow'}) CREATE (x)-[:hasAttribute]->(:AT {id:'t2_aliceRow.objectId',name:'objectId', hasValue:10});
MATCH (x:EN {id:'t2_bobRow'})   CREATE (x)-[:hasAttribute]->(:AT {id:'t2_bobRow.objectId',  name:'objectId', hasValue:20});
MATCH (x:EN {id:'t2_bobRow'})   CREATE (x)-[:hasAttribute]->(:AT {id:'t2_bobRow.cust_id',   name:'cust_id',  hasValue:42});

MATCH (a:EN {id:'s2_emp1'}),    (c:EN {id:'s2_acme'})     CREATE (a)-[:hasRole]->(:PA {id:'s2_emp1.src',   hasName:'src'})-[:isConnectedTo]->(c);
MATCH (a:EN {id:'s2_emp1'}),    (b:EN {id:'s2_bob'})      CREATE (a)-[:hasRole]->(:PA {id:'s2_emp1.dest',  hasName:'dest'})-[:isConnectedTo]->(b);
MATCH (f:EN {id:'t2_empFK1'}),  (c:EN {id:'t2_acmeRow'})  CREATE (f)-[:hasRole]->(:PA {id:'t2_empFK1.fkeys',hasName:'fkeys'})-[:isConnectedTo]->(c);
MATCH (f:EN {id:'t2_empFK1'}),  (b:EN {id:'t2_bobRow'})   CREATE (f)-[:hasRole]->(:PA {id:'t2_empFK1.refs', hasName:'refs'})-[:isConnectedTo]->(b);

MATCH (r:EN {id:'dctr_acme'}),  (s:EN {id:'s2_acme'}),    (t:EN {id:'t2_acmeRow'})  CREATE (r)-[:hasRole]->(:PA {id:'dctr_acme.ct_class', hasName:'ct_class'})-[:isConnectedTo]->(s), (r)-[:hasRole]->(:PA {id:'dctr_acme.ct_table', hasName:'ct_table'})-[:isConnectedTo]->(t);
MATCH (r:EN {id:'dctr_alice'}), (s:EN {id:'s2_alice'}),   (t:EN {id:'t2_aliceRow'}) CREATE (r)-[:hasRole]->(:PA {id:'dctr_alice.ct_class',hasName:'ct_class'})-[:isConnectedTo]->(s), (r)-[:hasRole]->(:PA {id:'dctr_alice.ct_table',hasName:'ct_table'})-[:isConnectedTo]->(t);
MATCH (r:EN {id:'dctr_bob'}),   (s:EN {id:'s2_bob'}),     (t:EN {id:'t2_bobRow'})   CREATE (r)-[:hasRole]->(:PA {id:'dctr_bob.ct_class',  hasName:'ct_class'})-[:isConnectedTo]->(s), (r)-[:hasRole]->(:PA {id:'dctr_bob.ct_table',  hasName:'ct_table'})-[:isConnectedTo]->(t);
MATCH (r:EN {id:'dafr_emp1'}),  (s:EN {id:'s2_emp1'}),    (t:EN {id:'t2_empFK1'})   CREATE (r)-[:hasRole]->(:PA {id:'dafr_emp1.af_assoc',hasName:'af_assoc'})-[:isConnectedTo]->(s), (r)-[:hasRole]->(:PA {id:'dafr_emp1.af_fkey', hasName:'af_fkey'})-[:isConnectedTo]->(t);
MATCH (r:EN {id:'dacr_custid'}),(s:EN {id:'s2_bob'}),     (t:EN {id:'t2_bobRow'})   CREATE (r)-[:hasRole]->(:PA {id:'dacr_custid.ac_attr',hasName:'ac_attr'})-[:isConnectedTo]->(s), (r)-[:hasRole]->(:PA {id:'dacr_custid.ac_col',hasName:'ac_col'})-[:isConnectedTo]->(t);


MATCH (n) WHERE n:EN OR n:RE OR n:PA OR n:AT
RETURN labels(n)[0] AS kind, count(n) AS n
ORDER BY kind;

MATCH (n) WHERE n:EN OR n:RE OR n:PA OR n:AT
RETURN count(n) AS R_baseline;
