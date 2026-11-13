#!/bin/bash
# vpsay のデフォルトプリセットからナレーターを調べ、そのナレーターの口調ファイルを出力する。
# SKILL.md の読み込み時に実行され、出力がスキル本文に埋め込まれる。
# 失敗するとスキルの読み込み自体が中断されるため、常に終了コード 0 で終わる。

dir="$(cd "$(dirname "$0")/.." && pwd)"
characters="$dir/characters"

if ! command -v vpsay >/dev/null 2>&1; then
  echo "**警告**: vpsay コマンドが見つかりません。読み上げはできないため、ユーザーに vpsay のインストールを依頼してください。"
  exit 0
fi

# 例: "  karin-custom - Natsuki Karin (hightension=10,sasayaki=20, pitch=25, speed=120) (default)"
line="$(vpsay --list-presets 2>/dev/null | grep ' (default)$' | head -n 1)"
narrator="$(printf '%s' "$line" | sed -e 's/^  [^ ]* - //' -e 's/ ([^()]*) (default)$//')"

if [ -z "$narrator" ]; then
  echo "**警告**: vpsay の default_preset が設定されていないか、presets に一致する名前がありません。このままでは \`vpsay --bg \"...\"\` が失敗します。"
  echo "ユーザーに ~/.config/vpsay/config.toml の default_preset 設定を依頼してください。それまでは汎用の口調で報告文を考えます。"
  echo
  cat "$characters/_generic.md"
  exit 0
fi

echo "現在のナレーター: **$narrator**（vpsay のプリセット: \`${line#  }\`）"
echo
if [ -f "$characters/$narrator.md" ]; then
  cat "$characters/$narrator.md"
else
  echo "このナレーター専用の口調ファイルはありません。汎用の口調を使います。"
  echo
  cat "$characters/_generic.md"
fi
exit 0
