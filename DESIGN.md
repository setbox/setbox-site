# Design Reference - Setbox Serviços Digitais

Análise visual baseada em https://entire.io (referência editorial), adaptada para identidade Setbox.

---

## Identidade Visual

**Filosofia:** Editorial minimalista. Swiss/International typographic style. Quase zero ornamento, todo o trabalho estético é feito por tipografia, espaçamento e uso cirúrgico da cor de destaque.

**Logo:** `assets/setbox-lockup.svg` (cubo em três tons + "Setbox" em Manrope SemiBold). Área de proteção: metade da altura do cubo em volta do logo. Regras completas da marca em `base_conhecimento/identidade-visual.md`.

**Paleta:**

| Token | Valor | Uso |
|---|---|---|
| `bg` | `#FAFAFA` | Fundo de todas as páginas |
| `bg-alt` | `#F7F7F7` | Fundo de seções alternadas (hero, carreira) |
| `text` | `#111111` | Texto primário |
| `text-muted` | `#555555-#888888` | Texto secundário, subtítulos |
| `border` | `#E5E5E5` | Divisores, bordas de card |
| `brand` | `#FB0D1C` | Vermelho Setbox: logo, borda de card no hover, ícones, fundo de impacto. Nunca botão nem texto pequeno (4,06:1 com branco) |
| `accent` | `#AF0914` | Vermelho 30p: botões, links, labels, bullets, link ativo no nav (7,31:1 com branco) |
| `accent-hover` | `#8C0710` | Hover de botões vermelhos |
| `accent-dark` | `#E10C19` | Botão sobre fundo escuro (#111111), hover `#D00B18` |

---

## Tipografia

**Font stack:** Manrope via Google Fonts (pesos 300-800), fonte oficial da marca. Sem serifa em todos os elementos.

### Escala

| Nível | Tamanho | Peso | Uso |
|---|---|---|---|
| Display | 48-52px | 800 | H1 de páginas internas |
| H2 | 26-38px | 700 | Títulos de seção |
| H3 | 20-22px | 600 | Subtítulos, cabeçalhos de card |
| Body | 15-17px | 400 | Parágrafos, descrições |
| Small / Meta | 13px | 400-500 | Labels, bullets, células de tabela |
| Nav | 14px | 400 | Links de navegação |
| Caption | 12px | 400 | Footer, legendas, copyright |
| Label | 11px | 600 | Labels de seção (uppercase, tracking-wide) |

### Labels de seção

```html
<p class="text-[11px] text-[#AF0914] font-semibold tracking-wide uppercase mb-3">Label</p>
```

---

## Layout e Grid

**Max width:** `max-w-5xl` (~1024px) para a maioria das seções. `max-w-4xl` para heroes. `max-w-3xl` para CTAs centrados.

**Padding horizontal:** `px-4 md:px-8`

**Alinhamento:** `mx-auto`. Hero sections: `text-center`. Seções de conteúdo: `grid grid-cols-1 md:grid-cols-2 gap-10 md:gap-16`.

---

## Espaçamento Vertical

| Contexto | Classe Tailwind |
|---|---|
| Entre seções principais | `py-16 md:py-24` |
| Hero (topo da página) | `pt-16 md:pt-24 pb-14 md:pb-20` |
| H1 → parágrafo | `mb-6` |
| Parágrafo → CTA | `mb-8 md:mb-10` |
| Label → H2 | `mb-3` → `mb-5` |

---

## Componentes

### Navbar

```
[Logo Setbox]    Produtos  Serviços  Divisões  Sobre  [Falar conosco ▶]
```

- Sticky top, `bg-[#FAFAFA]`, `border-b border-[#E5E5E5]`, `h-14`, `z-50`
- Links: `text-sm text-[#111111] hover:opacity-50 transition-opacity`, `hidden md:block`
- Link ativo: `text-[#AF0914] font-medium` (sem hover)
- Botão "Falar conosco": `bg-[#AF0914] text-white px-4 py-1.5 rounded-[6px] hover:bg-[#8C0710]`

### Botão Primário

```css
background: #AF0914;
color: #fff;
border-radius: 6px;
padding: 12px 24px;
font-size: 14px;
font-weight: 600;
```

```html
<a href="mailto:contato@setbox.com.br" class="inline-block text-[14px] bg-[#AF0914] text-white px-6 py-3 rounded-[6px] hover:bg-[#8C0710] transition-colors font-semibold">CTA →</a>
```

### Link Inline / "Acessar site"

```html
<a href="..." class="inline-flex items-center gap-2 text-[14px] text-[#AF0914] font-medium hover:opacity-70 transition-opacity">Acessar site →</a>
```

### Card

```html
<div class="border border-[#E5E5E5] rounded-xl bg-white p-6">...</div>
```

### Card de Logo (clicável, com hover)

Usado em divisoes.html e produtos.html. O card inteiro é um link; hover escala a imagem.

```html
<a href="https://exemplo.com" target="_blank" class="border border-[#E5E5E5] rounded-xl bg-white p-8 flex items-center justify-center group">
  <img src="assets/logo.png" alt="Nome" class="max-h-24 w-auto transition-transform group-hover:scale-105" loading="lazy" width="W" height="H">
</a>
```

### Bullets com seta vermelha

```html
<ul class="space-y-3">
  <li class="flex gap-3 text-[14px] text-[#444444]">
    <span class="text-[#AF0914] flex-shrink-0 font-bold">→</span>
    <span>Texto do item</span>
  </li>
</ul>
```

### Divisor de Seção

`border-b border-[#E5E5E5]` na seção. Sem elemento `<hr>` separado.

### Footer

Logo, nome fantasia (Setbox Serviços Digitais), endereço, razão social (SETBOX INFORMATICA LTDA) e CNPJ à esquerda, coluna "Empresa" à direita. Sem status dot, sem coluna Produtos.

```
[Logo Setbox]              Empresa
© 2026 Setbox              Empregos
Av. Carneiro Leão, 563     Open Source
- Zona 01, Maringá / PR    Byte Coração
SETBOX INFORMATICA LTDA
CNPJ 08.889.601/0001-09
```

- Fonte: 12px, `text-[#888888]` nos links, `text-[#BBBBBB]` no bloco esquerdo
- Cabeçalho de coluna: 12px, `font-semibold text-[#111111]`
- Separador topo: `border-t border-[#E5E5E5]`
- Padding: `py-10 md:py-14`

---

## Paletas por marca

Tipografia, layout, espaçamento e componentes são sempre os padrões Setbox acima. Só a paleta de accent muda por marca.

| Marca | Accent | Hover | Contexto |
|---|---|---|---|
| Setbox (site) | `#AF0914` | `#8C0710` | Identidade principal. Todos os produtos próprios herdam. |
| ReDoc | `#AF0914` | `#8C0710` | Produto Setbox. Herda vermelho. |
| Integra Moda | `#AF0914` | `#8C0710` | Produto Setbox. Herda vermelho. |
| Agroprocess | `#3FA110` | `#146E37` | Divisão agro. Paleta Sicredi (verde cooperativo). |
| PJ Park | `#ff3f6e` | `#193044` | Divisão legaltech. Paleta própria (rosa + azul-marinho). |

### Tokens Agroprocess (Sicredi)

| Token | Valor | Uso |
|---|---|---|
| `accent` | `#3FA110` | CTAs, labels de seção, ícones, nav ativo |
| `accent-hover` | `#146E37` | Hover de botões primários |
| `accent-dark` | `#146E37` | Fundo de seção CTA final |
| `accent-lt` | `#F2F9ED` | Fundo de ícone em card, seções sutis |
| `yellow` | `#FFCD00` | Botão de destaque sobre fundo verde escuro |
| `neutral-lt` | `#D7E6C8` | Bordas de cards em seções com fundo verde |
| `neutral` | `#5A645A` | Texto secundário em contexto agro |

Labels de seção Agroprocess: `text-[11px] text-[#3FA110] font-semibold tracking-wide uppercase`

Bullets Agroprocess: `<span class="font-bold flex-shrink-0" style="color:#3FA110;">→</span>`

### Tokens PJ Park

| Token | Valor | Uso |
|---|---|---|
| `accent` | `#ff3f6e` | CTAs, labels de seção, ícones, nav ativo, links |
| `accent-hover` | `#193044` | Hover de botões (inverte para navy) |
| `dark` | `#193044` | Fundo de seções hero escuras, header, footer |
| `dark-secondary` | `#2b4153` | Botões secundários, texto em contexto escuro |
| `bg-muted` | `#f0f4f8` | Fundo de seções alternadas (azul-acinzentado claro) |
| `icon-bg` | `#fff0f4` | Fundo de ícone em card (rosa ultraclaro) |
| `text-on-dark` | `#c7cbcf` | Texto secundário sobre fundo navy |

Labels de seção PJ Park: `text-[11px] font-semibold tracking-wide uppercase" style="color:#ff3f6e;"`

Bullets PJ Park: `<span class="font-bold flex-shrink-0" style="color:#ff3f6e;">→</span>`

---

## Tom Visual Geral

- **Zero decoração:** sem gradientes, sem shadows, sem ilustrações, sem stock photos
- **Hierarquia por tamanho e peso:** cor de destaque usada com parcimônia (labels, bullets, CTAs)
- **Densidade baixa:** uma ideia por bloco, muito espaço entre seções
- **Confiança editorial:** conteúdo fala sozinho, design não grita
