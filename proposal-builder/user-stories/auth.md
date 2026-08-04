# Proposal Builder — Auth Module User Stories

Jira-ready stories for the Auth module, written from the lo-fi wireframes in Figma.

**Source**: [Proposal Builder — Auth](https://www.figma.com/design/XBQtUghyLVoBxGwQEY2xLK/Proposal-Builder?node-id=94-2) (canvas `94:2`)

**Scope**: the two visible sections — `Log In` (`102:31`, 6 frames) and `Forgot Password` (`108:33`, 8 frames). The `Sign Up` section (`102:32`, 7 frames) is hidden in the Figma file and is deliberately excluded.

**Approach**: Auth0 Universal Login on a custom domain. The login and password-reset pages are Auth0-hosted; the application owns only the entry point and the callback route. Most criteria below are therefore configuration and branding rather than page construction. See `user-flows/auth/` for the corresponding flow diagrams.

---

# [Auth] Log In

We need to implement the Log In experience for the Dashboard user, covering the app's entry into Auth0 Universal Login, the branding and page template applied to the hosted login page, and every failure state a user can encounter while attempting to sign in. This ticket covers the single user action of attempting to log in, end to end. It does not cover requesting a password reset, setting a new password, or reset-link validity handling (covered in their respective stories).

📝 Note: The login form itself is rendered by Auth0 Universal Login. Field order, alert placement, and button position inside the login card are controlled by Auth0 and are not modifiable. Only the surrounding page chrome (via Liquid page template) and the visible text (via prompt custom text) are ours to configure.

📝 Note: Auth0 brute-force protection does not auto-expire on a short timer. A blocked user regains access via the unblock link in the notification email, by changing their password, by administrator action, or after 30 days from the last failed attempt.

📝 Note: Page templates render content around the login widget only. The callback-failure banner therefore appears above the login card, not inside it alongside Auth0's native field errors.

UI/UX Figma: https://www.figma.com/design/XBQtUghyLVoBxGwQEY2xLK/Proposal-Builder?node-id=94-2

User Acceptance Criteria:

**Log In Entry**

- Selecting Log In from the application redirects the user to the Auth0 Universal Login page via the `/authorize` endpoint.
- On successful authentication, Auth0 redirects the user back to the application callback route, which establishes the session and lands the user on the Dashboard.

**Page Branding and Layout**

- All Auth0-hosted authentication pages render a top bar containing the application logo and header text, applied via the Liquid page template on the tenant's custom domain.
- The login card displays the page title Log In and the subtext Sign in to continue.
- The login card displays an Email field and a Password field, each with its own visible label.
- The login card displays a right-aligned Forgot password? link below the Password field.
- The login card displays a primary button labelled Log In.

**Validation Errors**

- Submitting the form with the Email field empty displays an alert reading Required field missing, and the form is not submitted.
- Submitting the form with the Password field empty displays an alert reading Required field missing, and the form is not submitted.

**Authentication Errors**

- Submitting credentials that do not match an existing account displays an alert reading Incorrect email or password.
- The alert does not indicate whether the email address exists in the system.

**Temporary Lockout**

- After 10 consecutive failed login attempts from the same IP address against the same user identifier, Auth0 blocks further attempts for that IP and user combination.
- While blocked, the page displays an alert reading Too many failed attempts, and the Email and Password fields are disabled.
- While blocked, the page displays a message directing the user to the unblock link sent to their email address.
- The blocked user regains access by following the unblock link in the notification email, by completing a password reset, or after 30 days from the last failed attempt.

**Callback and Token Exchange Failure**

- If the callback returns `access_denied` or the `state` parameter does not match the value the application issued, the application redirects back to `/authorize` with an `ext-` prefixed error parameter.
- If the authorization code cannot be exchanged for tokens, the application redirects back to `/authorize` with an `ext-` prefixed error parameter.
- The page template reads the `ext-` parameter and renders a banner above the login card describing the failure, and the user remains able to attempt logging in again from the same page.
- No dedicated Log In Failed page is rendered for either failure.

**Loading States**

- While the application is exchanging the authorization code for tokens, the callback route shows a loading indicator until it either establishes the session or redirects back to `/authorize`.

**Responsiveness**

- No content or interactive elements should overflow, overlap, or become inaccessible at any viewport width between 320px and 1920px.

---

# [Auth] Password Reset Request and Confirmation

We need to implement the password reset request flow for the Dashboard user, covering the Auth0-hosted page where the user submits their email address, the branded reset email, and the confirmation screen shown after submission. This ticket covers requesting the reset link only. It does not cover the login page itself, setting a new password, or handling expired and already-used reset links (covered in their respective stories).

📝 Note: Branding the password reset email requires email workflow customization, which is available on the Essentials plan and above. This story assumes that plan level.

📝 Note: The top bar and page template applied to this page are configured in the [Auth] Log In story and are not re-specified here.

UI/UX Figma: https://www.figma.com/design/XBQtUghyLVoBxGwQEY2xLK/Proposal-Builder?node-id=94-2

User Acceptance Criteria:

**Reset Request Page**

- Selecting Forgot password? on the login page navigates the user to the password reset request page.
- The page displays the title Forgot Password and the subtext Enter your email to receive a reset link.
- The page displays an Email field with a visible label.
- The page displays a primary button labelled Send Reset Link.

**Submission**

- Submitting the form with the Email field empty displays an alert reading Required field missing, and the form is not submitted.
- Submitting a valid email address triggers Auth0 to send a password reset email to that address.

**Confirmation**

- After submission the user is shown a confirmation page titled Check Your Email.
- The confirmation page displays the message If an account exists, a reset link has been sent.
- The confirmation message is shown regardless of whether an account exists for the submitted address.
- The confirmation page displays a content block confirming the email was sent.

**Reset Email**

- The password reset email uses the application's branded email template.
- The email contains a link that navigates the recipient to the Set New Password page.

**Loading States**

- While the reset request is being submitted, the page shows a loading indicator and the Send Reset Link button cannot be submitted a second time.

**Responsiveness**

- No content or interactive elements should overflow, overlap, or become inaccessible at any viewport width between 320px and 1920px.

---

# [Auth] Set New Password and Confirmation

We need to implement the password reset completion flow for the Dashboard user, covering the Auth0-hosted page where the user chooses a new password, the password strength enforcement applied to it, and the success confirmation. This ticket covers setting the new password and confirming success. It does not cover requesting the reset link, or handling expired and already-used reset links (covered in their respective stories).

📝 Note: Password history is disabled by decision, so Auth0 does not detect or block reuse of a previous password. The `Reset Password — Same as Old Password` frame in the wireframe is therefore out of scope and not implemented.

📝 Note: The tenant password strength policy is set to Good. The minimum length stated below is Auth0's default of 8 characters for that policy.

📝 Note: The top bar and page template applied to this page are configured in the [Auth] Log In story and are not re-specified here.

UI/UX Figma: https://www.figma.com/design/XBQtUghyLVoBxGwQEY2xLK/Proposal-Builder?node-id=94-2

User Acceptance Criteria:

**Set New Password Page**

- Following a valid reset link navigates the user to a page titled Set New Password with the subtext Choose a new password.
- The page displays a New Password field and a Confirm Password field, each with its own visible label.
- The page displays a message stating the password requirements: at least 8 characters, including at least three of the following — a lowercase letter, an uppercase letter, a number, or a special character (`!@#$%^&*`).
- The page displays a primary button labelled Update Password.

**Password Validation**

- Submitting a password that does not satisfy the stated requirements displays an alert reading Password fails strength requirements, and the password is not updated.
- When the strength alert is displayed, the password requirements message remains visible on the page.
- Submitting a Confirm Password value that does not match the New Password value displays an alert, and the password is not updated.

**Confirmation**

- On a successful update the user is shown a page titled Password Updated.
- The confirmation page displays a content block confirming success and the message Your password has been updated.
- The confirmation page displays a primary button labelled Back to Log In.
- Selecting Back to Log In navigates the user to the login page.

**Loading States**

- While the password update is being submitted, the page shows a loading indicator and the Update Password button cannot be submitted a second time.

**Responsiveness**

- No content or interactive elements should overflow, overlap, or become inaccessible at any viewport width between 320px and 1920px.

---

# [Auth] Reset Password Link Invalid States

We need to implement the invalid reset link states for the Dashboard user, covering the two cases where a password reset link can no longer be used: the link has expired, and the link has already been consumed. This ticket covers those two states and the route back into the reset flow. It does not cover requesting the reset link, setting a new password, or the login page (covered in their respective stories).

📝 Note: The top bar and page template applied to these pages are configured in the [Auth] Log In story and are not re-specified here.

UI/UX Figma: https://www.figma.com/design/XBQtUghyLVoBxGwQEY2xLK/Proposal-Builder?node-id=94-2

User Acceptance Criteria:

**Link Expired**

- Following a reset link whose validity period has elapsed navigates the user to a page titled Link Expired.
- The page displays an alert reading This reset link has expired.
- The page displays the message Request a new reset link.
- The page displays a primary button labelled Request New Link.

**Link Already Used**

- Following a reset link that has already been used to complete a password update navigates the user to a page titled Link Already Used.
- The page displays an alert reading This reset link has already been used.
- The page displays the message Request a new reset link.
- The page displays a primary button labelled Request New Link.

**Returning to the Reset Flow**

- Selecting Request New Link from either state navigates the user to the password reset request page.
- Neither state allows the user to enter or submit a new password.

**Responsiveness**

- No content or interactive elements should overflow, overlap, or become inaccessible at any viewport width between 320px and 1920px.

---

## Coverage

All 14 visible frames map to a story. The hidden `Sign Up` section (`102:32`, 7 frames) was excluded as instructed.

| Frames | Story |
|---|---|
| Log In, Required Field Missing, Incorrect Email or Password, Temporary Lockout, Callback Failed, Token Exchange Failed | [Auth] Log In |
| Forgot Password, Check Your Email | [Auth] Password Reset Request and Confirmation |
| Set New Password, Password Updated, Weak Password | [Auth] Set New Password and Confirmation |
| Link Expired, Link Already Used | [Auth] Reset Password Link Invalid States |

Empty-state criteria are omitted throughout — none of these screens render a collection.

### Decisions applied

| Decision | Effect |
|---|---|
| Universal Login over embedded form | Login and reset pages are Auth0-hosted; stories are configuration, not page construction |
| Post-login destination is the Dashboard | [Auth] Log In → Log In Entry |
| Password strength policy: Good | [Auth] Set New Password → requirements copy |
| Password history: disabled | `Same as Old Password` frame dropped from scope |
| Brute-force threshold: Auth0 default (10) | [Auth] Log In → Temporary Lockout |
| Custom domain: available | Page template enabled, which the top bar and the callback banner both depend on |
| Callback failure is a banner, not a screen | `Callback Failed` and `Token Exchange Failed` frames superseded by an `ext-` parameter banner |
| Reset email: branded | [Auth] Password Reset Request → Reset Email (requires Essentials) |
| `Open Reset Link` button dropped | Not implementable; the reset link arrives by email |

## Open items

1. **`Reset Password — Same as Old Password` is unimplementable** as specced. Enabling password history at size 1 would restore it; otherwise the frame should be deleted from the Figma file so it doesn't read as approved scope.
2. **Lockout copy needs rewriting.** "Temporarily locked out, try again later" contradicts Auth0's behavior. The criteria above assume the message points to the unblock email — confirm, and get the frame's copy updated to match.
3. **Confirm "Good" was the password strength level**, not just agreement with the question. The requirements copy in [Auth] Set New Password is written from Auth0's Good policy and changes materially if Excellent was intended.
4. **Confirm the Essentials plan** for branded reset emails.
5. Minor: the `Required Field Missing` and `Incorrect Email or Password` frames omit the subtext and Forgot password? link. Universal Login keeps both visible in those states. Criteria are written to Auth0's behavior, treating the omission as lo-fi shorthand — flag if it was intentional.

## References

- [Auth0 pricing](https://auth0.com/pricing)
- [Hosted Login vs. Embedded Login](https://auth0.com/docs/authenticate/login/universal-vs-embedded-login)
- [Customize page templates](https://auth0.com/docs/customize/login-pages/universal-login/customize-templates)
- [Password strength levels](https://auth0.com/docs/authenticate/database-connections/password-strength)
- [Brute-force protection](https://auth0.com/docs/secure/attack-protection/brute-force-protection)
- [Render a custom message on Universal Login](https://support.auth0.com/center/s/article/Render-Custom-message-on-the-Universal-Login-screen)
