# Artefact bundle — Action-Request Semantics for Multi-Level BX Maintenance

This bundle is the runnable companion to the ICGT 2026 paper
*Action-Request Semantics for Multi-Level Bidirectional View Maintenance with
Guarded Triple-Graph Updates*.

It contains:

| File | What it is |
|------|------------|
| `cd2rdbm_two_scenarios.hutn` | HUTN serialisation of the three-level CD↔RDBMS kernel graph (O0/O1/O2) and the two ARTs `R_create_attr` and `R_replace_name`. This is the **specification**. |
| `00_cleanup.cypher` | Wipe the Neo4j database. |
| `01_load_model.cypher` | Load the kernel graph as a property graph. |
| `02_scenario_create.cypher` | Run scenario CREATE (Sec. 5.1 of the paper). |
| `03_scenario_replace.cypher` | Run scenario REPLACE (Sec. 5.2 of the paper). |
| `99_table2_summary.cypher` | Print `|R|` and the emitted `AC` trace — reproduces Table 2. |

## Requirements

- **Neo4j 5.x** (Desktop, Server, or `neo4j` Docker image).
  No APOC, no GDS, no plugins required.
- A fresh empty database (or run `00_cleanup.cypher` first).

## How to reproduce Table 2

In Neo4j Browser, run the scripts in this order (one file at a time):

```text
00_cleanup.cypher
01_load_model.cypher              -> reports R_baseline
99_table2_summary.cypher          -> baseline row of Table 2

02_scenario_create.cypher         -> reports R_after_create  (= baseline + 6)
99_table2_summary.cypher          -> Create row of Table 2

00_cleanup.cypher                 -- start fresh for Replace
01_load_model.cypher
03_scenario_replace.cypher        -> reports R_after_replace (= baseline)
99_table2_summary.cypher          -> Replace row of Table 2
```

The emitted `AC` nodes form a `follows`-ordered chain; the last query in
`99_table2_summary.cypher` prints the longest chain in the database, which
is the replayable trace referenced by the paper.

## What the structural counts encode

The kernel substrate uses four structural node kinds (`EN`, `RE`, `PA`, `AT`)
plus three behavioural kinds (`OP`, `AO`, `AC`). The paper's `|R|` counts
**only** structural nodes; behavioural nodes (`AC` traces, `OP` templates,
`AO` atoms) are excluded so that the extraction `[[·]]` of Lemma 1 yields a
pure typed triple graph.




