---
name: md2pdf
description: Convert a Markdown file to a clean, printable A4 PDF using pandoc + typst. Use when the user says "/md2pdf", asks to turn a .md into a PDF, wants a printable/print-ready PDF of a document, or wants a markdown note rendered for printing. Not for .docx (use the docx skill) or slide decks (use pptx).
---

Turn a Markdown file into a polished A4 PDF for printing. The toolchain is
`pandoc --pdf-engine=typst` with a bundled typst template — no LaTeX, no Chrome,
no Python. Both `pandoc` and `typst` are installed via home-manager and always
on PATH.

## What the template produces

`print-a4.typ` (in this skill directory) styles output as:

- A4, 2 cm margins, Norwegian hyphenation (`lang: "nb"`).
- Running header (from page 2) + footer with **"Side X av Y"**.
- Libertinus Serif body, Noto Sans headings; H2 gets an underline rule.
- Markdown blockquotes (`> …`) render as **amber callout boxes** — good for
  warnings/notes.
- Tables with a tinted, bold header row and thin rules.
- Blue links, monospace inline code with a subtle background.

The document's first `#` heading becomes the on-page title. Pass `-M title="…"`
for the smaller running header/footer text (keep it short).

## Procedure

1. Resolve the skill directory (where this file lives) so the template path is
   absolute. Confirm the input `.md` path and decide the output path
   (default: same name, `.pdf`, same directory).

2. Build:

   ```sh
   pandoc INPUT.md -o OUTPUT.pdf \
     --pdf-engine=typst \
     --template="<skill-dir>/print-a4.typ" \
     -M title="Short running-header title"
   ```

3. Verify it built and looks right:

   ```sh
   pdfinfo OUTPUT.pdf | grep -iE 'pages|page size'   # expect A4
   pdftoppm -png -r 110 OUTPUT.pdf /tmp/mdpdf        # then Read /tmp/mdpdf-1.png
   ```

   Read at least the first rendered page image to confirm tables, callouts, and
   Norwegian characters (æøå) render correctly. Report page count to the user.

4. Deliver the PDF path (offer `SendUserFile` if useful). Do **not** commit
   unless asked.

## Notes & fallbacks

- **Font error `font fallback list must not be empty`** — the fonts named in the
  template are missing. List what typst sees with `typst fonts`, then swap
  `mainfont`/heading fonts in a copy of the template. DejaVu Sans / Noto Sans /
  Liberation are safe defaults.
- **One-off tweaks** (different paper, margins, colors): copy `print-a4.typ`
  next to the document, edit it there, and point `--template` at the copy —
  leave the skill's template canonical.
- **Missing `pandoc`/`typst`**: they belong in `~/.config/home-manager/home.nix`
  (`home.packages`); add them and run
  `home-manager switch --flake ~/.config/home-manager#larsski`.
- This skill is for prose/technical docs. For Word output use **docx**, for
  slides use **pptx**.
