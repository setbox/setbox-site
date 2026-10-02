# CLAUDE.md

Guidance for Claude Code when working in this repository.

## Development

No build step. Open any `.html` directly or serve with `npx serve .` / `python3 -m http.server 8080`. Tailwind CSS and Manrope load via CDN.

## Architecture

Multi-page static site for **Setbox Serviços Digitais** (setbox.com.br). Pages: `index`, `servicos`, `sobre`, `divisoes`, `produtos`, `404`. All assets are self-contained in `assets/`. See `DESIGN.md` for component patterns.

## Nav

Order: **Produtos | Serviços | Divisões | Sobre | Falar conosco**. Active page link: `text-[#AF0914] font-medium`. Inactive: `text-[#111111] hover:opacity-50 transition-opacity hidden md:block`. On the home page only, the nav is `fixed` over the hero photo: translucent dark glass with white text and the dark-background logo while the photo is behind it, turning solid (current light style) over the last 160 px of scroll before the hero ends, and back on scroll up (script at the end of `index.html`, `--nav-p`/`--nav-t`). Other pages keep the solid sticky nav.

## Footer

Graphite background (`bg-[#111111]`), two rows (same split as the PJ Park footer). Top: links area, a single "Empresa" column (Empregos, Open Source, Byte Coração) in a `grid-cols-2 md:grid-cols-4` grid, heading `text-white`, links `text-[#AAAAAA] hover:text-white`. Bottom, after a `border-t border-[#2A2A2A]`: dark-background logo `assets/setbox-lockup-escuro.svg` (three-tone cube, white text) on the left, legal line and address in `text-[#888888]` on the right ("© 2026 Setbox Serviços Digitais · SETBOX INFORMATICA LTDA · CNPJ" then the address), right-aligned on desktop. No status dot. No products column. `produtos/loupe` keeps its own footer.

## Content Rules

- Language: Brazilian Portuguese
- No trailing period on any title or subtitle (h1-h6)
- Never use em dash anywhere - use hyphen (-) or comma
- All CTAs: `mailto:contato@setbox.com.br`
- Setbox founded 2007, currently 19 years in operation (2026)

## Image Rules

- All `<img>` must have `width`, `height`, and `loading="lazy"` - except nav/footer logos and the home hero background (above fold, uses `fetchpriority="high"`)
- Logo cards (divisoes, produtos): the card container is a `<a>` link; image uses `group-hover:scale-105`
- Client logos: grayscale, color on hover
- Photos: only of Setbox's own office, only as the home hero background (full viewport height, `object-cover`, `bg-black/60` overlay, white text, `alt=""`). Files: `assets/escritorio/escritorio-{768,1280,1920,2752}.webp`, always with `srcset`. No stock photos. See `DESIGN.md` (Tom Visual Geral)

## SEO

Every page needs: `meta[description]`, `link[canonical]`, Open Graph tags (`og:type/site_name/locale/url/title/description/image`), Twitter card. OG image: `assets/og-image.png` (1200x630). Tailwind CDN: add `<link rel="preload" as="script">` before the `<script>` tag.
