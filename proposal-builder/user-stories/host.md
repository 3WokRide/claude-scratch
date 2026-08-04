# Proposal Builder — Host Module User Stories

Jira-ready stories for the Host module, written from the lo-fi wireframes in Figma.

**Source**: [Proposal Builder — Host](https://www.figma.com/design/XBQtUghyLVoBxGwQEY2xLK/Proposal-Builder?node-id=108-34) (canvas `108:34`)

**Scope**: the three sections on the canvas — `Browse Hosts` (`120:204`, 7 frames), `GBP Search & Import` (`120:205`, 8 frames), and `Single Host View` (`120:206`, 9 frames). Of the 24 frames, 6 are distinct screens; the other 18 are states of those screens and are folded into the story that owns the screen rather than given stories of their own.

**Related**: see `user-flows/host/` for the corresponding flow diagrams.

---

# [Host] Host Table View

We need to implement the Hosts page for the Dashboard user, listing every host the user has an agreement with and giving them the entry point into each host's detail view. This ticket covers the page header, the host table, pagination, and the page's loading, empty, and load-failure states. It does not cover the toolbar search box or the Has Proposal and Has Services filters, exporting the table, searching Google Business Profile for a new host, adding a host manually, or the Single Host View itself (covered in their respective stories). The global top bar — logo, module navigation, and account control — is shared application chrome and is not covered by any story in this module.

📝 Note: The table page size of 10 rows is an agreed default chosen to match the GBP results list. It was not specified in the wireframe.

UI/UX Figma: https://www.figma.com/design/XBQtUghyLVoBxGwQEY2xLK/Proposal-Builder?node-id=108-34

User Acceptance Criteria:

**Data Fetching**

- Whenever the user opens or revisits the Hosts page, the page fetches the latest host data.

**Page Header**

- The page shows the breadcrumb Hosts.
- The page shows the title Hosts and the subtext Hosts you have an agreement with.
- The page header shows a secondary button labelled Export and a primary button labelled Search for New Host.
- Selecting Search for New Host navigates the user to the Search Google Business Profile page.

**Host Table**

- The page shows a table listing the user's hosts with the following columns: Host, Location, Services, and Proposals.
- Host displays the host's business name.
- Location displays the host's city and state in the format City, State (e.g., Austin, TX).
- Services displays the number of services recorded for that host as a plain count (e.g., 4).
- Proposals displays the number of proposals created for that host as a plain count (e.g., 2).
- Selecting a table row navigates the user to the Single Host View for that host.

**Pagination**

- The table displays a maximum of 10 host rows per page.
- The page shows a result count displaying the total number of hosts in the result set (e.g., 24 hosts).
- The page shows pagination controls consisting of Prev, the available page numbers, and Next.
- Selecting a page number displays that page of host rows.
- Selecting Next displays the following page of host rows and selecting Prev displays the preceding page.

**Empty States**

- If the user has no hosts on record, the page shows a content block with the message No hosts on record yet and the subtext Search Google Business Profile to add your first host.
- The content block shows a primary button labelled Search Google Business Profile, which navigates the user to the Search Google Business Profile page.
- In the no-hosts state the table, the pagination controls, the result count, the Export button, and the Search for New Host button are not shown.

**Load Failure**

- If the host data fails to load, the page shows an alert reading Host table failed to load.
- The page shows a content block with the message Unable to load the host table and the subtext The list could not be retrieved. Try again.
- The content block shows a primary button labelled Retry, which re-fetches the host data.
- In the load-failure state the table, the pagination controls, the result count, the Export button, and the Search for New Host button are not shown.

**Loading States**

- While the host data is being fetched, the table area shows a loading indicator.

**Responsiveness**

- No content or interactive elements should overflow, overlap, or become inaccessible at any viewport width between 320px and 1920px.

---

# [Host] Host Table Search and Filters

We need to implement the search and filter toolbar on the Hosts page for the Dashboard user, letting them narrow the host table down to the records they care about. This ticket covers the search field, both filters, how the three combine, and the no-matching-results state. It does not cover the base host table, its columns, pagination, or the export action (covered in their respective stories).

📝 Note: The wireframe labels the second toolbar control Status. There is no host status in the product, so that control is implemented as a Has Services filter. The Status labels in the `Hosts Table` and `Hosts Table — No Matching Results` frames are superseded by this decision.

UI/UX Figma: https://www.figma.com/design/XBQtUghyLVoBxGwQEY2xLK/Proposal-Builder?node-id=108-34

User Acceptance Criteria:

**Toolbar**

- The Hosts page shows a toolbar containing a search field with the placeholder Search hosts, a Has Proposal filter, and a Has Services filter.
- Both filters are dropdowns.

**Smart Search**

- The search field filters the host table after each keystroke.
- The search term is applied only once at least 3 characters have been entered; below 3 characters the table shows the unfiltered result set.
- The search matches the entered term against the host's name and the host's location.

**Filter By**

- The Has Proposal filter offers the options Yes and No.
- The Has Services filter offers the options Yes and No.
- Selecting a filter option immediately updates the table to reflect that filter without requiring an additional action.
- Has Proposal set to Yes limits the table to hosts with at least one proposal; set to No it limits the table to hosts with no proposals.
- Has Services set to Yes limits the table to hosts with at least one service; set to No it limits the table to hosts with no services.

**Combining Search and Filters**

- The search term, the Has Proposal filter, and the Has Services filter combine — a host is shown only when it satisfies every active criterion.
- The result count and the pagination controls reflect the filtered result set, not the full host list.

**No Matching Results**

- If no hosts match the active search term or filters, the page shows a content block with the message No hosts match this search or filter and the subtext Clear the search and filters to see all hosts.
- The content block shows a secondary button labelled Clear Search & Filters.
- Selecting Clear Search & Filters empties the search field, clears both filters, and returns the table to the unfiltered result set.
- In the no-matching-results state the table and the pagination controls are not shown, and the toolbar retains the active search term and filter selections.

**Responsiveness**

- No content or interactive elements should overflow, overlap, or become inaccessible at any viewport width between 320px and 1920px.

---

# [Host] Host Table Export

We need to implement the host table export for the Dashboard user, letting them download the hosts they are currently looking at as a spreadsheet. This ticket covers the Export action, the file it produces, and the success and failure states shown on the Hosts page. It does not cover the host table itself, the search field and filters, or anything in the GBP search and import flow (covered in their respective stories).

📝 Note: The `Hosts Table — Large Export in Background` frame is out of scope by decision. Exports always run in the foreground with a loading state, and there is no background-export path, no background notification, and no Open Download button.

📝 Note: The exported file is assumed to contain the same four columns shown in the table. The wireframe does not specify the file's contents.

UI/UX Figma: https://www.figma.com/design/XBQtUghyLVoBxGwQEY2xLK/Proposal-Builder?node-id=108-34

User Acceptance Criteria:

**Export**

- The Hosts page header shows a secondary button labelled Export.
- Selecting Export produces an XLSX file and downloads it to the user's device.
- The exported file contains every host in the current search and filter result set, across all pages — not only the rows shown on the displayed page.
- The exported file contains the Host, Location, Services, and Proposals columns.

**Export Complete**

- On a successful export, the page shows an alert reading Export complete — file downloaded containing a secondary button labelled Back to Hosts.
- The page shows a content block with the message Your export has been downloaded and the subtext The host table was exported as a file.
- The host table remains visible below the alert and content block.
- Selecting Back to Hosts dismisses the alert and the content block and returns the page to the host table.

**Export Failure**

- If the export fails or times out, the page shows an alert reading Export failed or timed out containing a primary button labelled Retry Export.
- Selecting Retry Export re-runs the export against the same search and filter result set.
- The host table remains visible below the alert.

**Loading States**

- While the export is running, the page shows a loading indicator and the Export button cannot be selected a second time.

**Responsiveness**

- No content or interactive elements should overflow, overlap, or become inaccessible at any viewport width between 320px and 1920px.

---

# [Host] Google Business Profile Search

We need to implement the Google Business Profile search for the Dashboard user, letting them look up a business by name or address and see the matching GBP listings before choosing one to add as a host. This ticket covers the search page, submitting a query, the results list and its pagination, and the no-results and service-unavailable states. It does not cover importing a selected result, duplicate handling, or adding a host manually (covered in their respective stories).

📝 Note: Pagination controls are not drawn on the `GBP Results List` frame. The 10-per-page limit and the controls that go with it are an agreed addition.

📝 Note: The behavior of Refine Search is not depicted. It is specified below as returning the user to the search field with the submitted query retained for editing.

UI/UX Figma: https://www.figma.com/design/XBQtUghyLVoBxGwQEY2xLK/Proposal-Builder?node-id=108-34

User Acceptance Criteria:

**Search Page**

- The page shows the breadcrumb Hosts / Search Google Business Profile.
- The page shows the title Search Google Business Profile and the subtext Find a business to add as a host.
- The page header shows a secondary button labelled Add Host Manually, which navigates the user to the Add Host Manually page.
- The page shows a search field with the placeholder Business name or address and a primary button labelled Search.
- Before any query has been submitted, the page shows a content block with the message Search to see results and the subtext Results from Google Business Profile appear here.

**Results List**

- Submitting a query that returns matches navigates the user to the results view, which shows the breadcrumb Hosts / Search Google Business Profile / Results.
- The results view shows the title GBP Results and the subtext Select a business to import as a host.
- The results view retains the search field containing the submitted query and the Search button, so a new query can be submitted without leaving the results view.
- The results view shows a result count displaying the total number of matching listings (e.g., 34 results).
- Each result row shows the business name and a meta line containing the listing's address, category, and rating, separated by a middot (e.g., 500 W 2nd St, Austin, TX · Restaurant · 4.5).
- Each result row shows a chevron indicating the row is selectable.
- A result whose GBP listing is missing one or more fields shows a tag reading Incomplete listing, and each missing value is rendered in the meta line as unavailable (e.g., Address unavailable · Category unavailable).
- The results list displays a maximum of 10 results per page, with pagination controls to move between pages.

**No Results**

- If the query returns no matches, the page shows an alert reading No results for this query.
- The page shows a content block with the message No Google Business Profile matches this search and the subtext Refine the search terms or add the host manually.
- The content block shows a primary button labelled Refine Search and a secondary button labelled Add Host Manually.
- Selecting Refine Search returns the user to the search field with the submitted query retained for editing.
- Selecting Add Host Manually navigates the user to the Add Host Manually page.
- The search field retaining the submitted query remains visible in the no-results state.

**Service Unavailable**

- If the Google Business Profile lookup cannot be reached or is rate-limited, the page shows an alert reading Google Business Profile is unavailable or rate-limited.
- The page shows a content block with the message Could not reach Google Business Profile and the subtext The lookup service is unavailable or rate-limited. Try again.
- The content block shows a primary button labelled Retry, which re-submits the same query.
- The search field retaining the submitted query remains visible in the unavailable state.

**Loading States**

- While the Google Business Profile lookup is running, the page shows a loading indicator and the Search button cannot be submitted a second time.

**Responsiveness**

- No content or interactive elements should overflow, overlap, or become inaccessible at any viewport width between 320px and 1920px.

---

# [Host] Import Host from Google Business Profile

We need to implement importing a Google Business Profile listing as a host for the Dashboard user, covering what happens once they pick a business from the results list. This ticket covers the import itself, the case where the business is already on record, importing a listing with missing fields, and import failure. It does not cover the search page or the results list rendering, adding a host manually, or the Single Host View the user lands on afterwards (covered in their respective stories).

📝 Note: Duplicate detection keys on the GBP listing ID and is handled by the backend. Refreshing an existing host's data from GBP is also backend-handled.

UI/UX Figma: https://www.figma.com/design/XBQtUghyLVoBxGwQEY2xLK/Proposal-Builder?node-id=108-34

User Acceptance Criteria:

**Importing a Result**

- Selecting a result row imports that listing as a host and navigates the user to the Single Host View for it.
- The imported host record is populated from the fields the GBP listing returned.

**Business Already on Record**

- If a host already exists for the selected GBP listing, no new host record is created; the existing record is refreshed from Google Business Profile and the user is navigated to its Single Host View.
- In that case the user is shown a message stating that the business was already on record and its details have been refreshed, rather than newly imported.

**Incomplete Listing**

- Selecting a result tagged Incomplete listing shows an alert reading This listing has incomplete data.
- The page shows a content block with the message Some fields are missing from this GBP listing, the subtext You can import the host using only the available fields, and a primary button labelled Proceed with Available Fields.
- The import does not proceed until Proceed with Available Fields is selected.
- Selecting Proceed with Available Fields imports the host using the fields Google Business Profile returned and leaves the missing fields empty on the host record.
- The results list remains visible while the alert and content block are shown, so a different listing can be selected instead.

**Import Failure**

- If saving the imported host fails, the page shows an alert reading Import save failed containing a primary button labelled Retry Import.
- Selecting Retry Import re-attempts the import for the same listing.
- The results list remains visible below the alert, so a different listing can be selected instead.

**Loading States**

- While the import is being saved, the page shows a loading indicator and the selected result row cannot be selected a second time.

**Responsiveness**

- No content or interactive elements should overflow, overlap, or become inaccessible at any viewport width between 320px and 1920px.

---

# [Host] Add Host Manually

We need to implement manual host entry for the Dashboard user, so a host can still be added when no Google Business Profile listing exists for the business. This ticket covers the entry form, its validation, saving, and save failure. It does not cover the Google Business Profile search, importing a GBP listing, or the Single Host View the user lands on afterwards (covered in their respective stories).

UI/UX Figma: https://www.figma.com/design/XBQtUghyLVoBxGwQEY2xLK/Proposal-Builder?node-id=108-34

User Acceptance Criteria:

**Manual Entry Page**

- Selecting Add Host Manually from either the Search Google Business Profile page or the GBP Results view navigates the user to the Add Host Manually page.
- The page shows the breadcrumb Hosts / Add Host Manually.
- The page shows the title Add Host Manually and the subtext Enter host details when no GBP listing is available.
- The page shows a Host Details form containing four fields, each with its own visible label: Business Name, Address, Category, and Contact.
- The page shows a primary button labelled Save Host.

**Validation**

- All four fields are required. Submitting the form with any field empty displays a validation message on each empty field and the host is not saved.
- Contact accepts either a valid email address (e.g., owner@example.com) or a valid US phone number (e.g., (512) 555-0142).
- Submitting a Contact value that is neither a valid email address nor a valid US phone number displays a validation message on the field and the host is not saved.

**Saving**

- Submitting a form that passes validation saves the host and navigates the user to the Single Host View for the new host.

**Save Failure**

- If the save fails, the page shows an alert reading Could not save this host.
- The form retains every value the user entered.
- In the save-failure state the form's primary button reads Retry Save, which re-attempts the save using the entered values.

**Loading States**

- While the host is being saved, the page shows a loading indicator and the save cannot be submitted a second time.

**Responsiveness**

- No content or interactive elements should overflow, overlap, or become inaccessible at any viewport width between 320px and 1920px.

---

# [Host] Single Host View

We need to implement the Single Host View for the Dashboard user, giving them the detail on one host along with its proposals and its services in one place. This ticket covers the page header, the read-only notes display, the Proposals and Services cards, their empty states, and the page's loading and load-failure states. It does not cover editing the notes, creating or viewing proposals, managing services, or the host table the user arrives from (covered in their respective stories and in the Proposals and Services modules).

📝 Note: The View All link on the Proposals card is removed by decision. Both cards list every record for the host, so there is no truncated list to expand. The Manage Services link on the Services card is retained, since it opens service management rather than expanding the list.

📝 Note: The hidden `Single Host View — Host Deleted Elsewhere` frame is out of scope. Hidden frames were excluded from the Auth stories on the same basis.

UI/UX Figma: https://www.figma.com/design/XBQtUghyLVoBxGwQEY2xLK/Proposal-Builder?node-id=108-34

User Acceptance Criteria:

**Data Fetching**

- Whenever the user opens or revisits a Single Host View, the page fetches the latest host, proposal, and service data for that host.

**Page Header**

- The page shows the breadcrumb Hosts / <host name>.
- The page shows the host's business name as the page title.
- The page shows a subtext containing the host's address, category, and rating, separated by a middot (e.g., 500 W 2nd St, Austin, TX · Restaurant · 4.5).
- The page header shows a primary button labelled New Proposal for this Host.
- Selecting New Proposal for this Host starts proposal creation for this host with the Google Business Profile search step skipped.

**Notes**

- The page shows a Notes block containing the host's saved freeform notes.
- The Notes block header shows a link labelled Edit Notes.
- If the host has no saved notes, the Notes block shows a clear empty state message.

**Proposals Card**

- The page shows a Proposals card listing every proposal created for this host, with no truncation and no expand action.
- Each proposal row shows the proposal's name and a meta line showing the proposal's status and the date it was last edited, separated by a middot.
- Selecting a proposal row opens that proposal.

**Services Card**

- The page shows a Services card listing every service recorded for this host, with no truncation and no expand action.
- Each service row shows the service's name and a meta line showing the service's price and frequency, separated by a middot.
- The Services card header shows a link labelled Manage Services, which opens service management for this host.

**Empty States**

- If the host has no proposals, the Proposals card shows a content block with the message No proposals for this host yet, the subtext Create the first proposal to get started, and a primary button labelled Create First Proposal.
- Selecting Create First Proposal starts proposal creation for this host with the Google Business Profile search step skipped.
- If the host has no services, the Services card shows a content block with the message No services recorded for this host, the subtext Add the first service to get started, and a primary button labelled Add First Service.
- Selecting Add First Service opens service management for this host.
- The two cards' empty states are independent — one card can show its empty state while the other lists records.

**Load Failure**

- If the host fails to load, the page shows the title Host with the subtext Host detail and an alert reading This host failed to load.
- The page shows a content block with the message Unable to load this host and the subtext The host record could not be retrieved. Try again.
- The content block shows a primary button labelled Retry, which re-fetches the host.
- In the load-failure state the New Proposal for this Host button, the Notes block, and both cards are not shown.

**Loading States**

- While the host data is being fetched, the page shows a loading indicator.

**Responsiveness**

- No content or interactive elements should overflow, overlap, or become inaccessible at any viewport width between 320px and 1920px.

---

# [Host] Host Notes Editing

We need to implement editing of a host's freeform notes for the Dashboard user, so they can record the context they want reflected when a proposal is built for that host. This ticket covers the notes form, its character count, saving and discarding, the length validation error, and the prompt shown when the user navigates away with unsaved changes. It does not cover the read-only notes display, the page header, or the Proposals and Services cards (covered in [Host] Single Host View).

📝 Note: The notes field has a maximum length of 2,000 characters. The wireframe does not state a limit; this is an agreed default and the number appears in both the character count and the validation alert.

📝 Note: The `Single Host View — Notes Save Conflict` frame is out of scope by decision. Conflict detection on save and the Review and Merge action are removed, so there is no conflicting-version display and no merge step.

UI/UX Figma: https://www.figma.com/design/XBQtUghyLVoBxGwQEY2xLK/Proposal-Builder?node-id=108-34

User Acceptance Criteria:

**Entering Edit Mode**

- Selecting Edit Notes on the Single Host View replaces the read-only Notes block with an editable notes form.
- The form header reads Notes — Editing and shows a link labelled Back to Host.
- The form shows a multi-line notes input containing the host's currently saved notes.
- The form shows a character count displaying the number of characters entered against the 2,000 character maximum (e.g., 412 / 2000).
- The character count updates after each keystroke.
- The form shows a secondary button labelled Discard Changes and a primary button labelled Save Notes.
- While the notes form is open, the New Proposal for this Host button is not shown in the page header.
- The Proposals card and the Services card remain visible and unchanged while the notes form is open.

**Saving**

- Selecting Save Notes saves the entered text and returns the block to its read-only Notes display showing the newly saved text.

**Discarding**

- Selecting Discard Changes discards the entered text and returns the block to its read-only Notes display showing the previously saved notes.
- Selecting Back to Host when the entered text matches the saved notes returns the block to its read-only Notes display.

**Validation**

- Submitting notes longer than 2,000 characters displays an alert reading Notes exceed the maximum length and the notes are not saved.
- While the alert is shown, the notes form remains open with the entered text intact and the character count still visible.
- In the validation-error state the form's primary button reads Edit and Resave, which re-attempts the save using the current text.

**Unsaved Changes Prompt**

- Attempting to navigate away from the Single Host View while the entered text differs from the saved notes displays a modal over a scrim, titled Unsaved notes with the message Save or discard your changes before leaving.
- Selecting Back to Host while the entered text differs from the saved notes displays the same modal.
- The modal shows a secondary button labelled Discard and a primary button labelled Save.
- Selecting Save saves the entered notes and then continues to the destination the user was navigating to.
- Selecting Discard discards the entered notes and then continues to the destination the user was navigating to.
- The modal is not shown when the entered text matches the saved notes.

**Loading States**

- While the notes are being saved, the form shows a loading indicator and the save cannot be submitted a second time.

**Responsiveness**

- No content or interactive elements should overflow, overlap, or become inaccessible at any viewport width between 320px and 1920px.

---

## Coverage

All 24 frames map to a story. Six frames are the distinct screens; the remaining 18 are states of those screens and produced criteria groups rather than stories of their own.

| Frames | Story |
|---|---|
| Hosts Table, Hosts Table — No Hosts Yet, Hosts Table — Failed to Load | [Host] Host Table View |
| Hosts Table — No Matching Results | [Host] Host Table Search and Filters |
| Hosts Table — Export Downloaded, Hosts Table — Export Failed, Hosts Table — Large Export in Background *(dropped)* | [Host] Host Table Export |
| GBP Search, GBP Search — No Results, GBP Search — GBP Unavailable, GBP Results List | [Host] Google Business Profile Search |
| GBP Results List — Incomplete Listing Data, GBP Results List — Import Failed | [Host] Import Host from Google Business Profile |
| Manual Host Entry, Manual Host Entry — Save Failed | [Host] Add Host Manually |
| Single Host View, Single Host View — Failed to Load, Single Host View — No Proposals Yet, Single Host View — No Services Yet, Single Host View — Host Deleted Elsewhere *(hidden, dropped)* | [Host] Single Host View |
| Single Host View — Notes Editing, Single Host View — Notes Validation Error, Single Host View — Unsaved Notes Prompt, Single Host View — Notes Save Conflict *(dropped)* | [Host] Host Notes Editing |

The global top bar — logo, module navigation, and account control — appears on every frame and is shared application chrome, excluded in [Host] Host Table View and not re-specified elsewhere.

### Decisions applied

| Decision | Effect |
|---|---|
| Services and Proposals columns are plain counts | [Host] Host Table View → Host Table |
| Location shown as City, State | [Host] Host Table View → Host Table |
| Host table paginated, 10 rows per page | [Host] Host Table View → Pagination |
| Search matches host name and location, filters per keystroke after 3 characters | [Host] Host Table Search and Filters → Smart Search |
| Filters are Has Proposal (Yes/No) and Has Services (Yes/No) | Wireframe's Status filter superseded |
| Search and both filters combine | [Host] Host Table Search and Filters → Combining Search and Filters |
| Export format is XLSX | [Host] Host Table Export → Export |
| Export covers the current result set across all pages | [Host] Host Table Export → Export |
| Background export removed, replaced by a loading state | `Large Export in Background` frame dropped |
| GBP results paginated, 10 per page | [Host] Google Business Profile Search → Results List |
| Existing host is refreshed and the user is told | [Host] Import Host from GBP → Business Already on Record |
| Any missing field makes a listing incomplete | [Host] Google Business Profile Search → Results List |
| All four manual-entry fields required; Contact is email or US phone | [Host] Add Host Manually → Validation |
| Cards list every record, no View All | `[Link — View All]` dropped from the Proposals card |
| Notes limit of 2,000 characters | [Host] Host Notes Editing → 📝 Note, character count, validation |
| Notes save conflict removed | `Notes Save Conflict` frame dropped, Review and Merge removed |
| Unsaved-notes modal continues to the intended destination | [Host] Host Notes Editing → Unsaved Changes Prompt |

## Open items

1. **Host table page size was never specified.** The stories use 10 rows per page to match the GBP results list. Confirm, or give a number.
2. **Three frames are now unimplementable as drawn** and should be deleted from the Figma file so they don't read as approved scope: `Hosts Table — Large Export in Background`, `Single Host View — Notes Save Conflict`, and the hidden `Single Host View — Host Deleted Elsewhere`.
3. **`Single Host View — Host Deleted Elsewhere` was not ruled on.** It is hidden in Figma but the `single-host-view` flow diagram includes the edge case. The stories exclude it, following the Auth precedent on hidden frames — say if it should be brought back in, and if so whether the flow diagram or the frame is authoritative.
4. **The Proposals card's "Last edited" timestamp has no confirmed format.** The criterion says the date is shown without stating a format. Supply one (e.g., `MM/DD/YY hh:mm A`) before build.
5. **Export file contents are assumed** to be the table's four columns. Confirm, or name the columns the XLSX should carry.
6. **`Refine Search` behavior is not depicted.** Specified as returning the user to the search field with the query retained. Confirm.
7. **The `Notes Validation Error` frame relabels the primary button** from Save Notes to Edit and Resave. The criteria follow the frame, but flag it if the label change was lo-fi shorthand rather than intent.
8. **The Status filter label** in `Hosts Table` and `Hosts Table — No Matching Results` should be updated to Has Services in the Figma file.
