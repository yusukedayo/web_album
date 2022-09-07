<h1>Web卒アル</h1>

### [サービスリンク](https://web-album.herokuapp.com)
### [公式Twitter](https://twitter.com/web_album)

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

## ER図
<a href="https://gyazo.com/45bad3718d10fea03ecc7e123c65cfcd"><img src="https://i.gyazo.com/45bad3718d10fea03ecc7e123c65cfcd.png" alt="Image from Gyazo" width="710"/></a>


## インフラ構成図
[![Image from Gyazo](https://i.gyazo.com/9370b028b6645f7182e9d92f477b4261.png)](https://gyazo.com/9370b028b6645f7182e9d92f477b4261)

<br>

## 使い方
1. アルバム名・招待したいユーザー・写真を選択して作成する
2. アルバム内で寄せ書き・メンバーとの思い出のイベント・身内ランキング・サプライズメッセージを投稿できます
3. メンバーの詳細ページにはそのメンバーが写っている写真だけを取得して表示できます
4. 投稿された写真の中から特定の感情の度合いが高い写真を集めてランキングとイベントを自動で作成することができます

<br>

## 機能紹介

### アルバム作成機能
<div align="center">
<img src="https://i.gyazo.com/e2e5b842590266ad8562f96e553d6687.png" width="60%">
</div>
アルバム名・招待するユーザー・写真を投稿するだけ↓のようなアルバムページが生成されます。
<div align="center">
<img src="https://i.gyazo.com/935ed886cd08d59c3011f2b24c98e836.jpg" width="60%">
</div>

### 写真自動識別機能
Amazon Rekognitionの顔識別を使用してアルバムに投稿された写真の中からこのページメンバーが写った写真だけを取得できます。
<div align="center">
<img src="https://i.gyazo.com/4ec31b45930bef196ccb6e56532d337c.jpg" width="60%">
</div>

### イベント作成・自動作成機能
アルバム内で特に印象に残っている思い出をイベントとして作成できます。
また、イベントは自動作成機能がありこれを使うとRekognitionの感情分析で幸福度の高い写真を取得して↓のようにアルバムを自動で作成できます。
<div align="center">
<img src="https://i.gyazo.com/64f387bd642649e159b9efa7199658bd.jpg" width="60%">
</div>

### ランキング作成・自動作成機能
アルバム内で「将来〇〇になりそうな人」や「映え写真」など任意のランキングが作成できます。
ランキングには選択肢を追加でき、投票が行えます。
また、このランキングも自動作成機能がついており幸福度の高い写真を取得してランキングを取得できます。
<div align="center">
<img src="https://i.gyazo.com/f14cbcc0d65886927c7deabc81adfbf9.jpg" width="60%">
</div>

### サプライズメッセージ機能
アルバム内で任意の日時を指定してその日付になると表示されるメッセージを投稿できます。
1年後などに設定しておくとメンバーでまた集まるきっかけになると思います！
<div align="center">
<img src="https://i.gyazo.com/f12c315068306e1af82928ab476a059e.png" width="60%">
</div>

<br>
<br>

### その他の機能


<br>

## 使用技術

#### バックエンド
- Ruby (3.1.2)
- Rails (6.1.6)
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

### インフラ
- heroku
- Amazon S3
- PostgreSQL
- auth0 (LINE,Twitterログイン)
- Circle Ci

#### フロントエンド
- JavaScript
- tailwind
- HTML
- CSS
<br>
<br>

