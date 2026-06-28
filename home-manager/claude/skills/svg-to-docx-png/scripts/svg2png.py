#!/usr/bin/env python3
"""Convert an SVG into a high-resolution PNG sized to a DOCX's full content width.

Word-on-web renders the PNG fallback, not the SVG vector, and pandoc/Word size a
PNG from its embedded DPI. So an SVG headed for a .docx should become a PNG that is
(a) as wide as the page content area and (b) high enough DPI to stay crisp.

Run it under uv so cairosvg/pillow are available without touching the system env:

    uv run --with cairosvg --with pillow python3 svg2png.py INPUT.svg [options]

Width is resolved to the FULL content width by default, in this order:
    --docx FILE.docx   read page size + margins from FILE's sectPr -> content width
    --width-in N       explicit content width in inches
    (fallback)         A4 portrait, 1-inch margins ~= 6.27 in

Other options:
    -o, --out PATH     output path (default: alongside the SVG, .png)
    --dpi N            target resolution (default: 300; print-quality floor)

The PNG is rendered at round(width_in * dpi) pixels wide (height keeps the SVG
aspect ratio) and the DPI is embedded so Word/pandoc display it at exactly the
content width.
"""
import argparse
import re
import sys
import zipfile
from pathlib import Path

A4_CONTENT_WIDTH_IN = (11906 - 1440 - 1440) / 1440  # A4 portrait, 1" margins


def docx_content_width_in(docx_path: str) -> float:
    """Content width (inches) from the first sectPr: pgSz width minus L/R margins."""
    with zipfile.ZipFile(docx_path) as z:
        xml = z.read("word/document.xml").decode("utf-8", "replace")
    pgsz = re.search(r"<w:pgSz\b[^>]*\bw:w=\"(\d+)\"", xml)
    pgmar = re.search(r"<w:pgMar\b[^>]*>", xml)
    if not pgsz or not pgmar:
        raise ValueError(f"No sectPr page geometry found in {docx_path}")
    width = int(pgsz.group(1))
    left = int(re.search(r'w:left="(\d+)"', pgmar.group(0)).group(1))
    right = int(re.search(r'w:right="(\d+)"', pgmar.group(0)).group(1))
    return (width - left - right) / 1440.0


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("svg", help="input .svg")
    ap.add_argument("-o", "--out", help="output .png (default: SVG path with .png)")
    g = ap.add_mutually_exclusive_group()
    g.add_argument("--docx", help="docx whose content width to match (full width)")
    g.add_argument("--width-in", type=float, help="explicit content width in inches")
    ap.add_argument("--dpi", type=int, default=300, help="target DPI (default 300)")
    args = ap.parse_args()

    svg = Path(args.svg)
    if not svg.is_file():
        print(f"error: no such SVG: {svg}", file=sys.stderr)
        return 1
    out = Path(args.out) if args.out else svg.with_suffix(".png")

    if args.width_in:
        width_in, src = args.width_in, "explicit"
    elif args.docx:
        width_in, src = docx_content_width_in(args.docx), f"docx:{args.docx}"
    else:
        width_in, src = A4_CONTENT_WIDTH_IN, "A4 fallback"

    px_w = round(width_in * args.dpi)

    import cairosvg
    from PIL import Image

    cairosvg.svg2png(url=str(svg), write_to=str(out), output_width=px_w, dpi=args.dpi)
    # Re-stamp DPI metadata so Word/pandoc size the image to the content width.
    im = Image.open(out)
    im.save(out, dpi=(args.dpi, args.dpi))

    print(f"{svg.name} -> {out}  ({im.size[0]}x{im.size[1]} px, {args.dpi} dpi, "
          f"width {width_in:.2f}in via {src})")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
