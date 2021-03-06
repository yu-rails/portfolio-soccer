# サカキロ

### 《サッカーに関する練習記録をユーザーが共有するアプリ》

https://polar-fjord-98663.herokuapp.com

ログイン自由なゲストユーザーアカウント

ユーザーID：guest

パスワード：password


## 1. アプリケーションの概要

　父親が監督を務めるサッカー少年団の子供たちが友達と切磋琢磨できるようなアプリを目標とした.毎日のリフティングの最高回数を記録したり,自分の練習メニューを投稿したり,友達の練習メニューをクリアして努力をアピールできる.コーチが練習メニューを投稿して,どの子供たちがクリアしたか管理することもできる.

　小学生の子供たちでも簡単かつ安全に使えるよう,アプリのログインにメールアドレスは必要なしとした.


## 2. アプリケーションで使っている技術

・インフラ　→　heroku

・データベース　→　PostgreSQL

・開発環境　→　Visual Studio Code

・言語　→　Ruby on Rails, JavaScript, Slim, Scss


## 3. アプリケーションの機能

### ユーザ

・ユーザのCreate,Update機能　→　user

・ユーザのログイン,ログアウト機能　→　session

・登録の実行前に確認画面を挟む

・編集にはパスワードの確認を必要とする　→　authenticate

・アイコンの画像を変更する機能　→　gem 'carrierwave'

・所在地に登録された都道府県の「今日」「明日」「明後日」の天気,最高気温,最低気温を表示する機能　→　OpenWeatherMapAPI


### リフティング

・リフティングの記録のCRUD機能　→　lifting

・記録を一日一回に限定する

・記録したリフティングの回数で最高記録を表示する機能　→　maximum


### トレーニング

・トレーニングメニューのCreate,Read,Destroy機能　→　training

・設定した終了予定日になると一覧から消え,クリアもできなくなる機能(明日から10日以内まで設定可能)

・フォームで入力した改行を反映させる機能　→　safe_join

・トレーニング内容に含まれるURLをリンクとして表示する機能　→　gem 'rails_autolink'

・ユーザ名,タグ名,終了予定日で検索できる機能　→　gem 'ransack'

・クリアしたユーザの数,名前,投稿したユーザ自身がクリアしているかどうか分かる機能　→　clear

・ユーザがこれまでに投稿したトレーニングメニュー,クリアしたトレーニングメニューがユーザページに表示される


### お気に入り

・他のユーザをお気に入りに登録し,ユーザページに飛びやすくする(他ユーザページの名前の横の星)　→　favorite

・お気に入りに登録したユーザの一覧（他ユーザには見えない）


### その他

・ページネーション機能　→　gem 'kaminari'

・クリアとお気に入りのCreate,Destroy機能でページ遷移を行わない機能　→　Ajax


## 4. 理想する使い方の例

・サッカーチームで共通のタグ名を使い,自分のチームの投稿のみを検索する

