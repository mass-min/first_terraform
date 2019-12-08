# first_terraform

## 環境
Terraform v0.12.16
provider.aws v2.40.0

## 概要
GAOGAOアドベントカレンダー2019/12/03分の記事、[【爆速Terraform入門】AWS環境をコードで管理してみよう](https://qiita.com/mass-min/items/27a071ffa346ce05ed29)のおまけです。

## やっていること
- Terraformで以下を作成
  - セキュリティグループ
  - EC2インスタンス
- EC2インスタンスにNginxをインストールし起動

## 注意
- sshキー名はtest_terraformで作成しています
- pemファイルの置き場所は `~/.ssh/`にしています
