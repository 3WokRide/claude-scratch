# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Status

This repository is currently empty — no code, no `package.json`, no framework choice has been made yet. There are no build/lint/test commands to document because nothing has been scaffolded. When code is added, update this file with real commands (build, lint, test, dev server) and the architecture that emerges — do not guess at them in the meantime.

## Product Spec

Proposal Builder is a web app that generates customized service proposals for prospective clients. It's used after a dealer and host have already reached an initial agreement, to define and detail the specific NCTV services to be delivered.

The app has 5 modules (tabs): **Dashboard**, **Hosts**, **Proposals**, **Services**, **Customization**.

### Dashboard
- Shows recently edited/created proposals for quick resume
- "New Proposal" quick-start action, front and center
- Shows most-used bundles, templates, or tones for easy reuse
- Shows hosts that don't have a proposal yet, surfacing where proposal creation is still needed

### Hosts
- Table of hosts the user currently has (or has searched) — hosts the user has an agreement with
- Filter, export, and search the table
- Search for new hosts via Google Business Profile (GBP) lookup
- Duplicate detection on GBP import, and refreshing GBP data, are backend-handled
- A host may or may not yet have a proposal, and may or may not yet have a list of currently-offered services
- **Single Host View**: in-depth detail on the host, its proposals, and its services
  - Freeform notes field for user context (e.g., things to emphasize in a proposal)
  - Access proposals made for this host (opens single proposal view)
  - Create a new proposal for this host (creation flow lives in the Proposals module)
  - Access service management for this host (opens a separate service management view)

### Proposals
- View, filter, and search all proposals
- Proposals can be saved as drafts and resumed at any step of the creation flow
- **Creation flow**:
  1. Search a business via GBP (skipped if entered from the Hosts module, since the host is already known)
  2. Show an overview including Strengths and Opportunities (areas the business could work on) — AI-generated only, there is no manual Strengths/Opportunities entry; if generation errors, the flow stops there until it succeeds
  3. On Proceed, show Problem-Solution bundles — selectable pairs used as input for the AI-generated analysis
  4. On Continue to customize: choose/input tone, pricing per selected bundle (amount + type, e.g. one-time vs. per-month), template, color scheme, and additional notes
     - Tone and color scheme can come from saved presets (Customization module) or be set manually per-proposal
     - Template is chosen from a fixed, predefined list retrieved from another database — no user-created templates, no manual fallback
     - Custom services can be added/removed on this same page
  5. Next: optional case study information
  6. Continue to preview: AI generates the whole proposal in one go from company info, selected bundles, pricing, etc. — a single call that either succeeds or fails across every section, no partial results and no per-section regeneration
  7. Preview is already the generated Google Slides deck
     - To edit the Problem-Solution bundles or the services, the user goes back to that step on the stepper
     - To edit anything else, the user opens the proposal in an editable state (the Slides deck itself)
  8. Done: proposal is saved on the host
- Revise/reopen an existing proposal to edit it — editing bundles/services routes back through the stepper (which re-runs the full generation), editing anything else happens directly on the presentation; re-exporting always creates a new presentation copy, the original is left untouched
- Delete a proposal

### Services
- List of all hosts with a summarized view of services offered/agreed per host
- Select a host to manage its services: view, create, edit, delete
- Overview of services across all hosts
- **Open question**: whether the AI pulls from the service catalog when suggesting services per Problem-Solution bundle, or generates services independently with the catalog only as a manual fallback during custom service entry — not yet decided

### Customization
Settings/library area for reusable elements, so proposals don't need to be rebuilt from scratch each time:
- **Color scheme presets** — save, name, edit palettes; mark one default
- **Tone presets** — named tone profiles (e.g., "Formal," "Friendly/Casual," "Technical")
- **Service catalog** — reusable list of standard services with descriptions and default pricing, used as input during the "add custom service" step of proposal creation
- Templates are not managed here — they're a fixed, predefined list retrieved from another database (see Proposals, step 4)

## Key relationships to keep in mind

- **Host ↔ Proposal ↔ Services** are the three central entities. A host can exist without a proposal or without services; proposals and service lists both hang off a host.
- **Customization presets feed Proposal creation** but never gate it — tone/color scheme are always also settable manually per-proposal. Template is the exception: it's picked from a fixed predefined list, with no preset and no manual fallback.
- **GBP is the source of truth for host discovery/import**, both when adding a host directly and when starting a proposal from scratch (vs. starting from an existing host).
- **AI generation is a single monolithic call**: the whole proposal generates in one go and either succeeds or fails across every section — there is no per-section generation or regeneration.
