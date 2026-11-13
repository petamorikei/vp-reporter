# VP Reporter スキル

vpsayコマンド（VOICEPEAK）を使用して、作業の進捗状況や結果を音声で報告するClaudeスキルです。
読み上げナレーターに合わせた口調で報告します。

## インストール

### 前提条件

- [VOICEPEAK](https://www.ah-soft.com/voice/)と、使いたいナレーターがインストールされていること
- [vpsay CLI](https://github.com/petamorikei/voicepeak-cli)がインストールされていること
- vpsay の設定ファイル `~/.config/vpsay/config.toml` で `default_preset` が設定されていること

```toml
default_preset = "karin-custom"

[[presets]]
name = "karin-custom"
narrator = "Natsuki Karin"   # vpsay --list-narrator に表示される名前
```

```bash
vpsay --list-presets   # (default) の付いたプリセットのナレーターで読み上げます
```

### Claude Codeへの追加

[GitHub CLI](https://cli.github.com/)の`gh skill`でインストールします（`~/.claude/skills/vp-reporter/`に入ります）：
```bash
gh skill install petamorikei/vp-reporter vp-reporter --agent claude-code --scope user
```

更新：
```bash
gh skill update --all
```

`gh skill`はインストール時にファイルの実行権限を保持しないため、`SKILL.md`はスクリプトを`bash`経由で実行します。

## 使い方

スキルをインストールすると、Claudeが作業中に自動的にvpsayコマンドで音声報告を行います。

```bash
# 使用例（夏色花梨の場合）
vpsay --bg "ビルドを開始するわよ"
vpsay --bg "テストが完了したわよ"
```

- ナレーターを変えるときは、vpsay の `default_preset` を変更します。スキルは読み込み時に vpsay の設定からナレーターを調べ、そのナレーターの口調ファイルを使います。
- 報告のガイドラインなど、スキルの詳細な動作仕様は [SKILL.md](skills/vp-reporter/SKILL.md) を参照してください。

## ナレーターと口調

`skills/vp-reporter/characters/` に口調ファイルがあるナレーター：

- 夏色花梨（`Natsuki Karin`）

それ以外のナレーター（6ナレーターセットなど）は汎用の丁寧な口調（`skills/vp-reporter/characters/_generic.md`）で報告します。

### ナレーターを追加する

`skills/vp-reporter/characters/<vpsay --list-narrator に表示される名前>.md` を作成します（例: `skills/vp-reporter/characters/Natsuki Karin.md`）。
VOICEPEAK のナレーター名は英語表記です。日本語名ではなく、`--list-narrator` の表示どおりのファイル名にしてください。
既存のファイルと同じく、設定・報告での口調・例を書いてください。

## ファイル構成

```
vp-reporter/
├── README.md                     # このファイル
├── LICENSE                       # MITライセンス
└── skills/vp-reporter/           # gh skillがインストールするスキル本体
    ├── SKILL.md                  # スキル定義（読み込み時に現在のナレーターの口調を埋め込む）
    ├── scripts/voice-profile.sh  # vpsayの設定からナレーターを調べ、口調ファイルを出力
    └── characters/               # ナレーターごとの口調ファイル
        ├── _generic.md           # 専用ファイルがないときの汎用口調
        └── Natsuki Karin.md      # 夏色花梨
```

`gh skill`がインストールするのは`skills/vp-reporter/`の中身だけです。

## トラブルシューティング

### vpsayコマンドが見つからない

```bash
which vpsay
```

インストールされていない場合は、[voicepeak-cli](https://github.com/petamorikei/voicepeak-cli)をインストールしてください。

### 音声が再生されない

1. VOICEPEAKとナレーターがインストールされているか確認
2. `vpsay --list-presets` でデフォルトプリセットが設定されているか確認
3. 音量設定を確認

## ライセンス

[MIT License](LICENSE)

VOICEPEAK の各ナレーターには、それぞれの利用規約があります。生成した音声を公開する場合は、各ナレーターの規約に従ってください。

## 関連リンク

- [VOICEPEAK](https://www.ah-soft.com/voice/)
- [voicepeak-cli (vpsay command)](https://github.com/petamorikei/voicepeak-cli)
