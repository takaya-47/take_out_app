# アプリケーション名
TakeOutApp


# アプリケーション概要
飲食店の皆様はサイトに登録していただくと、お店で提供しているメニューを投稿していただけます。お店の情報やサイト上で提供しているメニューはいつでも編集できますので、ご自身でサイト上の情報を管理していただけます。
一般のお客様については、サイトへの登録無しで登録飲食店様の様々なメニューを注文いただけるようになっています。決済はサイト上で完結させるため、お店では注文料理のお受け取りだけで済むためスムーズです。


# URL
https://take-out-app.herokuapp.com/


# テスト用アカウント
メールアドレス：test@test.com
パスワード：pass1234


# 利用方法
飲食店の皆様はサイトヘッター上の「新規登録」よりサイトに登録いただきますと、メニューの新規投稿が可能です。登録後は店舗情報やメニュー情報の編集、メニューの削除のほか、他店様のメニューであれば料理を注文していただくことも可能です。
一般のお客様については、サイトへの登録不要で各メニューの注文をしていただけます。お好きなメニューをクリックしていただき、「注文する」ボタンより注文画面をお進みください。なお、注文はクレジットカードによる決済となりますのでご準備をお願いします。


# 目指した課題解決
新型コロナウイルス感染症の感染拡大により多くの飲食店の皆さまがお客様の来店機会を失っていることと思います。そうした飲食店様に本サービスに登録いただくことで、Web上で集客やPRが可能になるほか、決済も済ませることができるためお客様のご来店時のリスクも軽減できると考え、本サイトを作成しました。新型コロナによりデジタル化が一気に進んだ気がしていますが、中には急速な社会の変化に付いていくことが難しい飲食店様もいらっしゃるかと思います。そうした飲食店様にとっても簡単にお店の登録ができ、メニューを投稿いただけるシンプルなサービスづくりを心がけました。


# 洗い出した要件
### 店舗の登録・編集機能
サイトに登録するための新規登録機能を実装したほか、ログインやパスワードリセット機能なども実装します。
登録後に店舗側で情報の更新ができるよう編集機能も実装します。
また、新規に登録された店舗はトップページの新着欄に表示されるようにします。

### メニュー投稿・編集機能
サイトに登録後の飲食店の皆さまがお店のメニューを表示できるよう、メニュー投稿機能を実装します。投稿したメニューはトップページに新着順で表示されるほか、各店舗の詳細ページでそのお店が提供しているメニューが確認できるようにします。

### メニュー注文機能
メニューの注文ができるよう注文機能を実装します。支払いも済ませておくことでサイトの利便性を上げるため、クレジットカード決済ができるようにします。
また、注文時に店舗側に注文があったことを知らせるための通知機能を実装します。

### 店舗の場所表示機能
お客様が注文前や注文後に店舗の場所を把握できるようにGoogleマップを用いて地図を掲載します。


# 機能の詳細
### 飲食店の登録
ヘッターの「新規登録」から新規登録していただくと、フラッシュメッセージが表示されて新規登録が完了し、トップページ下部の新着欄に自身の店舗が表示されます。
https://user-images.githubusercontent.com/67499415/111723781-72b03a80-88a7-11eb-9311-f8e3340c1e7a.mp4

### メニュー投稿
ログインしている状態でメニューの新規投稿ができます。投稿されたメニューはトップページに新着順に表示されるほか、各店舗の詳細ページでも確認が可能です。
https://user-images.githubusercontent.com/67499415/111724372-78f2e680-88a8-11eb-9b7a-741bf105bfc6.mp4

### 注文機能
注文にログインは不要で、クレジットカードがあれば誰でも注文できるようになっています。メニューの詳細ページから注文ページに遷移できます。
https://user-images.githubusercontent.com/67499415/111724744-22d27300-88a9-11eb-90c1-9b1481e2ecf8.mp4

注文のあったメニューを提供している店舗に届くメールの内容
<img width="827" alt="ordermail" src="https://user-images.githubusercontent.com/67499415/111724996-92486280-88a9-11eb-8b03-71d54a1d1e30.png">

### 店舗の場所を表示
各店舗の詳細ページでは、掲載されている店舗住所をもとにGoogleマップ上にマーカーを設置しています。これによりユーザーは注文の前後に店舗の場所を正確に確認でき、大変便利です。
https://user-images.githubusercontent.com/67499415/111725552-9c1e9580-88aa-11eb-97cc-054ff70c4d37.mp4


# 今後の実装予定
注文者に注文確認メールを送信する機能が欲しいとの声をいただいているので、今後実装予定です。


# データベース設計
### usersテーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| shop_name          | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| category_id        | integer | null: false               |
| prefecture_id      | integer | null: false               |
| address            | string  | null: false               |
| business_hours     | string  | null: false               |
| holiday            | string  | null: false               |
| phone_number       | string  | null: false               |

##### Association
- has_many :menus

### menusテーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| name    | string     | null: false                    |
| price   | integer    | null: false                    |
| explain | text       | null: false                    |
| user    | references | null: false, foreign_key: true |

##### Association
- belongs_to :user
- has_many :orders

### ordersテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| menu   | references | null: false, foreign_key: true |

##### Association
- belongs_to :menu
- has_one :order_detail

### order_detailsテーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| quantity        | integer    | null: false                    |
| total_price     | integer    | null: false                    |
| last_name       | string     | null: false                    |
| first_name      | string     | null: false                    |
| last_name_kana  | string     | null: false                    |
| first_name_kana | string     | null: false                    |
| prefecture_id   | integer    | null: false                    |
| address         | string     | null: false                    |
| phone_number    | string     | null: false                    |
| visit_day_id    | integer    | null: false                    |
| visit_time_id   | integer    | null: false                    |
| order           | references | null: false, foreign_key: true |

##### Association
- belongs_to :order


# 使用技術
### バックエンド
Ruby, Ruby on Rails

### フロントエンド
HTML, CSS, Sass, JavaScript

### API
Maps JavaScript API, Geocoding API

# データベース
MySQL

# 本番環境
Heroku
※アドオン：Mailgun

# ソース管理
GitHub, GitHub Desktop

# テスト
RSpec

# エディタ
Visual Studio Code