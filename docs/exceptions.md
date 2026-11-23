# Exceptions

One row per rule this repository cannot meet yet. The reason and the revisit date
are required. The shared `standard` job reads this file.

| Rule | Reason | Revisit |
| --- | --- | --- |
| `C7.3` | The Nest 11 application is still built and tested with `npm`, `tsc` and Vitest, and formatted and linted with Biome. Nest needs the TypeScript compiler's decorator and metadata emit, and the Nest testing harness (`@nestjs/testing` with `supertest`) runs on Vitest. The recipes expose the work behind `fmt`, `fmt-check`, `typecheck`, `test` and `lint`, so a later migration changes the recipe bodies only. Porting the fixture to Bun is a rewrite of its build and test setup, not a toolchain pin. | 2027-05-31 |
| `C7.4` | `scripts/prune.mjs`, `scripts/write-openapi.mjs` and `scripts/agent-files.mjs` are still `.mjs` on Node, and `vitest.config.mts` is the Vitest config. They move to Bun TypeScript with the C7.3 migration. | 2027-05-31 |
