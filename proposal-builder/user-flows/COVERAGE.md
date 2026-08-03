# Coverage Matrix

Traceability from every capability bullet in `CLAUDE.md`'s Product Spec to the flow file(s) that cover it. Built to make "comprehensive" checkable, not assumed.

| # | Spec capability (module) | Covered by | Notes |
|---|---|---|---|
| 1 | Shows recently edited/created proposals for quick resume (Dashboard) | `dashboard/dashboard-overview.mermaid`, `dashboard/resume-draft-proposal.mermaid` | |
| 2 | "New Proposal" quick-start action, front and center (Dashboard) | `dashboard/dashboard-overview.mermaid` → handoff `proposal/create-proposal-discovery.mermaid` | |
| 3 | Shows most-used bundles, templates, or tones for easy reuse (Dashboard) | `dashboard/dashboard-overview.mermaid`, `dashboard/start-proposal-from-preset.mermaid` | |
| 4 | Shows hosts that don't have a proposal yet (Dashboard) | `dashboard/dashboard-overview.mermaid` → handoff `host/browse-hosts.mermaid` | |
| 5 | Table of hosts the user currently has (or has searched) (Hosts) | `host/browse-hosts.mermaid` | |
| 6 | Filter, export, and search the host table (Hosts) | `host/browse-hosts.mermaid` | |
| 7 | Search for new hosts via GBP lookup (Hosts) | `host/gbp-search-import.mermaid` | |
| 8 | Duplicate detection on GBP import, backend-handled (Hosts) | `host/gbp-search-import.mermaid` | |
| 9 | Refreshing GBP data, backend-handled (Hosts) | *(none — backend-only, no user-facing screen)* | session decision: refresh runs server-side, not user-initiated, so no flow diagram exists for it |
| 10 | Host may or may not have a proposal or a service list yet (Hosts) | `host/single-host-view.mermaid` | data-model note, drawn as states |
| 11 | Single Host View: in-depth detail on host, proposals, services (Hosts) | `host/single-host-view.mermaid` | |
| 12 | Freeform notes field for user context (Hosts) | `host/single-host-view.mermaid` | |
| 13 | Access proposals made for this host, opens single proposal view (Hosts) | `host/single-host-view.mermaid` → handoff `proposal/browse-proposals.mermaid` | |
| 14 | Create a new proposal for this host (Hosts) | `host/single-host-view.mermaid` → handoff `proposal/create-proposal-discovery.mermaid` | |
| 15 | Access service management for this host (Hosts) | `host/single-host-view.mermaid` → handoff `services/manage-host-services.mermaid` | |
| 16 | View, filter, and search all proposals (Proposals) | `proposal/browse-proposals.mermaid` | |
| 17 | Proposals saved as drafts, resumed at any step (Proposals) | `proposal/save-and-resume-draft.mermaid`, `dashboard/resume-draft-proposal.mermaid` | |
| 18 | Creation step 1: search a business via GBP, skipped if entered from Hosts (Proposals) | `proposal/create-proposal-discovery.mermaid` | |
| 19 | Creation step 2: overview with Strengths and Opportunities (Proposals) | `proposal/create-proposal-discovery.mermaid` | |
| 20 | Creation step 3: Problem-Solution bundle selection (Proposals) | `proposal/create-proposal-discovery.mermaid` | |
| 21 | Creation step 4: choose/input tone (Proposals) | `proposal/create-proposal-customize.mermaid` | |
| 22 | Creation step 4: pricing per bundle, amount + type (Proposals) | `proposal/create-proposal-customize.mermaid` | |
| 23 | Creation step 4: template (layout) (Proposals) | `proposal/create-proposal-customize.mermaid` | |
| 24 | Creation step 4: color scheme (Proposals) | `proposal/create-proposal-customize.mermaid` | |
| 25 | Creation step 4: additional notes (Proposals) | `proposal/create-proposal-customize.mermaid` | |
| 26 | Tone/template/color scheme from presets or set manually per-proposal (Proposals) | `proposal/create-proposal-customize.mermaid`, `customization/manage-presets.mermaid` | |
| 27 | Custom services added/removed on the customize page (Proposals) | `proposal/create-proposal-customize.mermaid`, `customization/service-catalog.mermaid` | |
| 28 | Creation step 5: optional case study information (Proposals) | `proposal/create-proposal-customize.mermaid` | |
| 29 | Creation step 6: AI generates proposal from company info, bundles, pricing (Proposals) | `proposal/create-proposal-generate-preview.mermaid` | |
| 30 | Creation step 7: editable, full-screenable preview (Proposals) | `proposal/create-proposal-generate-preview.mermaid` | |
| 31 | Individual sections regenerated independently (Proposals) | `proposal/create-proposal-generate-preview.mermaid`, `proposal/regenerate-proposal-section.mermaid` | |
| 32 | Output is a Google Slides link (Proposals) | `proposal/create-proposal-generate-preview.mermaid` | |
| 33 | Creation step 8: done, proposal saved on the host (Proposals) | `proposal/create-proposal-generate-preview.mermaid` | |
| 34 | Duplicate/clone an existing proposal as a starting point (Proposals) | `proposal/clone-proposal.mermaid` | |
| 35 | Revise/reopen an existing completed proposal to edit or regenerate (Proposals) | `proposal/revise-proposal.mermaid` | |
| 36 | Delete a proposal (Proposals) | `proposal/delete-proposal.mermaid` | |
| 37 | List of all hosts with summarized service view per host (Services) | `services/services-overview.mermaid` | |
| 38 | Select a host to manage its services: view, create, edit, delete (Services) | `services/manage-host-services.mermaid` | |
| 39 | Overview of services across all hosts (Services) | `services/services-overview.mermaid` | |
| 40 | Open question: does AI pull from the service catalog per bundle? (Services) | `proposal/create-proposal-discovery.mermaid`, `customization/service-catalog.mermaid` | resolved — see "Out of scope / session decisions" |
| 41 | Color scheme presets: save, name, edit, mark one default (Customization) | `customization/manage-presets.mermaid` | |
| 42 | Tone presets: named tone profiles (Customization) | `customization/manage-presets.mermaid` | |
| 43 | Template/layout presets (Customization) | `customization/manage-presets.mermaid` | |
| 44 | Service catalog: descriptions + default pricing, feeds custom-service step (Customization) | `customization/service-catalog.mermaid`, `proposal/create-proposal-customize.mermaid` | |
| 45 | Host ↔ Proposal ↔ Services are the three central entities; host can exist without either (Key relationships) | `host/single-host-view.mermaid`, `services/services-overview.mermaid`, `proposal/browse-proposals.mermaid` | cross-cutting, drawn as states rather than one dedicated file |
| 46 | Customization presets feed proposal creation but never gate it (Key relationships) | `proposal/create-proposal-customize.mermaid`, `customization/manage-presets.mermaid` | every preset field has a manual fallback branch |
| 47 | GBP is source of truth for host discovery/import, both direct-add and proposal-from-scratch (Key relationships) | `host/gbp-search-import.mermaid`, `proposal/create-proposal-discovery.mermaid` | |
| 48 | AI generation is section-scoped; generation step designed around per-section calls (Key relationships) | `proposal/create-proposal-generate-preview.mermaid`, `proposal/regenerate-proposal-section.mermaid` | |

**48 rows.** 47 map to at least one of the 22 planned files; row 9 (GBP refresh) is deliberately backend-only with no diagram, see below.

## Out of scope / session decisions

- **`auth/` (3 flows) is not in `CLAUDE.md`.** It's a session decision, scoped to email/password only: `sign-up`, `log-in`, `password-reset`. No email verification step, no Google OAuth, no Workspace token flows. Not traceable to the spec above by design — listed here instead of in the matrix.
- **Services open question resolved**: AI pulls from the service catalog when suggesting services per Problem-Solution bundle (spec row 40). Diagrams treat this as settled, not as an open branch.
- **Known inconsistency to flag**: the spec's output is a Google Slides link and host discovery uses Google Business Profile — both need Google API credentials — but auth is scoped to email/password. Diagrams draw the Google API calls as `System:` nodes with failure branches and do not invent a connect-Google-account flow. If those credentials turn out to be per-user rather than server-side, `auth/` needs a fifth flow (connect Google account).

## Not covered deliberately

Things a reader might expect that `CLAUDE.md` doesn't mention, so no flow exists for them:

- Host deletion or archiving — the spec never describes removing a host, only adding/searching/refreshing.
- Refreshing GBP data — runs entirely server-side with no user-facing screen, so it's a backend concern rather than a user flow (formerly `host/refresh-gbp-data.mermaid`, removed).
- Team or multi-user features — no mention of roles, permissions, or shared access.
- Billing/subscription for the dealer using the app itself (distinct from proposal pricing, which is covered).
- Notifications (email/push) outside the auth verification and reset emails, which are session-decision territory, not spec territory.

## Gaps

None. All 48 extracted spec capabilities are addressed; 47 map to a flow file, and row 9 is explicitly out of scope as backend-only (see "Not covered deliberately").
