# Coverage Matrix

Traceability from every capability bullet in `CLAUDE.md`'s Product Spec to the flow file(s) that cover it. Built to make "comprehensive" checkable, not assumed.

| # | Spec capability (module) | Covered by | Notes |
|---|---|---|---|
| 1 | Shows recently edited/created proposals for quick resume (Dashboard) | `dashboard/dashboard-overview.mermaid`, `dashboard/resume-draft-proposal.mermaid` | |
| 2 | "New Proposal" quick-start action, front and center (Dashboard) | `dashboard/dashboard-overview.mermaid` → handoff `proposal/create-proposal-discovery.mermaid` | |
| 3 | Shows most-used bundles or tones for easy reuse (Dashboard) | `dashboard/dashboard-overview.mermaid`, `dashboard/start-proposal-from-preset.mermaid` | template dropped — templates are a predefined, non-preset list, see row 41 |
| 4 | Shows hosts that don't have a proposal yet (Dashboard) | `dashboard/dashboard-overview.mermaid` → handoff `host/browse-hosts.mermaid` | |
| 5 | Table of hosts the user currently has (or has searched) (Hosts) | `host/browse-hosts.mermaid` | |
| 6 | Filter, export, and search the host table (Hosts) | `host/browse-hosts.mermaid` | |
| 7 | Search for new hosts via GBP lookup (Hosts) | `host/gbp-search-import.mermaid` | manual Host entry is a first-class action on the search screen, not gated behind a failed GBP search — a business without a GBP listing can still be added |
| 8 | Duplicate detection on GBP import, backend-handled (Hosts) | `host/gbp-search-import.mermaid` | GBP listing ID is the uniqueness key; a match refreshes the existing Host automatically, no user-facing resolution decision |
| 9 | Refreshing GBP data, backend-handled (Hosts) | *(none — backend-only, no user-facing screen)* | session decision: refresh runs server-side, not user-initiated, so no flow diagram exists for it |
| 10 | Host may or may not have a proposal or a service list yet (Hosts) | `host/single-host-view.mermaid` | drawn as a passive empty-state placeholder; opening the view never forces creation of a Proposal or Service |
| 11 | Single Host View: in-depth detail on host, proposals, services (Hosts) | `host/single-host-view.mermaid` | |
| 12 | Freeform notes field for user context (Hosts) | `host/single-host-view.mermaid` | |
| 13 | Access proposals made for this host, opens single proposal view (Hosts) | `host/single-host-view.mermaid` → handoff `proposal/browse-proposals.mermaid` | |
| 14 | Create a new proposal for this host (Hosts) | `host/single-host-view.mermaid` → handoff `proposal/create-proposal-discovery.mermaid` | |
| 15 | Access service management for this host (Hosts) | `host/single-host-view.mermaid` → handoff `services/manage-host-services.mermaid` | |
| 16 | View, filter, and search all proposals (Proposals) | `proposal/browse-proposals.mermaid` | |
| 17 | Proposals saved as drafts, resumed at any step (Proposals) | `proposal/save-and-resume-draft.mermaid`, `dashboard/resume-draft-proposal.mermaid` | |
| 18 | Creation step 1: search a business via GBP, skipped if entered from Hosts (Proposals) | `proposal/create-proposal-discovery.mermaid` | |
| 19 | Creation step 2: overview with Strengths and Opportunities (Proposals) | `proposal/create-proposal-discovery.mermaid` | AI failure blocks proceeding, no manual Strengths/Opportunities entry exists |
| 20 | Creation step 3: Problem-Solution bundle selection (Proposals) | `proposal/create-proposal-discovery.mermaid` | |
| 21 | Creation step 4: choose/input tone (Proposals) | `proposal/create-proposal-customize.mermaid` | |
| 22 | Creation step 4: pricing per bundle, amount + type (Proposals) | `proposal/create-proposal-customize.mermaid` | |
| 23 | Creation step 4: template (Proposals) | `proposal/create-proposal-customize.mermaid` | picked from a predefined list retrieved from another database; no user-created templates, no manual fallback |
| 24 | Creation step 4: color scheme (Proposals) | `proposal/create-proposal-customize.mermaid` | |
| 25 | Creation step 4: additional notes (Proposals) | `proposal/create-proposal-customize.mermaid` | |
| 26 | Tone/color scheme from presets or set manually per-proposal (Proposals) | `proposal/create-proposal-customize.mermaid`, `customization/manage-presets.mermaid` | template excluded, see row 23 |
| 27 | Custom services added/removed on the customize page (Proposals) | `proposal/create-proposal-customize.mermaid`, `customization/service-catalog.mermaid` | |
| 28 | Creation step 5: optional case study information (Proposals) | `proposal/create-proposal-customize.mermaid` | |
| 29 | Creation step 6: AI generates proposal from company info, bundles, pricing (Proposals) | `proposal/create-proposal-generate-preview.mermaid` | single monolithic call, succeeds or fails across every Section, no partial result |
| 30 | Creation step 7: preview is already the generated Google Slides deck (Proposals) | `proposal/create-proposal-generate-preview.mermaid` | |
| 31 | Output is a Google Slides link (Proposals) | `proposal/create-proposal-generate-preview.mermaid` | |
| 32 | Creation step 8: done, proposal saved on the host (Proposals) | `proposal/create-proposal-generate-preview.mermaid` | |
| 33 | Revise/reopen an existing proposal to edit it (Proposals) | `proposal/revise-proposal.mermaid`, `proposal/edit-proposal.mermaid` | no cloning, no read-only state, no "already shared with client" decision; re-export always creates a new Slides copy |
| 34 | Delete a proposal (Proposals) | `proposal/delete-proposal.mermaid` | |
| 35 | List of all hosts with summarized service view per host (Services) | `services/services-overview.mermaid` | |
| 36 | Select a host to manage its services: view, create, edit, delete (Services) | `services/manage-host-services.mermaid` | |
| 37 | Overview of services across all hosts (Services) | `services/services-overview.mermaid` | |
| 38 | Open question: does AI pull from the service catalog per bundle? (Services) | `proposal/create-proposal-discovery.mermaid`, `customization/service-catalog.mermaid` | resolved — see "Out of scope / session decisions" |
| 39 | Color scheme presets: save, name, edit, mark one default (Customization) | `customization/manage-presets.mermaid` | |
| 40 | Tone presets: named tone profiles (Customization) | `customization/manage-presets.mermaid` | |
| 41 | Templates are predefined, not user-managed (Customization) | *(none — no user-facing management screen)* | session decision: templates are retrieved as-is from another database; users cannot create, edit, or fall back to manual selection, so no Customization flow exists for them |
| 42 | Service catalog: descriptions + default pricing, feeds custom-service step (Customization) | `customization/service-catalog.mermaid`, `proposal/create-proposal-customize.mermaid` | |
| 43 | Host ↔ Proposal ↔ Services are the three central entities; every Proposal has a Host, since Hosts are archived not deleted (Key relationships) | `host/single-host-view.mermaid`, `services/services-overview.mermaid`, `proposal/browse-proposals.mermaid` | cross-cutting, drawn as states rather than one dedicated file |
| 44 | GBP is source of truth for host discovery/import, both direct-add and proposal-from-scratch (Key relationships) | `host/gbp-search-import.mermaid`, `proposal/create-proposal-discovery.mermaid` | |
| 45 | AI generation is a single monolithic call across the whole Proposal, not per-section (Key relationships) | `proposal/create-proposal-generate-preview.mermaid` | |

**45 rows.** 44 map to at least one of the 21 planned files; row 9 (GBP refresh) and row 41 (predefined templates) are deliberately backend/database-only with no diagram, see below.

## Out of scope / session decisions

- **`auth/` (3 flows) is not in `CLAUDE.md`.** It's a session decision: `sign-up`, `log-in`, `password-reset`, authenticated via Auth0 Universal Login (redirect to Auth0-hosted screens, authorization-code exchange for tokens). Email/password connection only — no social login, no Google OAuth, no Workspace token flows. Not traceable to the spec above by design — listed here instead of in the matrix.
- **Services open question resolved**: AI pulls from the service catalog when suggesting services per Problem-Solution bundle (spec row 38). Diagrams treat this as settled, not as an open branch.
- **Cloning removed**: there is no clone/duplicate-proposal feature. A copy-with-changes need is served by Revise; a copy of the presentation itself is done outside the app.
- **Known inconsistency to flag**: the spec's output is a Google Slides link and host discovery uses Google Business Profile — both need Google API credentials — but auth is scoped to email/password. Diagrams draw the Google API calls as `System:` nodes with failure branches and do not invent a connect-Google-account flow. If those credentials turn out to be per-user rather than server-side, `auth/` needs a fifth flow (connect Google account).

## Not covered deliberately

Things a reader might expect that `CLAUDE.md` doesn't mention, so no flow exists for them:

- Host deletion — hosts are archived, never deleted; every Proposal always has a Host.
- Refreshing GBP data — runs entirely server-side with no user-facing screen, so it's a backend concern rather than a user flow (formerly `host/refresh-gbp-data.mermaid`, removed).
- Regenerating a single Proposal Section — generation is one monolithic all-or-nothing call; editing after the fact goes through `proposal/edit-proposal.mermaid` (Bundles/Services on the webapp, or the presentation directly), not a per-section regenerate.
- Team or multi-user features — no mention of roles, permissions, or shared access.
- Billing/subscription for the dealer using the app itself (distinct from proposal pricing, which is covered).
- Notifications (email/push) outside the auth verification and reset emails, which are session-decision territory, not spec territory.

## Gaps

None. All 45 extracted spec capabilities are addressed; 44 map to a flow file, and rows 9 and 41 are explicitly out of scope as backend/database-only (see "Not covered deliberately").
