#!/usr/bin/env bash
#
# Instalador do Loupe — https://setbox.com.br/produtos/loupe/
#
#   curl -fsSL https://setbox.com.br/produtos/loupe/instalar.sh | bash
#
# Por que instalar assim, e não baixando o DMG:
#
# O Loupe não é assinado com Developer ID da Apple. O Gatekeeper só inspeciona
# arquivos marcados com o atributo com.apple.quarantine, e quem grava esse
# atributo é o navegador que fez o download — não o macOS. O curl não grava.
# Instalando por aqui, o app abre normalmente; baixando o DMG pelo navegador, o
# macOS bloqueia a primeira abertura e é preciso liberar em Ajustes do Sistema.
#
# O script confere o SHA-256 do que baixou antes de instalar. Ele não usa sudo
# e não toca em nada fora de /Applications/Loupe.app.
#
# Desinstalar:  curl -fsSL .../instalar.sh | bash -s -- --desinstalar

set -euo pipefail

# Os binários ficam nos Releases do repositório do site da Setbox, que é público.
# Asset de release não entra no histórico do git, então publicar uma versão nova
# não engorda o repositório. O código-fonte do Loupe segue em repo privado.
REPO="setbox/setbox-site"
BASE="https://github.com/$REPO/releases/latest/download"
ARQUIVO="Loupe-macos-universal.tar.gz"
DESTINO="/Applications"
APP="$DESTINO/Loupe.app"

vermelho() { printf '\033[31m%s\033[0m\n' "$*"; }
verde()    { printf '\033[32m%s\033[0m\n' "$*"; }
cinza()    { printf '\033[90m%s\033[0m\n' "$*"; }

erro() { echo ""; vermelho "  $*"; echo ""; exit 1; }

# --------------------------------------------------------------------------
# Desinstalação
# --------------------------------------------------------------------------
desinstalar() {
  echo ""
  if [ ! -d "$APP" ]; then
    erro "Loupe não está instalado em $APP."
  fi
  pkill -x loupe 2>/dev/null || true
  rm -rf "$APP"
  verde "  Loupe removido de $APP"

  local config="$HOME/Library/Application Support/com.setbox.loupe"
  if [ -d "$config" ]; then
    cinza "  Suas preferências continuam em:"
    cinza "    $config"
    cinza "  Para apagar também: rm -rf \"$config\""
  fi
  echo ""
  exit 0
}

[ "${1:-}" = "--desinstalar" ] && desinstalar
[ "${1:-}" = "--uninstall" ] && desinstalar

# --------------------------------------------------------------------------
# Verificações
# --------------------------------------------------------------------------
[ "$(uname -s)" = "Darwin" ] || erro "O Loupe só roda no macOS por enquanto."

for cmd in curl tar shasum; do
  command -v "$cmd" >/dev/null 2>&1 || erro "Comando '$cmd' não encontrado."
done

echo ""
echo "  Instalando o Loupe"
echo ""

TMP=$(mktemp -d)
# Sai limpando o temporário em qualquer caminho, inclusive erro ou Ctrl-C.
trap 'rm -rf "$TMP"' EXIT

# --------------------------------------------------------------------------
# Download
# --------------------------------------------------------------------------
echo "  Baixando..."
curl -fsSL --retry 3 "$BASE/$ARQUIVO" -o "$TMP/$ARQUIVO" \
  || erro "Falha no download. Confira sua conexão ou tente de novo em instantes."

# --------------------------------------------------------------------------
# Integridade
#
# Sem assinatura da Apple, esse checksum é a única verificação que o usuário
# tem de que o arquivo chegou inteiro e é o que o projeto publicou. Se o
# SHA256SUMS não estiver no release, o script para: instalar sem conferir
# seria pior do que não instalar.
# --------------------------------------------------------------------------
echo "  Conferindo integridade..."
curl -fsSL --retry 3 "$BASE/SHA256SUMS" -o "$TMP/SHA256SUMS" \
  || erro "Não foi possível baixar o SHA256SUMS. Instalação cancelada."

(
  cd "$TMP"
  grep " $ARQUIVO\$" SHA256SUMS > esperado.txt 2>/dev/null \
    || { vermelho "  $ARQUIVO não consta no SHA256SUMS."; exit 1; }
  shasum -a 256 -c esperado.txt >/dev/null 2>&1 \
    || { vermelho "  Checksum não confere. O arquivo pode estar corrompido."; exit 1; }
) || erro "Verificação de integridade falhou. Nada foi instalado."

# --------------------------------------------------------------------------
# Extração
# --------------------------------------------------------------------------
echo "  Extraindo..."
tar -xzf "$TMP/$ARQUIVO" -C "$TMP"
[ -d "$TMP/Loupe.app" ] || erro "O pacote não contém Loupe.app."

# O tar não grava quarentena, mas se o usuário tiver baixado o .tar.gz pelo
# navegador antes de rodar isto, o atributo vem herdado no que foi extraído.
xattr -cr "$TMP/Loupe.app" 2>/dev/null || true

# --------------------------------------------------------------------------
# Instalação
# --------------------------------------------------------------------------
if [ -d "$APP" ]; then
  echo "  Substituindo a versão instalada..."
  pkill -x loupe 2>/dev/null || true
  # Dá um instante para o app encerrar antes de remover o bundle.
  sleep 1
  rm -rf "$APP" || erro "Não foi possível remover $APP. Feche o Loupe e tente de novo."
fi

echo "  Instalando em $DESTINO..."
if ! mv "$TMP/Loupe.app" "$APP" 2>/dev/null; then
  erro "Sem permissão de escrita em $DESTINO.
  Rode com uma conta de administrador, ou instale em ~/Applications:
    mkdir -p ~/Applications && mv \"$TMP/Loupe.app\" ~/Applications/"
fi

VERSAO=$(defaults read "$APP/Contents/Info.plist" CFBundleShortVersionString 2>/dev/null || echo "?")

echo ""
verde "  Loupe $VERSAO instalado em $APP"
echo ""
cinza "  Abra pelo Launchpad, pelo Spotlight, ou com:"
cinza "    open -a Loupe"
echo ""
