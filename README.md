# VP Reporter スキル

vpコマンド（VOICEPEAK）を使用して、作業の進捗状況や結果を音声で報告するClaudeスキルです。

## インストール

### 前提条件

- [VOICEPEAK](https://www.ah-soft.com/voice/6nare/)がインストールされていること
- [vp CLI](https://github.com/petamorikei/voicepeak-cli)がインストールされていること

vpコマンドのインストール確認：
```bash
vp -h
```

### Claude Codeへの追加

プラグインとして追加：
```bash
/plugin add <path-to-vp-reporter>
```

または、`~/.claude/skills/`ディレクトリにコピー：
```bash
rsync -av --exclude='.git' --exclude='.DS_Store' . ~/.claude/skills/vp-reporter/
```

## 使い方

スキルをインストールすると、Claudeが作業中に自動的にvpコマンドで音声報告を行います。

```bash
# 使用例
vp "ビルドを開始するわよ"
vp "テストが完了したわよ"
vp "エラーが発生したわよ。モジュールの依存関係に問題があるみたいね"
```

報告のガイドラインや口調のルールなど、スキルの詳細な動作仕様は [SKILL.md](SKILL.md) を参照してください。

## ファイル構成

```
vp-reporter/
├── SKILL.md              # スキル定義ファイル（動作仕様・ガイドライン）
├── README.md             # このファイル（インストール・使い方）
├── LICENSE               # MITライセンス
└── examples/             # 報告文例集
    ├── task_start.md     # タスク開始時の報告例
    ├── progress.md       # 進捗報告例
    ├── completion.md     # 完了報告例
    └── error.md          # エラー報告例
```

## トラブルシューティング

### vpコマンドが見つからない

```bash
which vp
```

インストールされていない場合は、[voicepeak-cli](https://github.com/petamorikei/voicepeak-cli)をインストールしてください。

### 音声が再生されない

1. VOICEPEAKがインストールされているか確認
2. 音量設定を確認

## ライセンス

[MIT License](LICENSE)

## 関連リンク

- [VOICEPEAK](https://www.ah-soft.com/voice/6nare/)
- [voicepeak-cli (vp command)](https://github.com/petamorikei/voicepeak-cli)
