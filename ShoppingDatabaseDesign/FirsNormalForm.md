## First Normal Form (1NF)

- It should only have single(atomic) valued attributes/columns.
- Values stored in a column should be of the same domain
- All the columns in a table should have unique names.
- And the order in which data is stored, does not matter.

## Second Normal Form (2NF)

And, it should not have Partial Dependency.

- Partial Dependency exists, when for a **composite primary key**, any attribute in the table depends only on **a part of** the primary key and not on the complete primary key.
- To remove Partial dependency, we can **divide** the table, remove the attribute which is causing partial dependency, and move it to some other table where it fits in well.

## Third Normal Form (3NF)

And, it doesn't have Transitive Dependency.

- This is Transitive Dependency. When **a non-prime attribute** depends on **other non-prime attributes** rather than depending upon **the prime attributes or primary key**.
- The solution is to divide the table also.
- The advantage of removing transitive dependency is:
  -- Amount of data duplication is reduced.
  -- Data integrity achieved
