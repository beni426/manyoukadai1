database schema
task table
| id  | culumn  |  type  |
| --- |---------| -------|
|     | title   | string |
|     | content |  text  |
|     |         |        |
_____________

user table
| id | culumn  | type  |
|----| ------- |-------|
|    |  name   | string|
|    |  email  | string|
|    | passwrod| string|

# Heroku deploy steps
_____________
####  application のディレクトリの直下で操作してください。<br>
git add .コマンドで実行したフォルダ下のすべてのファイルをステージングエリア
に移動しcommitの対象とした後、commitでメッセージをつけてリポジトリに登録します
#####　1.1  $ git add -A
#####　1.2  $ git commit -m'メッセージ'<br>
Herokuにログイン
#####　1.3  $ heroku login<br>
herokuで新しいアプリケーションを作成
#####　1.4  $ heroku create<br>
Herokuでのリポジトリを確認
#####  1.5  $ git remote -v<br>
アセットプリコンパイル,アセットを本番環境で実行できる形式に変換する
#####　1.6  $ rails assets:precompile RAILS_ENV=production<br>
masterブランチからHerokuのmasterブランチにプッシュする時
#####　1.7　$　git push heroku master<br>
masterブランチ以外のブランチからherokuにプッシュする時
#####　　1.7.1　$　git branch で　branch名を確認
#####　　1.7.2　$　git push heroku branch名:master
#### 以上でHerokuでdeployすることができます
------
####  環境構築
Ruby on Rails application that runs on the following software:
_Ubuntu 12.9-0ubuntu0.20.04.1<br>
_Ruby 3.0.1<br>
_Ruby on Rails 6.0.4<br>
_psql (PostgreSQL) 12.9<br>
_Gem 3.2.15<br>
_Yarn 1.22.17<br>
*****
