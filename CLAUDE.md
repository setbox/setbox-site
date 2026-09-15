# CLAUDE.md

Guidance for Claude Code when working in this repository.

## Development

No build step. Open any `.html` directly or serve with `npx serve .` / `python3 -m http.server 8080`. Tailwind CSS and Inter load via CDN.

## Architecture

Multi-page static site for **Setbox Sistemas Digitais** (setbox.com.br). Pages: `index`, `servicos`, `sobre`, `divisoes`, `produtos`, `404`. All assets are self-contained in `assets/`. See `DESIGN.md` for component patterns.

## Nav

Order: **Produtos | Serviços | Divisões | Sobre | Falar conosco**. Active page link: `text-[#FB0D1C] font-medium`. Inactive: `text-[#111111] hover:opacity-50 transition-opacity hidden md:block`.

## Footer

Logo + address block on the left. Single "Empresa" column on the right (Empregos, Open Source, Byte Coração). No status dot. No products column.

## Content Rules

- Language: Brazilian Portuguese
- No trailing period on any title or subtitle (h1-h6)
- Never use em dash anywhere - use hyphen (-) or comma
- All CTAs: `mailto:contato@setbox.com.br`
- Setbox founded 2007, currently 19 years in operation (2026)

## Image Rules

- All `<img>` must have `width`, `height`, and `loading="lazy"` - except nav/footer logos (above fold)
- Logo cards (divisoes, produtos): the card container is a `<a>` link; image uses `group-hover:scale-105`
- Client logos: grayscale, color on hover

## SEO

Every page needs: `meta[description]`, `link[canonical]`, Open Graph tags (`og:type/site_name/locale/url/title/description/image`), Twitter card. OG image: `assets/og-image.png` (1200x630). Tailwind CDN: add `<link rel="preload" as="script">` before the `<script>` tag.
