<h1>Web卒アル</h1>

## [サービスリンク](https://web-album.herokuapp.com)

## 概要
#### 写真を投稿してもらうだけで卒業アルバムページを作成することができるサービスです。
#### 顔識別による自動写真振り分けもできるので思い出の新しい保管方法としてぜひご活用ください！

<br>

<details>
<summary>このアプリが解決する課題</summary>
『 大学を卒業したけど卒業アルバムが高くて買えない 』<br>
『 卒業アルバムの内容を自分好みにカスタマイズしたい 』<br>
『 普段の思い出もアルバムの形にして残したい 』<br>
などの課題が解決できます！
<br>
<br>

私自身も写真を見返すアルバムというサービスが好きです。<br>
しかし、卒業アルバムやフォトブックはアナログで高価であるという問題があり気軽に作成できるものではありませんでした。<br>
このアプリを使って貰い、少しでも多くの人がアルバムを手軽に作れるきっかけになれると嬉しいです。

</details>


<br>

## 使い方
1. アルバム名・招待したいユーザー・写真を選択して作成する
2. アルバム内で寄せ書き・メンバーとの思い出のイベント・身内ランキング・サプライズメッセージを投稿できます
3. メンバーの詳細ページにはそのメンバーが写っている写真だけを取得して表示できます
4. 投稿された写真の中から特定の感情の度合いが高い写真を集めてランキングとイベントを自動で作成することができます

<br>

## 機能紹介

### メイン機能


<br>


<br>

### その他の機能


<br>

## 使用技術

#### バックエンド
- Ruby (3.1.2)
- Rails (6.1.6)
- auth0 (LINE,Twitterログイン)
- Circle Ci
<br>

<details>
<summary>Gem</summary>
devise ・・・ ユーザー登録機能に使用
  
fog-aws ・・・ 投稿された画像をS3にアップロードするために使用

aws-sdk-rekognition ・・・ 画像の人物識別・感情分析に使用

sidekiq ・・・ active jobを実行するために使用

rubocop ・・・ Railsのコード最適化に使用

administrate ・・・ 管理画面の構築に使用

omniauth-auth0 ・・・ auth0によるSNS認証ログインのために使用

</details>

<br>

#### フロントエンド
- JavaScript
- tailwind
- HTML
- CSS
<br>

<br>

### インフラ
- heroku
- Amazon S3
- PostgreSQL

<br>

## ER図
<a href="https://gyazo.com/45bad3718d10fea03ecc7e123c65cfcd"><img src="https://i.gyazo.com/45bad3718d10fea03ecc7e123c65cfcd.png" alt="Image from Gyazo" width="710"/></a>

## その他
<br>
