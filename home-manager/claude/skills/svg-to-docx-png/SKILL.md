---
name: svg-to-docx-png
description: >-
  Convert SVG figures into high-resolution, full-page-width PNGs before they go
  into a Word/.docx document. ALWAYS use this when an SVG is headed for a docx —
  whether building a report with pandoc, embedding/replacing a figure, or the
  user hands you a .svg to put in Word. Word-on-web ignores the SVG vector and
  shows the raster fallback, so SVGs must be pre-rasterized at the page content
  width and high DPI. Triggers: "put this svg in the doc", "add the figure",
  "this image looks blurry/pixelated in Word", building any docx that references
  .svg files. Do NOT wait for the user to ask for high-res — it is the default.
---

# SVG → DOCX PNG

Word stores SVGs with a PNG fallback, and **Word-on-web renders the fallback, not
the vector**. So any SVG going into a `.docx` must become a PNG that is (1) as wide
as the page content area and (2) high enough DPI to stay crisp. A 1× raster of the
SVG viewBox looks soft once Word stretches it to full width — that is the failure
this skill prevents.

## The rule

Whenever an SVG is destined for a docx — a pandoc build, a figure swap, or a user
handing you `something.svg` for Word — **convert it first with the script below.**
Full content width, 300 dpi minimum. Never embed a raw SVG and never raster at 1×.

## Command (verified on this machine)

cairosvg and pillow are not in the system Python; run the script through `uv` so
they load in an ephemeral env (no installs needed):

```bash
uv run --with cairosvg --with pillow python3 \
  ~/.claude/skills/svg-to-docx-png/scripts/svg2png.py INPUT.svg --docx TARGET.docx
```

- `--docx TARGET.docx` — reads page size + margins from the docx's `sectPr` and
  sizes the PNG to the **full content width**. This is the normal case.
- `--width-in N` — explicit content width in inches (when there's no docx yet,
  e.g. a pandoc build: compute it from the template, or pass the known value).
- no width flag → A4 portrait / 1″ margins (~6.27″) fallback.
- `--dpi N` — defaults to **300** (print-quality floor). Bump to 600 for figures
  that get zoomed; the ROI matrix at ~600 dpi looked great, the tidslinje at
  ~175 dpi (a 1× render) looked soft.
- `-o OUT.png` — defaults to the SVG path with a `.png` suffix.

Output is `round(width_in × dpi)` px wide, aspect ratio preserved, with the DPI
embedded so pandoc and Word display it at exactly the content width.

## Workflows

**pandoc-built report** (markdown references `.svg`): convert each SVG to a
full-width PNG, point the markdown `![...](figures/x.png)` at the PNG, then build.
Compute width from the template docx with `--docx rapportmal.docx` (or `--width-in`).

**Replacing/inserting a figure in an existing docx:** convert with `--docx
<that file>`, then embed via the docx skill. To swap an already-embedded image,
unpack, overwrite `word/media/imageN.png`, repack (see the `docx` skill). Display
size lives in `document.xml` (EMU) and is independent of pixel count, so a
higher-res PNG of the same aspect ratio just renders sharper.

## Checking what's already embedded

To audit a docx for soft figures, compare each image's pixel width to the content
width: `pixels ÷ content-width-inches` is the effective DPI. Under ~200 means a
near-1× render that needs redoing.

```bash
# list embedded image dimensions
d=$(mktemp -d); unzip -q FILE.docx 'word/media/*' -d "$d"
for f in "$d"/word/media/*; do \
  python3 -c "from PIL import Image; im=Image.open('$f'); print('$(basename $f)', im.size, im.info.get('dpi'))"; \
done; rm -rf "$d"
```
