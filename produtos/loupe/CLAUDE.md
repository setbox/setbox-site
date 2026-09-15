# CLAUDE.md

Guidance for Claude Code when working in this repository.

## Development

No build step. Open `index.html` directly or serve with `npx serve .` / `python3 -m http.server 8080`. Tailwind CSS, Inter e JetBrains Mono carregam via CDN.

## Architecture

Landing page estática de página única do **Loupe** (`setbox.com.br/produtos/loupe/`), app desktop Tauri para ler, validar e navegar 16 formatos de dado estruturado (JSON, YAML, TOML, XML/plist, CSV, INI, logfmt, Prometheus, `.env`, JWT, base64 e saída de console de Elixir, Python, Ruby e PHP). Código do app em `../loupe-app` (repo `setbox/loupe-app`). Assets em `assets/`.

Segue o padrão editorial Setbox descrito em `/Users/jackson/workspace/setbox/sites/setbox.github.io/DESIGN.md` (Inter, `max-w-5xl`, `#FAFAFA`, cards `border-[#E5E5E5] rounded-xl bg-white`), com paleta própria do Loupe.

Referência estrutural mais próxima: `sites/setbox.github.io/produtos/redoc/index.html` (outro app desktop).

## Nav

Navbar Setbox (o site vive sob `setbox.com.br/produtos/`), logo `setbox-lateral.png`. Ordem: `[logo Setbox]` | Produtos | Serviços | Divisões | Sobre | `[Baixar →]`.

Link ativo: "Produtos", `font-medium style="color:#8B5CF6;"`.

Todos os links Setbox são absolutos (`https://setbox.com.br/...`) porque o repo é deployado em subpasta de outro site.

## Color Palette (Loupe)

Derivada do ícone do app (vidro roxo com `{ : }`).

| Token | Valor | Uso |
|---|---|---|
| `accent` | `#8B5CF6` | CTAs, labels de seção, ícones, nav ativo |
| `accent-hover` | `#6D3FE0` | Hover de botões primários |
| `accent-dark` | `#4A2FA8` | Texto sobre fundo lilás (strip de anúncio) |
| `dark` | `#1A1830` | Fundo da seção CTA final |
| `bg-muted` | `#F5F3FF` | Fundo de seções alternadas |
| `icon-bg` | `#F1ECFF` | Fundo de ícone em card, strip de anúncio |
| `strip-border` | `#DDD0FF` | Borda do strip de anúncio |
| `text-on-dark` | `#C6C2DA` | Texto secundário sobre fundo escuro |

Labels de seção: `text-[11px] font-semibold tracking-wide uppercase" style="color:#8B5CF6;"`

Bullets: `<span class="font-bold flex-shrink-0" style="color:#8B5CF6;">→</span>`

## App mockup

O hero usa um mockup do app em HTML puro (`.app-mock`), não screenshot: barra de título com semáforo macOS, rail lateral de ações à esquerda (marca, nova aba, abrir, exportar, prettify, expandir, ajuda de JSONPath), barra de abas em pílula com ponto laranja de alteração pendente, painel dividido editor/árvore, input JSONPath e barra de status. O mockup acompanha a UI real do app - o rail substituiu a antiga toolbar superior. Quando houver screenshots reais do app, trocar por `<img>` seguindo o padrão do ReDoc.

Cores do mockup: chave `#8B5CF6`, string `#0F766E`, número `#B45309`, meta `#888888`.

## Content Rules

- Idioma: português do Brasil
- Sem ponto final em título ou subtítulo (h1-h6)
- Nunca usar travessão - usar hífen (-) ou vírgula
- CTA de download: `https://github.com/setbox/loupe-app/releases/latest`
- E-mail de contato: `contato@setbox.com.br`
- A versão citada no site (strip de anúncio, barra de status dos dois mockups e seção de download) precisa acompanhar `version` de `../loupe-app/package.json` e `src-tauri/tauri.conf.json`
- A lista de funcionalidades e a seção `#formatos` precisam acompanhar `../loupe-app/README.md`

## Image Rules

- Todo `<img>` precisa de `width`, `height` e `loading="lazy"` - exceto logos de nav e footer (acima da dobra)

## SEO

Página precisa de `meta[description]`, `link[canonical]`, Open Graph (`og:type/site_name/locale/url/title/description/image`) e Twitter card. `og:site_name` = "Setbox Sistemas Digitais". OG image aponta para `https://setbox.com.br/assets/og-image.png`. Tailwind CDN com `<link rel="preload" as="script">` antes do `<script>`.

## Onde este diretório vive

Este é o diretório final: o conteúdo é servido direto daqui, em
`setbox.com.br/produtos/loupe/`, pelo GitHub Pages deste repositório
(`setbox/setbox-site`, CNAME `setbox.com.br`). **Não há diretório fonte
separado nem passo de build ou rsync** — editar aqui, commitar, pushar.

Até setembro de 2026 existia um `produtos/loupe/loupe-site/` fora deste
repositório, copiado para cá por rsync. Foi removido: as duas cópias divergiam,
e arte não usada voltava ao deploy a cada sincronização. O ReDoc nunca teve essa
separação — esta página agora segue a mesma convenção.

Este `CLAUDE.md` não é servido: o `_config.yml` na raiz do repositório exclui
todo `CLAUDE.md`, `DESIGN.md` e `README.md` da publicação.

## Instalador

O `instalar.sh` ao lado é servido em `setbox.com.br/produtos/loupe/instalar.sh`
e é o que o comando divulgado na página baixa. **Ele é gerado no repositório do
app** (`loupe-app/instalar.sh`) — edite lá e copie para cá, nunca o contrário.

Os binários do Loupe não ficam neste repositório como arquivos versionados: vão
para os **Releases** dele, porque asset de release não entra no histórico do git
(arquivo versionado somaria ~19 MB por versão). Publicar uma versão é `make dist`
no `loupe-app` seguido de:

```sh
gh release create loupe-v<versão> dist-release/* --repo setbox/setbox-site \
  --title "Loupe <versão>" --notes-file NOTAS.md
```

Ao subir versão, conferir as strings do site:
`grep -n '0\.[0-9]\.[0-9]' index.html`
