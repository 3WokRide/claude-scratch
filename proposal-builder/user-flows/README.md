# Proposal Builder — User Flows

## Purpose

Mermaid flowcharts mapping every user task in Proposal Builder — screens, decisions, system calls, error states — for UX designers about to draw screens in Figma/FigJam. Not final UI, a map of every path so nothing surprises the designer mid-draw.

**Import**: paste the Mermaid code into a Mermaid-to-FigJam plugin (search "mermaid" in FigJam's plugin browser) for editable native shapes, or paste into Mermaid Live Editor for a static image.

This file is the contract all 22 flow files follow. Read it before writing or editing any `.mermaid` file in this folder — it's what keeps 22 independently-authored diagrams looking like one product map instead of 22 unrelated pictures.

## Folder map

```
user-flows/
├── auth/
├── dashboard/
├── host/
├── proposal/
├── services/
└── customization/
```

### auth/ (3) — session decision, not in CLAUDE.md (see COVERAGE.md)
| File | Covers |
|---|---|
| `sign-up.mermaid` | register → validation → session |
| `log-in.mermaid` | credentials → session |
| `password-reset.mermaid` | forgot → email → reset link → new password |

### dashboard/ (3)
| File | Covers |
|---|---|
| `dashboard-overview.mermaid` | load → the four launch points (new proposal, recent proposals, most-used presets, hosts without proposals) |
| `resume-draft-proposal.mermaid` | pick recent draft → reopen at its saved step |
| `start-proposal-from-preset.mermaid` | most-used bundle/template/tone → seeds a new proposal |

### host/ (3)
| File | Covers |
|---|---|
| `browse-hosts.mermaid` | table → filter/search/export |
| `gbp-search-import.mermaid` | GBP lookup → results → import |
| `single-host-view.mermaid` | detail → notes save → branch to proposals / service management / new proposal |

### proposal/ (9)
| File | Covers |
|---|---|
| `browse-proposals.mermaid` | list → filter/search → open |
| `create-proposal-discovery.mermaid` | steps 1–3: GBP search (skippable) → Strengths/Opportunities → bundle selection |
| `create-proposal-customize.mermaid` | steps 4–5: tone/pricing/template/color scheme/notes, custom services, optional case study |
| `create-proposal-generate-preview.mermaid` | steps 6–8: per-section AI generation → editable preview → Slides export → save on host |
| `regenerate-proposal-section.mermaid` | pick one section → regenerate → accept or revert |
| `save-and-resume-draft.mermaid` | cross-cutting: save/autosave at any step, exit, resume |
| `clone-proposal.mermaid` | duplicate as starting point → choose target host → lands in creation flow |
| `revise-proposal.mermaid` | reopen a completed proposal → edit/regenerate → re-export |
| `delete-proposal.mermaid` | confirm → delete |

### services/ (2)
| File | Covers |
|---|---|
| `services-overview.mermaid` | all hosts + per-host summary → cross-host overview → select host |
| `manage-host-services.mermaid` | view/create/edit/delete for one host, incl. seeding from the catalog |

### customization/ (2)
| File | Covers |
|---|---|
| `manage-presets.mermaid` | CRUD for tone / template / color-scheme presets, type-specific branches |
| `service-catalog.mermaid` | catalog CRUD → feeds custom-service step and AI bundle suggestions |

## Diagram conventions

### Shapes

| Node type | Mermaid syntax | Meaning |
|---|---|---|
| Start / End | `A(["Label"])` | Stadium/pill — entry or exit point |
| Screen | `B["Label"]` | Rectangle — a screen or state the user sees |
| System / backend | `C[["Label"]]` | Subroutine shape — a process with no UI |
| Decision | `D{"Label"}` | Diamond — always 2+ labeled outgoing edges |
| Error / edge case | any shape above + `:::errorNode` | Distinguish by class/color, not shape |

Prefix every label with its type: `Screen:`, `System:`, `Decision:`, `Error:`, `Edge case:`.

### classDef block — paste verbatim at the top of every file

```
classDef startEnd fill:#B3FFCC,stroke:#4CBB77,stroke-width:2px,color:#1A1A1A
classDef screen fill:#B3D9FF,stroke:#4A90D9,stroke-width:2px,color:#1A1A1A
classDef system fill:#E0E0E0,stroke:#9E9E9E,stroke-width:2px,color:#1A1A1A
classDef decision fill:#FFE066,stroke:#E6B800,stroke-width:2px,color:#1A1A1A
classDef errorNode fill:#FFB3B3,stroke:#E05C5C,stroke-width:2px,stroke-dasharray: 5 5,color:#1A1A1A
```

### Edges

- `-->` for forward, happy-path progress.
- `-.->` for retries / loop-backs (e.g. error → the screen the user retries from).
- Every edge labeled, including the first edge out of Start and the last edge into End: `B -->|"submits email"| C`.

### Direction

`flowchart LR` for mostly-linear flows; `flowchart TD` for short or wide-branching flows. Pick one per file, stay consistent within it.

## The quoting rule

**Every node and edge label wrapped in double quotes. Never a literal `"` character inside label text — reword instead.** `A["Screen: Enter email address"]`, not `A[Screen: Enter "email" address]`. Never use `#quot;` as a substitute — it displays as literal text in some renderers, including FigJam's. This is the single most common way these files fail to parse or fail to import cleanly.

## Shared vocabulary

Use these nouns identically across every file — no synonyms, no module-specific renaming:

**Host, Proposal, Service, Preset, Bundle** (Problem-Solution bundle), **Draft, Case study, Section**.

Fixed phrasings for recurring nodes — copy these exactly so the same real-world action reads identically wherever it appears:

| Action | Exact label |
|---|---|
| GBP lookup | `System: GBP lookup` |
| Any AI call | `System: AI generates <thing>` (e.g. `System: AI generates Strengths and Opportunities`) |
| Slides export | `System: Export to Google Slides` |

## Cross-flow handoff rule

When a flow hands off to another flow, it terminates at a stadium End node naming the target file path without extension:

```
K(["End: continues in proposal/create-proposal-customize"]):::startEnd
```

The receiving flow's Start node names its source the same way:

```
A(["Start: from proposal/create-proposal-discovery"]):::startEnd
```

Every named target must exist as a real file in this folder. A flow with more than one entry point draws a separate Start node per source (e.g. `create-proposal-discovery` is entered both from `dashboard-overview` and from `single-host-view`).

### Handoff pairs implied by the spec

| From | To |
|---|---|
| `dashboard/dashboard-overview` | `proposal/create-proposal-discovery` (New Proposal) |
| `dashboard/dashboard-overview` | `dashboard/resume-draft-proposal` (recent proposal) |
| `dashboard/dashboard-overview` | `dashboard/start-proposal-from-preset` (most-used preset) |
| `dashboard/dashboard-overview` | `host/browse-hosts` or `host/single-host-view` (host without a proposal) |
| `host/single-host-view` | `proposal/create-proposal-discovery` (create proposal for this host — GBP step skipped, decision drawn at the top of `create-proposal-discovery`) |
| `host/single-host-view` | `proposal/browse-proposals` (access proposals made for this host) |
| `host/single-host-view` | `services/manage-host-services` (access service management) |
| `host/browse-hosts` | `host/gbp-search-import` (search for new host) |
| `host/browse-hosts` | `host/single-host-view` (select a host) |
| `host/gbp-search-import` | `host/single-host-view` (import complete, land on new host) |
| `proposal/create-proposal-discovery` | `proposal/create-proposal-customize` (Continue to customize) |
| `proposal/create-proposal-customize` | `proposal/create-proposal-generate-preview` (Continue to preview) |
| `proposal/create-proposal-generate-preview` | `proposal/regenerate-proposal-section` (regenerate one section, then returns) |
| `proposal/browse-proposals` | `proposal/revise-proposal` (open a completed proposal) |
| `proposal/browse-proposals` | `dashboard/resume-draft-proposal` or `proposal/save-and-resume-draft` (open a draft) |
| `proposal/clone-proposal` | `proposal/create-proposal-customize` (duplicate lands in creation flow, bundles/pricing pre-filled) |
| `proposal/revise-proposal` | `proposal/create-proposal-customize` and/or `proposal/create-proposal-generate-preview` (edit / re-export) |
| `proposal/save-and-resume-draft` | any `create-proposal-*` file (cross-cutting; resumes at the saved step) |
| `services/services-overview` | `services/manage-host-services` (select a host) |

## Edge-case checklist

Every diagram must cover every row that applies to it. Each file carries a `%%` comment block at the top listing which rows apply and which don't, with a one-phrase reason for each "don't":

```
%% Flow: <name>
%% Applies: 1 (empty state), 4 (form validation), 6 (delete confirm)
%% N/A: 2 (no external API call in this flow), 8 (short flow, no session-expiry risk)
```

| # | Category | Applies where |
|---|---|---|
| 1 | Empty / first-run state | any list, table, or catalog |
| 2 | External API failure | GBP lookup, Slides export |
| 3 | AI generation failure / timeout / partial | analysis, bundles, sections, regeneration |
| 4 | Input validation failure | every form |
| 5 | Duplicate / conflict | GBP import, preset & service names, concurrent edits |
| 6 | Destructive action confirm | every delete |
| 7 | Referenced-elsewhere dependency | deleting a preset, service, or host a proposal uses |
| 8 | Session expiry mid-task | long flows — creation, generation |

Row 7 is the one most likely to be missed and most likely to bite in design review — check it explicitly on every delete/edit flow.

## Validation

```bash
cd <scratchpad> && cp ~/.claude/skills/user-flow-diagrams/scripts/{validate_mermaid.mjs,package.json} . && npm install --silent
node validate_mermaid.mjs <file>
```

One `npm install` per session, reused across files. Target: `VALID` on every file, zero errors. Any surviving quality warning must be stated with a reason in the delivering agent's reply — a silently ignored warning defeats the point of running the validator.

```bash
for f in user-flows/*/*.mermaid; do node validate_mermaid.mjs "$f"; done
```
