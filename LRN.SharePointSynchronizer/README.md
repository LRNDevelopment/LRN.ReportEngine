# LRN.SharePointSynchronizer (placeholder)

This project represents your colleague's pipeline:

- Reads the **latest LineLevel/ClaimLevel** worked CSVs from the server (file names include `RunID`).
- Generates **payer policy** and **coding master** outputs.
- Updates `LRN_Run_Log` columns:
  - `PayerPolicyValidationStatus`
  - `CodingValidationStatus`
  - `AveragesProcessStatus`

This repo includes only a *minimal placeholder* interface to keep the overall solution consistent.
