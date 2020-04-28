![introduction](https://user-images.githubusercontent.com/59280290/80301821-49934100-87e1-11ea-8b15-d38c5969c74c.gif)

<h2 align="center">DTODO</h2>
<h3 align="center">Frontend</h3>

<p align="center">
  <a href="https://jp.vuejs.org/index.html"><img src="https://user-images.githubusercontent.com/39142850/71645835-a98d4580-2d21-11ea-9693-348d12101bb4.png" width="80px;" /></a>
  <a>　</a>
  <a href="https://ja.nuxtjs.org/guide/"><img src="https://user-images.githubusercontent.com/59280290/80292478-f645d200-8791-11ea-9a0b-57ec5a7ec487.png" height="80px" /></a>
<a>　</a>
    <a href="https://firebase.google.com/"><img src="https://user-images.githubusercontent.com/59280290/80302028-90356b00-87e2-11ea-854c-c234307f3299.png" height="80px;" /></a></p>

<h3 align="center">Backend</h3>
<p align="center">
<a>　</a>
  <a href="https://rubyonrails.org/"><img src="https://user-images.githubusercontent.com/59280290/80292396-7a4b8a00-8791-11ea-8d8a-effea8a1f485.png" height="45px;" /></a>
<a>　</a>
  <a href="https://aws.amazon.com/jp/?nc2=h_lg"><img src="https://user-images.githubusercontent.com/59280290/80302130-2ec1cc00-87e3-11ea-813c-dcdb51a02af5.png" height="45px;" /></a>
<a>　</a>
  <a href="https://www.mysql.com/jp/"><img src="https://user-images.githubusercontent.com/59280290/80302176-6cbef000-87e3-11ea-9643-1f4b446dfaa8.png" height="45px;" /></a>

<h3 align="center">Test (frontend/backend)</h3>
<p align="center">
  <a href="https://jestjs.io/ja/"><img src="https://user-images.githubusercontent.com/59280290/80302231-caebd300-87e3-11ea-9d0d-fdcedb301027.png" width="80px;" height="80px;" />　　</a>
    <a href="https://github.com/rspec/rspec-rails"><img src="https://user-images.githubusercontent.com/59280290/80302256-e22ac080-87e3-11ea-9355-1d703e345f02.png" height="80px;" /></a></p>

## :mortar_board: Overview
ゲーミフィケーションを取り入れたタスク管理SPA

## :chart_with_upwards_trend: Purpose
- 日々の大変な・後回しにしがちなタスクをより楽しく行ってもらうため  
- やるべきことも、ご褒美も自分で決める経験をしてもらうため  
- 自分の生きがいである「力をつけ続けること」をアプリを通じて表現するため

## :pencil2: Description
・TODO管理  
・タスクポイント  
・ごほうび  
・レベルアップ＆経験値アップ  

## :skull: App URL

**https://horikoshi-yuki.work** 
　
## 💬 Usage

### 1.TODO管理について
自分のやるべきタスクをTODOとして登録することができます。登録の際には取り組む難易度ごとに「タスクポイント」を設定することができます。難しいタスクほど大きなタスクポイントを設定してみましょう。  

### 2.タスクポイントについて
TODOを達成するとタスクポイント（以下TP）をもらうことができます。貯まったTPは実際に皆さんが生活する世界で使える「ごほうび」の解放に使用することができます。

### 3.ごほうびについて
解放（使える状態にする）に必要なタスクポイントを設定して、TODOを達成した自分へのご褒美を設定することができます。

### 4.経験値について
TODOをこなすたびにユーザーには経験値が与えられ、レベルアップしていきます。最大レベルの10を目指して日々のタスクを楽しみながらこなしていきましょう。

 <br><br>

## 📦 Features

<h3 align="center">- Responsive design -</h3>

<p align="center">
<img src ="https://user-images.githubusercontent.com/59280290/80267290-e1f2ce00-86da-11ea-9273-6c5194f70736.PNG" height="550px">
<br> <br>
<img src ="https://user-images.githubusercontent.com/59280290/80267297-e6b78200-86da-11ea-85ce-54b1e2bce3dd.PNG" height="550px">
</p>


- TODO&Rewardのドラッグ&ドロップ機能（リロードしても順番を維持）
- ごほうびの解放、未解放状態の変化
- FirebaseAuthによるログイン認証
- シングルページアプリケーション設計による快適な操作感
- フロントエンドとバックエンドを分離させた開発手法

## :computer: Version
setup  
Ruby: 2.6.3  
Rails 6.0.2.2  
Bundler version 2.1.4  
Node: 12.16.2  
npm: 6.14.4  
mysql: 5.7.2.2  

web server  
nginx: 1.16.1

application server  
puma: 4.3.3

frontend  
@nuxt/core@2.12.2  
@babel/core@7.9.0  
@vue/test-utils@1.0.0-beta.33  
@nuxtjs/axios@5.9.7  
jest@25.3.0  
vuex@3.1.3  
vuedraggable@2.23.2  
firebase@7.13.1  
vue-typer@1.2.0

backend  
rack-cors: 1.1.1  
gem 'mysql2'  

  
ER  
https://drive.google.com/file/d/1-wCdOxrMf7JH9MOPJb7xGWlWaX72ESkH/view?usp=sharing  

List of Features  
https://docs.google.com/spreadsheets/d/10EkgefVrWOcUwnqEYp09vCmVcveE4DfNdiKm0f2-4Qg/edit?usp=sharing  

## 👀 Author

Yuki Horikoshi
- [Github](https://github.com/yuki-snow1823)
- [Twitter](https://twitter.com/yuki82511988)
- [Qiita](https://qiita.com/yuki_snow1823/items/fa70ce035962ed5bd34d)
