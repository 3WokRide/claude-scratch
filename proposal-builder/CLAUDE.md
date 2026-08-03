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
  2. Show an overview including Strengths and Opportunities (areas the business could work on)
  3. On Proceed, show Problem-Solution bundles — selectable pairs used as input for the AI-generated analysis
  4. On Continue to customize: choose/input tone, pricing per selected bundle (amount + type, e.g. one-time vs. per-month), template (layout), color scheme, and additional notes
     - Tone, template, and color scheme can come from saved presets (Customization module) or be set manually per-proposal
     - Custom services can be added/removed on this same page
  5. Next: optional case study information
  6. Continue to preview: AI generates the proposal from company info, selected bundles, pricing, etc.
  7. Editable, full-screenable preview of the generated proposal
     - Individual sections (e.g., Strengths/Opportunities, pricing) can be regenerated independently, without rerunning the full generation
     - Output is a Google Slides link
  8. Done: proposal is saved on the host
- Duplicate/clone an existing proposal as a starting point for a new one
- Revise/reopen an existing (completed) proposal to edit or regenerate it
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
- **Template/layout presets** — preferred layout combinations
- **Service catalog** — reusable list of standard services with descriptions and default pricing, used as input during the "add custom service" step of proposal creation

## Key relationships to keep in mind

- **Host ↔ Proposal ↔ Services** are the three central entities. A host can exist without a proposal or without services; proposals and service lists both hang off a host.
- **Customization presets feed Proposal creation** but never gate it — tone/template/color scheme are always also settable manually per-proposal.
- **GBP is the source of truth for host discovery/import**, both when adding a host directly and when starting a proposal from scratch (vs. starting from an existing host).
- **AI generation is section-scoped**: proposal sections can be regenerated independently, so the generation step should be designed around per-section calls, not a single monolithic generation.
