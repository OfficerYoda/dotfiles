RTK (Rust Token Killer) is active in this environment. Commands like
`git status`, `git diff`, `ls`, and `grep` are automatically proxied via `rtk`
to save context tokens. Do NOT retry or re-run commands because of an `rtk`
prefix in the command execution output.

When I say "ntfy me" (or "notify me"), notify me with a curl to
`ntfy.officeryoda.dev/me`: `curl -d "<message>" https://ntfy.officeryoda.dev/me`

## Commits

Use Conventional Commits:

```
feat(scope): add login button
fix(scope): correct typo in hero text
chore: update dependencies
docs: update README
style: format with prettier
refactor(scope): extract header component
test: add unit tests for nav
```

- `feat`: new feature
- `fix`: bug fix
- `chore`: maintenance, deps, tooling
- `docs`: documentation only
- `style`: formatting, no logic change
- `refactor`: restructure without behaviour change
- `test`: tests only

`scope` is optional; use the component/area name when it adds clarity.

When a commit closes an issue, append `Closes #n` to the commit message body.
