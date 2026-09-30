# Setbox Serviços Digitais

Site institucional de setbox.com.br.

## Estrutura

Este diretório (`site/`) contém o site estático publicável. É uma reescrita em HTML puro do site Jekyll original (raiz do repositório), sem dependências de build.

```
site/
├── index.html          - Home
├── servicos.html       - Serviços (Smartsourcing + Consultoria)
├── sobre.html          - Sobre
├── divisoes.html       - Divisões do Grupo Setbox
├── produtos.html       - Produtos
├── 404.html            - Página de erro
├── CNAME               - setbox.com.br (GitHub Pages custom domain)
├── sitemap.xml         - Sitemap para mecanismos de busca
├── robots.txt          - Diretivas de crawlers
└── assets/             - Imagens, ícones, favicons (autocontido)
```

## Desenvolvimento

Sem build. Abrir qualquer `.html` no browser ou servir com:

```bash
npx serve .
# ou
python3 -m http.server 8080
```

Tailwind CSS e Manrope font via CDN.

## Documentação

- `CLAUDE.md` - Guia para Claude Code (arquitetura, convenções, padrões copy-paste)
- `DESIGN.md` - Sistema de design (cores, tipografia, componentes)
