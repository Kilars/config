// Self-contained pandoc -> typst template: clean A4 print for technical docs.
// Build: pandoc DOC.md -o DOC.pdf --pdf-engine=typst --template=print-a4.typ \
//          -M title="Running header title"

// Horizontal rules (markdown `---`) collapse to a little breathing room, since
// section headings already carry their own underline.
#let horizontalrule = v(0.4em)

// --- page geometry, running header + footer ------------------------------
#set page(
  paper: "a4",
  margin: (x: 2cm, top: 2.3cm, bottom: 2cm),
  header: context {
    if counter(page).get().first() > 1 {
      set text(size: 8pt, fill: luma(130))
      $if(title)$[$title$]$endif$
      v(-0.4em)
      line(length: 100%, stroke: 0.4pt + luma(205))
    }
  },
  footer: context {
    set text(size: 8pt, fill: luma(130))
    line(length: 100%, stroke: 0.4pt + luma(205))
    v(2pt)
    grid(
      columns: (1fr, auto),
      align: (left, right),
      [$if(title)$$title$$endif$],
      [Side #counter(page).display() av #counter(page).final().first()],
    )
  },
)

// --- body text -----------------------------------------------------------
#set text(
  font: ("Libertinus Serif",),
  size: 10.5pt,
  lang: "nb",
)
#set par(justify: true, leading: 0.62em, spacing: 0.95em)

// --- headings ------------------------------------------------------------
#show heading: set text(font: ("Noto Sans",))
// h1 acts as the on-page document title
#show heading.where(level: 1): it => block(below: 0.9em)[
  #set text(size: 20pt, fill: rgb("#12283a"))
  #it.body
]
#show heading.where(level: 2): it => block(above: 1.5em, below: 0.7em)[
  #set text(size: 13.5pt, fill: rgb("#1a3a5c"))
  #it.body
  #v(-0.35em)
  #line(length: 100%, stroke: 0.6pt + rgb("#c8d4de"))
]
#show heading.where(level: 3): set text(size: 11pt, fill: rgb("#2b4a63"))

// --- links ---------------------------------------------------------------
#show link: set text(fill: rgb("#0b5ca8"))

// --- inline / block code -------------------------------------------------
#show raw: set text(font: ("DejaVu Sans Mono",), size: 9pt)
#show raw.where(block: false): box.with(
  fill: luma(238), inset: (x: 3pt), outset: (y: 3pt), radius: 2pt,
)

// --- blockquotes -> callout boxes ----------------------------------------
#show quote.where(block: true): it => block(
  width: 100%,
  fill: rgb("#fff6e5"),
  stroke: (left: 3pt + rgb("#e8991a")),
  inset: (x: 12pt, y: 10pt),
  radius: 2pt,
  above: 1.1em, below: 1.1em,
  breakable: true,
)[
  #set text(size: 10pt)
  #set par(justify: false)
  #it.body
]

// --- tables --------------------------------------------------------------
#set table(
  inset: 7pt,
  stroke: (_, y) => (
    top: (if y == 0 { 0.9pt } else { 0.4pt }) + luma(185),
    bottom: 0.4pt + luma(185),
  ),
  fill: (_, y) => if y == 0 { rgb("#eef2f5") },
)
#show table.cell.where(y: 0): strong
#show figure.where(kind: table): set block(breakable: true)
#show figure.where(kind: table): set figure.caption(position: top)

$for(header-includes)$
$header-includes$
$endfor$

$body$
